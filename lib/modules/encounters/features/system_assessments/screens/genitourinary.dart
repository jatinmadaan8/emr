import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/genitourinary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/genitourinary_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';
import 'package:provider/provider.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import '../providers/system_assessments_questions.dart';

class GenitourinaryScreen extends StatefulWidget {
  static const routeName = '/genitourinary';

  @override
  _GenitourinaryScreenState createState() => _GenitourinaryScreenState();
}

class _GenitourinaryScreenState extends State<GenitourinaryScreen> {
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

  int _urineColorRadioValue = 0;

  List<CheckBoxDataModel> _urineColorRadioValues = [];
  List<CheckBoxDataModel> _urineCathetersCheckBoxValues = [];
  List<CheckBoxDataModel> _bladderSymptomsCheckBoxValues = [];

  TextEditingController _cathetersController,
      _colorController,
      _bladderController;

  final bloc = sl<GenitourinaryBloc>();

  @override
  void initState() {
    _cathetersController = TextEditingController();
    _colorController = TextEditingController();
    _bladderController = TextEditingController();
    bloc.initialize();
    super.initState();
  }

  _urineColorRadioValueHandler(val) {
    setState(() {
      _urineColorRadioValue = val;
      _genitourinary.colorId = val;
    });
  }

  bool urineLoaded = false,
      urineCathetersLoaded = false,
      bladderSymptomsLoaded = false,
      updated = false;

  GenitourinaryModel _genitourinary;

  Widget _urineColorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Urine Color", true),
        StreamBuilder<List<GenitourinaryLookUpModel>>(
            stream: bloc.urineColor,
            builder: (context,
                AsyncSnapshot<List<GenitourinaryLookUpModel>> snapshot) {
              if (snapshot.hasData && !urineLoaded) {
                _urineColorRadioValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    urineLoaded = true;
                  });
                });
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _urineColorRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _urineColorRadioValueHandler,
                        _urineColorRadioValue,
                        val.title,
                        val.id,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _urineCathetersWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Any ?", false),
        SizedBox(height: 12),
        Text('Procedures'),
        StreamBuilder<List<GenitourinaryLookUpModel>>(
            stream: bloc.urineCatheters,
            builder: (context,
                AsyncSnapshot<List<GenitourinaryLookUpModel>> snapshot) {
              if (snapshot.hasData && !urineCathetersLoaded) {
                _urineCathetersCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    urineCathetersLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _urineCathetersCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() {
                          if (checkBoxVal.id == 6 && val) {
                            _urineCathetersCheckBoxValues
                                .forEach((v) => v.value = false);
                          }

                          if (checkBoxVal.id != 6 && val) {
                            _urineCathetersCheckBoxValues
                                .where((v) => v.id == 6)
                                .first
                                .value = false;
                          }

                          checkBoxVal.value = val;
                        }),
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

  Widget _bladderSymptomsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Bladder", false),
        SizedBox(height: 12),
        Text('Symptoms'),
        StreamBuilder<List<GenitourinaryLookUpModel>>(
            stream: bloc.bladderSymptoms,
            builder: (context,
                AsyncSnapshot<List<GenitourinaryLookUpModel>> snapshot) {
              if (snapshot.hasData && !bladderSymptomsLoaded) {
                _bladderSymptomsCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    bladderSymptomsLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _bladderSymptomsCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() {
                          print(checkBoxVal.id);

                          if (checkBoxVal.id == 12 && val) {
                            _bladderSymptomsCheckBoxValues
                                .forEach((v) => v.value = false);
                          }

                          if (checkBoxVal.id != 12 && val) {
                            _bladderSymptomsCheckBoxValues
                                .where((v) => v.id == 12)
                                .first
                                .value = false;
                          }

                          checkBoxVal.value = val;
                        }),
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

  void _updateGenitourinary(var data) {
    setState(() {
      _genitourinary = data as GenitourinaryModel;

      if (_genitourinary.id != null) {
        _genitourinary.genitourinaryCatheters.forEach((s) {
          _urineCathetersCheckBoxValues
              .singleWhere((c) => c.id == s.catheterId)
              .value = true;
        });

        _genitourinary.genitourinaryBaldderSymptoms.forEach((s) {
          _bladderSymptomsCheckBoxValues
              .singleWhere((c) => c.id == s.symptomId)
              .value = true;
        });

        _urineColorRadioValue = _genitourinary.colorId;

        if (_urineColorRadioValue == 5) {
          _colorController.text = _genitourinary.colorComments;
        }

        _cathetersController.text = _genitourinary.cathetersComments;
        _bladderController.text = _genitourinary.bladderComments;
      }

      updated = true;
    });
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
                child: SubMenu(5, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<GenitourinaryModel>(
                    stream: bloc.genitourinaryObservable,
                    builder:
                        (context, AsyncSnapshot<GenitourinaryModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateGenitourinary(snapshot.data);
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
                            _urineColorWidget(),
                            (_urineColorRadioValue == 5)
                                ? TextFormField(
                                    style: _optionTextStyle,
                                    onChanged: (txt) => setState(() =>
                                        _genitourinary.colorComments = txt),
                                    controller: _colorController,
                                    decoration: InputDecoration(
                                      labelText: 'Describe *',
                                      contentPadding:
                                          EdgeInsets.only(top: 8, bottom: 4),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 8),
                            _urineCathetersWidget(),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (txt) => setState(
                                  () => _genitourinary.cathetersComments = txt),
                              controller: _cathetersController,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _bladderSymptomsWidget(),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (txt) => setState(
                                  () => _genitourinary.bladderComments = txt),
                              controller: _bladderController,
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
                                      List<GenitourinaryCatheters>
                                          _tempCatheters = [];
                                      _urineCathetersCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _tempCatheters.add(
                                            GenitourinaryCatheters(
                                              catheterId: s.id,
                                            ),
                                          );
                                      });

                                      _genitourinary.genitourinaryCatheters =
                                          _tempCatheters;

                                      List<GenitourinaryBaldderSymptoms>
                                          _tempSymptoms = [];
                                      _bladderSymptomsCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _tempSymptoms.add(
                                            GenitourinaryBaldderSymptoms(
                                              symptomId: s.id,
                                            ),
                                          );
                                      });

                                      _genitourinary
                                              .genitourinaryBaldderSymptoms =
                                          _tempSymptoms;

                                      bloc.onSavePressed(_genitourinary);
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

// todo-Uj check required field
