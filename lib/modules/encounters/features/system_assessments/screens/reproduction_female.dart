import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_female.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/reproduction_female_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/Insurance/screens/guarantor_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/Insurance/screens/insurance_policies.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class ReproductionFemaleScreen extends StatefulWidget {
  static const routeName = '/reproductionFemale';

  @override
  _ReproductionFemaleScreenState createState() =>
      _ReproductionFemaleScreenState();
}

class _ReproductionFemaleScreenState extends State<ReproductionFemaleScreen> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  var _reproductionFemale = new ReproductionFemaleModel();

  void _updateReproductionFemale(var data) {
    setState(() {
      _reproductionFemale = data as ReproductionFemaleModel;

      if (_reproductionFemale.id != null) {
        _reproductionFemale.reproducationfemaleProblems.forEach((s) {
          _problemsReproductionFemaleCheckBoxValues
              .singleWhere((c) => c.id == s.problemId)
              .value = true;
        });

        _gravidaController.text = _reproductionFemale.gravida.toString();
        _paraController.text = _reproductionFemale.para.toString();
        _describeController.text = _reproductionFemale.comments;

        var lmpDateArray = _reproductionFemale.lmpDate.split("-");

        _lmpDateController.text =
            "${lmpDateArray[1]}/${lmpDateArray[2].substring(0, 2)}/${lmpDateArray[0]}";

        var papDateArray = _reproductionFemale.lastPapSmearDt.split("-");

        _papDateController.text =
            "${papDateArray[1]}/${papDateArray[2].substring(0, 2)}/${papDateArray[0]}";

        _pregnantRadioValue = _reproductionFemale.isPregnant ? 0 : 1;
        if (_reproductionFemale.isPregnant) {
          var dateArray = _reproductionFemale.pregnantEdc.split("-");

          _pregnantEDCDateController.text =
              "${dateArray[1]}/${dateArray[2].substring(0, 2)}/${dateArray[0]}";
        }

        _contraceptionRadioValue = _reproductionFemale.isContraception ? 0 : 1;

        if (_reproductionFemale.isPregnant) {
          _contraceptiveYesDropDownValue =
              _reproductionFemale.contraceptionType.id;
          if (_reproductionFemale.contraceptionType.id == 9) {
            _contraceptiveOtherController.text =
                _reproductionFemale.otherContraceptionType;
          }
        }
      }

      _updated = true;
    });
  }

  TextEditingController _describeController;
  TextEditingController _contraceptiveOtherController;
  TextEditingController _lmpDateController;
  TextEditingController _pregnantEDCDateController;
  TextEditingController _papDateController;
  TextEditingController _paraController;
  TextEditingController _gravidaController;

  int _pregnantRadioValue = -1;
  int _contraceptionRadioValue = -1;

  int _contraceptiveYesDropDownValue = -1;

  _pregnantRadioValueHandler(val) {
    setState(() {
      _pregnantRadioValue = val;
      _reproductionFemale.isPregnant = (val == 0) ? true : false;
    });
  }

  _contraceptionRadioValueHandler(val) {
    setState(() {
      _contraceptionRadioValue = val;
      _reproductionFemale.isContraception = (val == 0) ? true : false;
    });
  }

  @override
  void initState() {
    _describeController = TextEditingController();
    _lmpDateController = TextEditingController();
    _pregnantEDCDateController = TextEditingController();
    _papDateController = TextEditingController();
    _paraController = TextEditingController();
    _gravidaController = TextEditingController();
    _contraceptiveOtherController = TextEditingController();
    bloc.initialize();

    super.initState();
  }

  List<CheckBoxDataModel> _problemsReproductionFemaleCheckBoxValues = [];
  List<CheckBoxDataModel> _birthControlCheckBoxValues = [];

  bool _problemsLoaded = false, _birthControlLoaded = false, _updated = false;

  final bloc = sl<ReproductionFemaleBloc>();

  Widget _problemsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Problems'),
        StreamBuilder<List<ReproductionFemaleLookUpData>>(
            stream: bloc.reproFemaleProblems,
            builder: (context,
                AsyncSnapshot<List<ReproductionFemaleLookUpData>> snapshot) {
              if (snapshot.hasData && !_problemsLoaded) {
                _problemsReproductionFemaleCheckBoxValues =
                    snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _problemsLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _problemsReproductionFemaleCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() => checkBoxVal.value = val),
                        checkBoxVal.value,
                        checkBoxVal.title,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  List<GroupModel> _yesNoRadioValues = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];
  Widget _contraceptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Contraception ?", true),
        Wrap(
          children: _yesNoRadioValues
              .map(
                (val) => RadioButtonCommon(
                  _contraceptionRadioValueHandler,
                  _contraceptionRadioValue,
                  val.text,
                  val.index,
                ),
              )
              .toList(),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 300,
              margin: EdgeInsets.only(left: 16),
              child: (_reproductionFemale.isContraception != null &&
                      _reproductionFemale.isContraception)
                  ? StreamBuilder<
                          List<ReproductionFemaleLookUpDataDescription>>(
                      stream: bloc.birthControlTypes,
                      builder: (context,
                          AsyncSnapshot<
                                  List<ReproductionFemaleLookUpDataDescription>>
                              snapshot) {
                        if (snapshot.hasData && !_birthControlLoaded) {
                          _birthControlCheckBoxValues = snapshot.data.map((d) {
                            return CheckBoxDataModel(
                                d.id, d.description, false);
                          }).toList();

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _birthControlLoaded = true;
                            });
                          });
                        }

                        if (!snapshot.hasData) return Container();

                        return DropdownButton<int>(
                          value: _contraceptiveYesDropDownValue,
                          isExpanded: true,
                          iconSize: 24,
                          underline: Container(
                            color: Colors.black54,
                            height: 1,
                          ),
                          onChanged: (int value) {
                            setState(() {
                              _contraceptiveYesDropDownValue = value;
                              _reproductionFemale.contraceptionType.id = value;
                            });
                          },
                          items: _birthControlCheckBoxValues
                              .map<DropdownMenuItem<int>>((answer) {
                            return DropdownMenuItem<int>(
                              value: answer.id,
                              child: Text(answer.title),
                            );
                          }).toList(),
                        );
                      })
                  : Container(),
            ),
            (_reproductionFemale.isContraception != null &&
                    _reproductionFemale.isContraception &&
                    _contraceptiveYesDropDownValue == 9)
                ? Container(
                    width: 300,
                    margin: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: _optionTextStyle,
                      onChanged: (txt) => setState(() =>
                          _reproductionFemale.otherContraceptionType = txt),
                      controller: _contraceptiveOtherController,
                      decoration: InputDecoration(
                        labelText: "Describe",
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget _pregnantWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Pregnant ?", true),
        Wrap(
          children: <Widget>[
            Wrap(
              children: _yesNoRadioValues
                  .map(
                    (val) => RadioButtonCommon(
                      _pregnantRadioValueHandler,
                      _pregnantRadioValue,
                      val.text,
                      val.index,
                    ),
                  )
                  .toList(),
            ),
            (_reproductionFemale.isPregnant != null &&
                    _reproductionFemale.isPregnant)
                ? Container(
                    width: 300,
                    margin: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: _optionTextStyle,
                      controller: _pregnantEDCDateController,
                      decoration: InputDecoration(
                        labelText: 'EDC',
                        contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        suffixIcon: InkWell(
                          onTap: () async {
                            final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990, 8),
                              lastDate: DateTime(2101),
                            );

                            if (picked != null)
                              setState(() {
                                _pregnantEDCDateController.text =
                                    '${picked.day}/${picked.month}/${picked.year}';
                              });
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.calendar_today,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(9, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<ReproductionFemaleModel>(
                    stream: bloc.reproductionFemaleObservable,
                    builder: (context,
                        AsyncSnapshot<ReproductionFemaleModel> snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateReproductionFemale(snapshot.data);
                        });
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(16),
                          children: <Widget>[
                            GestureDetector(child: CommonText("Last Menstrual Period(LMP)", false),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>InsurancePoliciesWidget()));
                            },),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _lmpDateController,
                              onChanged: (txt) {
                                // todo-Uj add date while updating
                              },
                              decoration: InputDecoration(
                                labelText: 'Choose Date',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    final DateTime picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990, 8),
                                      lastDate: DateTime(2101),
                                    );

                                    if (picked != null)
                                      setState(() {
                                        _lmpDateController.text =
                                            '${picked.month}/${picked.day}/${picked.year}';
                                      });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            CommonText("Para", false),
                            TextFormField(
                              style: _optionTextStyle,
                              keyboardType: TextInputType.number,
                              controller: _paraController,
                              onChanged: (txt) => setState(() =>
                                  _reproductionFemale.para = int.parse(txt)),
                              decoration: InputDecoration(
                                labelText: 'Para',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            CommonText("Gravida", false),
                            TextFormField(
                              style: _optionTextStyle,
                              keyboardType: TextInputType.number,
                              onChanged: (txt) => setState(() =>
                                  _reproductionFemale.gravida = int.parse(txt)),
                              controller: _gravidaController,
                              decoration: InputDecoration(
                                labelText: 'Gravida',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _pregnantWidget(),
                            SizedBox(height: 8),
                            _contraceptionWidget(),
                            SizedBox(height: 16),
                            CommonText("Date Last Pap Smear", false),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _papDateController,
                              decoration: InputDecoration(
                                labelText: 'Choose Date',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                                suffixIcon: InkWell(
                                  onTap: () async {
                                    final DateTime picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990, 8),
                                      lastDate: DateTime(2101),
                                    );

                                    if (picked != null)
                                      setState(() {
                                        _papDateController.text =
                                            '${picked.day}/${picked.month}/${picked.year}';
                                      });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            CommonText("Any problems ?", false),
                            SizedBox(height: 12),
                            _problemsWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (txt) => setState(
                                  () => _reproductionFemale.comments = txt),
                              controller: _describeController,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<ReproducationfemaleProblems> _temp =
                                          [];
                                      _problemsReproductionFemaleCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _temp.add(ReproducationfemaleProblems(
                                              problemId: s.id));
                                      });

                                      _reproductionFemale
                                          .reproducationfemaleProblems = _temp;

                                      bloc.onSavePressed(_reproductionFemale);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.check,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Save',
                                          style: _textStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    color: Color(0XFF048ABF),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () => print('Pressed Cancel'),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.close,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Cancel',
                                          style: _textStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    color: Color(0XFFE15656),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
