import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/respiratory.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/respiratory_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class RespiratoryScreen extends StatefulWidget {
  static const routeName = '/respiratory';

  @override
  _RespiratoryScreenState createState() => _RespiratoryScreenState();
}

class _RespiratoryScreenState extends State<RespiratoryScreen> {
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

  int _chestAppearanceRadioValue = 0;
  int _breathPatternRadioValue = 0;
  int _breathSoundRadioValue = 0;

  _chestAppearanceRadioValueHandler(val) {
    setState(() {
      _chestAppearanceRadioValue = val;
      _respiratory.chestAppId = val;
    });
  }

  _breathPatternRadioValueHandler(val) {
    setState(() {
      _breathPatternRadioValue = val;
      _respiratory.breathPattId = val;
    });
  }

  _breathSoundRadioValueHandler(val) {
    setState(() {
      _breathSoundRadioValue = val;
      _respiratory.breathSoundId = val;
    });
  }

  TextEditingController _describeController;

  List<CheckBoxDataModel> _rspSymptomsCheckBoxValues = [];
  List<GroupModel> _rspChestAppearanceRadioValues = [];
  List<GroupModel> _rspBreathPatternRadioValues = [];
  List<GroupModel> _rspBreathSoundRadioValues = [];

  bool updated = false;

  var _respiratory = new RespiratoryModel();

  void _updateRespiratory(var data) {
    setState(() {
      _respiratory = data as RespiratoryModel;

      if (_respiratory.id != null) {
        _respiratory.respiratorySymptoms.forEach((s) {
          _rspSymptomsCheckBoxValues[s.symptomId - 1].value = true;
        });

        _describeController.text = _respiratory.comments;

        _chestAppearanceRadioValue = _respiratory.chestAppId;
        _breathPatternRadioValue = _respiratory.breathPattId;
        _breathSoundRadioValue = _respiratory.breathSoundId;
      }

      updated = true;
    });
  }

  final bloc = sl<RespiratoryBloc>();

  @override
  void initState() {
    _describeController = TextEditingController();

    bloc.initialize();

    super.initState();
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
                child: SubMenu(3, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<RespiratoryModel>(
                    stream: bloc.respiratoryObservable,
                    builder:
                        (context, AsyncSnapshot<RespiratoryModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateRespiratory(snapshot.data);
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
                            _rspSymptomsWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (text) =>
                                  setState(() => _respiratory.comments = text),
                              controller: _describeController,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _rspChestAppearanceWidget(),
                            SizedBox(height: 8),
                            _rspBreathPatternWidget(),
                            SizedBox(height: 8),
                            _rspBreathSoundWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<RespiratorySymptoms> _temp = [];
                                      _rspSymptomsCheckBoxValues.forEach((s) {
                                        if (s.value)
                                          _temp.add(RespiratorySymptoms(
                                              symptomId: s.id));
                                      });

                                      _respiratory.respiratorySymptoms = _temp;

                                      bloc.onSavePressed(_respiratory);
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

  bool _symptomsLoaded = false,
      _chestAppearanceLoaded = false,
      _breathPatternLoaded = false,
      _breathSoundLoaded = false;

  Widget _rspSymptomsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Symptoms'),
        StreamBuilder<List<RespiratoryDropDown>>(
            stream: bloc.rspSymptoms,
            builder:
                (context, AsyncSnapshot<List<RespiratoryDropDown>> snapshot) {
              if (snapshot.hasData && !_symptomsLoaded) {
                _rspSymptomsCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _symptomsLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _rspSymptomsCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() {
                          if (checkBoxVal.id == 6 && val) {
                            _rspSymptomsCheckBoxValues
                                .forEach((v) => v.value = false);
                          }

                          if (checkBoxVal.id != 6 && val) {
                            _rspSymptomsCheckBoxValues
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

  Widget _rspChestAppearanceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Chest appearance", true),
        StreamBuilder<List<RespiratoryDropDown>>(
            stream: bloc.rspChestAppearence,
            builder:
                (context, AsyncSnapshot<List<RespiratoryDropDown>> snapshot) {
              if (snapshot.hasData && !_chestAppearanceLoaded) {
                _rspChestAppearanceRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.description, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _chestAppearanceLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _rspChestAppearanceRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _chestAppearanceRadioValueHandler,
                        _chestAppearanceRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _rspBreathPatternWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Breath Pattern", true),
        StreamBuilder<List<RespiratoryDropDown>>(
            stream: bloc.rspBreathPattern,
            builder:
                (context, AsyncSnapshot<List<RespiratoryDropDown>> snapshot) {
              if (snapshot.hasData && !_breathPatternLoaded) {
                _rspBreathPatternRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.description, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _breathPatternLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _rspBreathPatternRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _breathPatternRadioValueHandler,
                        _breathPatternRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _rspBreathSoundWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Breath Sound", true),
        StreamBuilder<List<RespiratoryDropDown>>(
            stream: bloc.rspBreathSounds,
            builder:
                (context, AsyncSnapshot<List<RespiratoryDropDown>> snapshot) {
              if (snapshot.hasData && !_breathSoundLoaded) {
                _rspBreathSoundRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.description, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _breathSoundLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _rspBreathSoundRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _breathSoundRadioValueHandler,
                        _breathSoundRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }
}

// todo-Uj check required field
