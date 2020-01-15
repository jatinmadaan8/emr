import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/gastro_intestinal.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/gastro_intestinal_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class GastrointestinalEliminationScreen extends StatefulWidget {
  static const routeName = '/GastrointestinalEliminationScreen';

  @override
  _GastrointestinalEliminationScreenState createState() =>
      _GastrointestinalEliminationScreenState();
}

class _GastrointestinalEliminationScreenState
    extends State<GastrointestinalEliminationScreen> {
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

  int _bowelSoundRadioValue = -1;
  int _oralMucosaRadioValue = -1;

  _bowelSoundRadioValueHandler(val) {
    setState(() {
      _bowelSoundRadioValue = val;
      _gastroIntestinal.isBowelSounds = (val == 0) ? true : false;
    });
  }

  _oralMucosaRadioValueHandler(val) {
    setState(() {
      _oralMucosaRadioValue = val;
      _gastroIntestinal.isMucosaDry = (val == 0) ? true : false;
    });
  }

  TextEditingController _eternalController;
  TextEditingController _bowelController;
  TextEditingController _dateController;

  bool updated = false;

  var _gastroIntestinal = new GastroIntestinalModel();

  void _updateGastroIntestinal(var data) {
    setState(() {
      _gastroIntestinal = data as GastroIntestinalModel;

      _oralMucosaRadioValue = _gastroIntestinal.isMucosaDry ? 0 : 1;

      _gastroIntestinal.gastrointestinalEternal.forEach((s) {
        _procedureGastroCheckBoxValues[s.eternalId - 1].value = true;
      });

      _eternalController.text = _gastroIntestinal.eternalComments;

      _gastroIntestinal.gastrointestinalBowels.forEach((s) {
        _bowelCheckBoxValues[s.bowelId - 1].value = true;
      });

      _bowelController.text = _gastroIntestinal.bowelComments;

      print(_gastroIntestinal.lastBowelMovementDt);
      // todo date
//      var x = _gastroIntestinal.lastBowelMovementDt.split("-");
//      _dateController.text = '${x[1]}/${x[2].substring(0, 2)}/${x[0]}';

      _bowelSoundRadioValue = _gastroIntestinal.isBowelSounds ? 0 : 1;

      updated = true;
    });
  }

  final bloc = sl<GastroIntestinalBloc>();

  @override
  void initState() {
    _eternalController = TextEditingController();
    _bowelController = TextEditingController();
    _dateController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  List<GroupModel> _oralMucosaRadioValues = [
    GroupModel("Dry", 0),
    GroupModel("Moist", 1),
  ];

  List<GroupModel> _bowelSoundRadioValues = [
    GroupModel("Present", 0),
    GroupModel("Absent", 1),
  ];

  List<CheckBoxDataModel> _procedureGastroCheckBoxValues = [];
  List<CheckBoxDataModel> _bowelCheckBoxValues = [];

  bool _gastroEternalLoaded = false, _gastroBowelLoaded = false;

  Widget _oralMucosaWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Oral mucosa", true),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _oralMucosaRadioValues
              .map(
                (val) => RadioButtonCommon(
                  _oralMucosaRadioValueHandler,
                  _oralMucosaRadioValue,
                  val.text,
                  val.index,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _gastroEternalWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Procedures'),
        StreamBuilder<List<GastroIntestinalDropDown>>(
            stream: bloc.gastroEternal,
            builder: (context,
                AsyncSnapshot<List<GastroIntestinalDropDown>> snapshot) {
              if (snapshot.hasData && !_gastroEternalLoaded) {
                _procedureGastroCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _gastroEternalLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _procedureGastroCheckBoxValues
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

  Widget _gastroBowelWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Bowel", false),
        StreamBuilder<List<GastroIntestinalDropDown>>(
            stream: bloc.gastroBowel,
            builder: (context,
                AsyncSnapshot<List<GastroIntestinalDropDown>> snapshot) {
              if (snapshot.hasData && !_gastroBowelLoaded) {
                _bowelCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _gastroBowelLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _bowelCheckBoxValues
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

  Widget _bowelSoundWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Bowel Sound", false),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _bowelSoundRadioValues
              .map(
                (val) => RadioButtonCommon(
                  _bowelSoundRadioValueHandler,
                  _bowelSoundRadioValue,
                  val.text,
                  val.index,
                ),
              )
              .toList(),
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
                child: SubMenu(4, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<GastroIntestinalModel>(
                    stream: bloc.gastroIntestinalObservable,
                    builder: (context,
                        AsyncSnapshot<GastroIntestinalModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateGastroIntestinal(snapshot.data);
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
                            _oralMucosaWidget(),
                            SizedBox(height: 8),
                            CommonText("Any ?", false),
                            SizedBox(height: 12),
                            _gastroEternalWidget(),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _eternalController,
                              onChanged: (txt) => setState(() =>
                                  _gastroIntestinal.eternalComments = txt),
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _gastroBowelWidget(),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _bowelController,
                              onChanged: (txt) => setState(
                                  () => _gastroIntestinal.bowelComments = txt),
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            CommonText("Date last bowel movement", false),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _dateController,
                              onChanged: (txt) => setState(() =>
                                  _gastroIntestinal.lastBowelMovementDt = txt),
                              decoration: InputDecoration(
                                labelText: 'Date',
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
                                        _dateController.text =
                                            '${picked.month}/${picked.day}/${picked.year}';
                                      });
                                  },
                                  child: Icon(
                                    Icons.date_range,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            _bowelSoundWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<GastrointestinalEternal> _temp = [];
                                      List<GastrointestinalBowels> _temp1 = [];

//                                      _gastroIntestinal.gastrointestinalEternal.forEach((s) {
//                                        _procedureGastroCheckBoxValues[s.eternalId - 1].value = true;
//                                      });

                                      _procedureGastroCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _temp.add(
                                            GastrointestinalEternal(
                                                eternalId: s.id),
                                          );
                                      });

                                      _gastroIntestinal
                                          .gastrointestinalEternal = _temp;

                                      _bowelCheckBoxValues.forEach((s) {
                                        if (s.value)
                                          _temp1.add(
                                            GastrointestinalBowels(
                                                bowelId: s.id),
                                          );
                                      });

                                      _gastroIntestinal
                                          .gastrointestinalEternal = _temp;
                                      _gastroIntestinal.gastrointestinalBowels =
                                          _temp1;

                                      bloc.onSavePressed(_gastroIntestinal);
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
                                    onPressed: () => print('Pressed Save'),
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

// todo-Uj check required, send date in a format, and get date while _updateGastroIntestinal().
