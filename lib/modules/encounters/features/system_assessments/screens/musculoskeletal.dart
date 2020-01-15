import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/musculoskeletal.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/musculoskeletal_bloc.dart';
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

class MusculoskeletalScreen extends StatefulWidget {
  static const routeName = '/musculoskeletal';

  @override
  _MusculoskeletalScreenState createState() => _MusculoskeletalScreenState();
}

class _MusculoskeletalScreenState extends State<MusculoskeletalScreen> {
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

  int _rGripStrengthRadioValue = 0;
  int _lGripStrengthRadioValue = 0;
  int _rPushStrengthRadioValue = 0;
  int _lPushStrengthRadioValue = 0;

  _rGripStrengthRadioValueHandler(val) {
    setState(() {
      _rGripStrengthRadioValue = val;
      _musculoSkeletal.rightGripId = val;
    });
  }

  _lGripStrengthRadioValueHandler(val) {
    setState(() {
      _lGripStrengthRadioValue = val;
      _musculoSkeletal.leftGripId = val;
    });
  }

  _rPushStrengthRadioValueHandler(val) {
    setState(() {
      _rPushStrengthRadioValue = val;
      _musculoSkeletal.rightPushId = val;
    });
  }

  _lPushStrengthRadioValueHandler(val) {
    setState(() {
      _lPushStrengthRadioValue = val;
      _musculoSkeletal.leftPushId = val;
    });
  }

  TextEditingController _describeController;

  final bloc = sl<MusculoSkeletalBloc>();

  var _musculoSkeletal = new MusculoSkeletalModel();

  void _updateMusculoSkeletal(var data) {
    setState(() {
      _musculoSkeletal = data as MusculoSkeletalModel;

      if (_musculoSkeletal.id != null) {
        _rGripStrengthRadioValue = _musculoSkeletal.rightGripId;
        _lGripStrengthRadioValue = _musculoSkeletal.leftGripId;
        _rPushStrengthRadioValue = _musculoSkeletal.rightPushId;
        _lPushStrengthRadioValue = _musculoSkeletal.leftPushId;

        _describeController.text = _musculoSkeletal.comments;

        _musculoSkeletal.musculoskeletalProblemsDetails.forEach((p) {
          _problemsCheckBoxValues
              .singleWhere((c) => c.id == p.problemId)
              .value = true;
        });
      }

      updated = true;
    });
  }

  @override
  void initState() {
    _describeController = TextEditingController();
    bloc.initialize();
    super.initState();
  }

  bool problemsLoaded = false,
      rGripLoaded = false,
      lGripLoaded = false,
      rPushLoaded = false,
      lPushLoaded = false,
      updated = false;

  List<CheckBoxDataModel> _problemsCheckBoxValues = [];
  List<CheckBoxDataModel> _rGripCheckBoxValues = [];
  List<CheckBoxDataModel> _lGripCheckBoxValues = [];
  List<CheckBoxDataModel> _rPushCheckBoxValues = [];
  List<CheckBoxDataModel> _lPushCheckBoxValues = [];

  Widget _problemsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Problems'),
        StreamBuilder<List<MusculoSkeletalLookUpData>>(
            stream: bloc.musculoSkeletalProblems,
            builder: (context,
                AsyncSnapshot<List<MusculoSkeletalLookUpData>> snapshot) {
              if (snapshot.hasData && !problemsLoaded) {
                _problemsCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    problemsLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _problemsCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) {
                          setState(() {
                            if (checkBoxVal.id == 9 && val) {
                              _problemsCheckBoxValues
                                  .forEach((v) => v.value = false);
                            }

                            if (checkBoxVal.id != 9 && val) {
                              _problemsCheckBoxValues
                                  .where((v) => v.id == 9)
                                  .first
                                  .value = false;
                            }

                            checkBoxVal.value = val;
                          });
                        },
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

  Widget _rGripStrengthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("R grip strength", false),
        StreamBuilder<List<MusculoSkeletalLookUpData>>(
            stream: bloc.rGripStrength,
            builder: (context,
                AsyncSnapshot<List<MusculoSkeletalLookUpData>> snapshot) {
              if (snapshot.hasData && !rGripLoaded) {
                _rGripCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    rGripLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _rGripCheckBoxValues
                    .map(
                      (val) => RadioButtonCommon(
                        _rGripStrengthRadioValueHandler,
                        _rGripStrengthRadioValue,
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

  Widget _lGripStrengthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("L grip strength", false),
        StreamBuilder<List<MusculoSkeletalLookUpData>>(
            stream: bloc.lGripStrength,
            builder: (context,
                AsyncSnapshot<List<MusculoSkeletalLookUpData>> snapshot) {
              if (snapshot.hasData && !lGripLoaded) {
                _lGripCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    lGripLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _lGripCheckBoxValues
                    .map(
                      (val) => RadioButtonCommon(
                        _lGripStrengthRadioValueHandler,
                        _lGripStrengthRadioValue,
                        val.title,
                        val.id,
                      ),
                    )
                    .toList(),
              );
            })
      ],
    );
  }

  Widget _rPushStrengthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("R push strength", false),
        StreamBuilder<List<MusculoSkeletalLookUpData>>(
            stream: bloc.rPushStrength,
            builder: (context,
                AsyncSnapshot<List<MusculoSkeletalLookUpData>> snapshot) {
              if (snapshot.hasData && !rPushLoaded) {
                _rPushCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    rPushLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _rPushCheckBoxValues
                    .map(
                      (val) => RadioButtonCommon(
                        _rPushStrengthRadioValueHandler,
                        _rPushStrengthRadioValue,
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

  Widget _lPushStrengthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("L push strength", false),
        StreamBuilder<List<MusculoSkeletalLookUpData>>(
            stream: bloc.lPushStrength,
            builder: (context,
                AsyncSnapshot<List<MusculoSkeletalLookUpData>> snapshot) {
              if (snapshot.hasData && !lPushLoaded) {
                _lPushCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    lPushLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _lPushCheckBoxValues
                    .map(
                      (val) => RadioButtonCommon(
                        _lPushStrengthRadioValueHandler,
                        _lPushStrengthRadioValue,
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

  SystemAssessmentsQuestions _systems;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    _systems = Provider.of<SystemAssessmentsQuestions>(context);

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
                child: SubMenu(7, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<MusculoSkeletalModel>(
                    stream: bloc.musculoSkeletalObservable,
                    builder: (context,
                        AsyncSnapshot<MusculoSkeletalModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateMusculoSkeletal(snapshot.data);
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
                            CommonText("Any ?", false),
                            SizedBox(height: 12),
                            _problemsWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (txt) => setState(
                                  () => _musculoSkeletal.comments = txt),
                              controller: _describeController,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _rGripStrengthWidget(),
                            SizedBox(height: 8),
                            _lGripStrengthWidget(),
                            SizedBox(height: 8),
                            _rPushStrengthWidget(),
                            SizedBox(height: 8),
                            _lPushStrengthWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<MusculoskeletalProblemsDetails>
                                          _temp = [];
                                      _problemsCheckBoxValues.forEach((s) {
                                        if (s.value)
                                          _temp.add(
                                              MusculoskeletalProblemsDetails(
                                                  problemId: s.id));
                                      });

                                      _musculoSkeletal
                                              .musculoskeletalProblemsDetails =
                                          _temp;

                                      bloc.onSavePressed(_musculoSkeletal);
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
