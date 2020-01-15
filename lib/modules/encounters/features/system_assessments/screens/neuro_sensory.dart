import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/neuro_sensory_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class NeuroSensoryScreen extends StatefulWidget {
  static const routeName = '/neuroSensory';

  @override
  _NeuroSensoryScreenState createState() => _NeuroSensoryScreenState();
}

class _NeuroSensoryScreenState extends State<NeuroSensoryScreen> {
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

  int _levelOfConsciousnessRadioValue = 0;
  int _orientedToRadioValue = 0;

  _qualityRadioValueHandler(val) {
    setState(() {
      _levelOfConsciousnessRadioValue = val;
      _neuroSensory.consciousnessId = val;
    });
  }

  _orientedToRadioValueHandler(val) {
    setState(() {
      _orientedToRadioValue = val;
      _neuroSensory.orientedId = val;
    });
  }

  TextEditingController _describeController;

  final bloc = sl<NeuroSensoryBloc>();

  var _neuroSensory = new NeuroSensory();

  void _updateNeuroSensory(var data) {
    setState(() {
      _neuroSensory = data as NeuroSensory;

      if (_neuroSensory.id != null) {
        _neuroSensory.neurosensorySymptoms.forEach((s) {
          _symptomsCardioCheckBoxValues[s.symptom.id - 1].value = true;
        });

        _describeController.text = _neuroSensory.comments;

        _levelOfConsciousnessRadioValue = _neuroSensory.consciousness.id;

        _orientedToRadioValue = _neuroSensory.oriented.id;
      }

      updated = true;
    });
  }

  List<CheckBoxDataModel> _symptomsCardioCheckBoxValues = [];

  List<GroupModel> _levelOfConsciousnessRadioValues = [];

  List<GroupModel> _orientedToRadioValues = [];

  @override
  void initState() {
    _describeController = TextEditingController();
    bloc.initialize();
    super.initState();
  }

  bool updated = false;

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
                child: SubMenu(1, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<NeuroSensory>(
                    stream: bloc.neuroSensoryObservable,
                    builder: (context, AsyncSnapshot<NeuroSensory> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateNeuroSensory(snapshot.data);
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
                            _symptomsWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _describeController,
                              onChanged: (val) => _neuroSensory.comments = val,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _levelOfConsciousnessWidget(),
                            SizedBox(height: 8),
                            _orientedToWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<NeurosensorySymptoms> _temp = [];
                                      _symptomsCardioCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _temp.add(NeurosensorySymptoms(
                                              symptomId: s.id));
                                      });

                                      _neuroSensory.neurosensorySymptoms =
                                          _temp;

                                      bloc.onSavePressed(_neuroSensory);
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

  bool symptomsLoaded = false,
      consciousnessLoaded = false,
      orientedToLoaded = false;

  Widget _symptomsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Symptoms'),
        StreamBuilder<List<NeuroDropDown>>(
            stream: bloc.neuroSymptoms,
            builder: (context, AsyncSnapshot<List<NeuroDropDown>> snapshot) {
              if (snapshot.hasData && !symptomsLoaded) {
                _symptomsCardioCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.description, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    symptomsLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _symptomsCardioCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) {
                          if (checkBoxVal.id == 7 && val) {
                            _symptomsCardioCheckBoxValues
                                .forEach((v) => v.value = false);
                          }

                          if (checkBoxVal.id != 7 && val) {
                            _symptomsCardioCheckBoxValues
                                .where((v) => v.id == 7)
                                .first
                                .value = false;
                          }

                          setState(() => checkBoxVal.value = val);
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

  Widget _levelOfConsciousnessWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Level of consciousness", true),
        StreamBuilder<List<NeuroDropDown>>(
            stream: bloc.neuroConsciousness,
            builder: (context, AsyncSnapshot<List<NeuroDropDown>> snapshot) {
              if (snapshot.hasData && !consciousnessLoaded) {
                _levelOfConsciousnessRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.description, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    consciousnessLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _levelOfConsciousnessRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _qualityRadioValueHandler,
                        _levelOfConsciousnessRadioValue,
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

  Widget _orientedToWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Oriented to", true),
        StreamBuilder<List<NeuroDropDown>>(
            stream: bloc.neuroOriented,
            builder: (context, AsyncSnapshot<List<NeuroDropDown>> snapshot) {
              if (snapshot.hasData && !orientedToLoaded) {
                _orientedToRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.description, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    orientedToLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _orientedToRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _orientedToRadioValueHandler,
                        _orientedToRadioValue,
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

// todo-Uj check required
