import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/screens/perceptual.dart';
import 'package:provider/provider.dart';

import '../../health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/activity_n_exercise_bloc.dart';

import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/next_prev_button.dart';
//part '../../../data/data_source/activity_exercise_local_data_source.dart';
//part '../../../data/data_source/activity_exercise_remote_data_source.dart';
//part '../../../data/repository/avn_repository.dart';

class ActivityExerciseWidget extends StatefulWidget {
  static const routeName = '/activityExercise';

  @override
  _ActivityExerciseWidgetState createState() => _ActivityExerciseWidgetState();
}

class _ActivityExerciseWidgetState extends State<ActivityExerciseWidget> {
  var _formKey = GlobalKey<FormState>();

  final bloc = sl<ActivityNExerciseBloc>();
  double optionSize = 196;

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  void _skipClick() {
    // _pushReplacementNamed(FamilyandEnvironmentScreen.routeName);
  }

  void _previousClick() {
    // _pushReplacementNamed('');
  }

  void _nextClick() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.callAnAPI();
    _pushReplacementNamed(PerceptualWidget.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getActivitiesAndExercise();
    bloc.getMobilityStatus();
    bloc.getassistiveDevices();
    bloc.getLimitations();
    bloc.getADLs();

    bloc.activitiesNExerciseSubjectObservable.listen((data) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    final _healthPatternAssessment =
        Provider.of<HealthPatternAssessmentQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(8),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(2, 8),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      NextPreButton(_skipClick, _previousClick, _nextClick),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('Mobility Status', false),
                            StreamBuilder<
                                List<ActivityNExerciseMobilityStatusModel>>(
                              stream: bloc.mobilityStatusObservable,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                      children: snapshot.data
                                          .map((question) => RadioButtonCommon(
                                                  (val) {
                                                setState(() {
                                                  bloc.mobilityStatusRadioValue =
                                                      val;
                                                });
                                              }, bloc.mobilityStatusRadioValue,
                                                  question.name, question.id))
                                          .toList());
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('Assistive Device', false),
                            StreamBuilder<
                                List<ActivityNExerciseAssistiveDevicesModel>>(
                              stream: bloc.assistiveDeviceObservable,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(children: <Widget>[
                                    Row(
                                        children: snapshot.data
                                            .map((question) =>
                                                RadioButtonCommon((val) {
                                                  setState(() {
                                                    bloc.assistiveDeviceRadioValue =
                                                        val;
                                                  });
                                                }, bloc.assistiveDeviceRadioValue,
                                                    question.name, question.id))
                                            .toList()),
                                    (bloc.assistiveDeviceRadioValue == 5)
                                        ? Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Container(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Description',
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 8, bottom: 4),
                                                  ),
                                                  initialValue:
                                                      bloc.assistiveDeviceDes,
                                                  onChanged: (val) {
                                                    bloc.assistiveDeviceDes =
                                                        val;
                                                  },
                                                )))
                                        : SizedBox.shrink()
                                  ]);
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('Limitations', false),
                            StreamBuilder<
                                List<ActivityNExerciseLimitationsModel>>(
                              stream: bloc.limitationsObservable,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(children: <Widget>[
                                    Row(
                                        children: snapshot.data
                                            .map((question) =>
                                                RadioButtonCommon((val) {
                                                  print("Selected $val");
                                                  setState(() {
                                                    bloc.limitationsRadioValue =
                                                        val;
                                                  });
                                                }, bloc.limitationsRadioValue,
                                                    question.name, question.id))
                                            .toList()),
                                    (bloc.limitationsRadioValue == 4)
                                        ? Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Container(
                                                width: 200,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    labelText: 'Description',
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 8, bottom: 4),
                                                  ),
                                                  initialValue:
                                                      bloc.limitationsDesc,
                                                  onChanged: (val) {
                                                    bloc.limitationsDesc = val;
                                                  },
                                                )))
                                        : SizedBox.shrink()
                                  ]);
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('ADLs', false),
                            StreamBuilder<List<ActivityNExerciseADLsModel>>(
                              stream: bloc.adlsObservable,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Row(
                                      children: snapshot.data
                                          .map((question) => RadioButtonCommon(
                                                  (val) {
                                                setState(() {
                                                  bloc.adlsRadioValue = val;
                                                });
                                              }, bloc.adlsRadioValue,
                                                  question.name, question.id))
                                          .toList());
                                } else {
                                  return Container();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('Exercise Regularly', false),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: _healthPatternAssessment.yesNo
                                      .map((answer) => RadioButtonCommon((val) {
                                            setState(() {
                                              bloc.exerciseRadioValue = val;
                                            });
                                          }, bloc.exerciseRadioValue,
                                              answer.text, answer.index))
                                      .toList(),
                                ),
                                (bloc.exerciseRadioValue == 1)
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Container(
                                            width: 200,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Description',
                                                contentPadding: EdgeInsets.only(
                                                    top: 8, bottom: 4),
                                              ),
                                              initialValue: bloc.exerciseDesc,
                                              onChanged: (val) {
                                                bloc.exerciseDesc = val;
                                              },
                                            )))
                                    : SizedBox.shrink()
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CommonText('Hobbies/interests/occupation', false),
                            SizedBox(height: 6),
                            StreamBuilder<String>(
                              stream: bloc.hobbiesIntrestOccObserable,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return TextField(onChanged: (val) {
                                    bloc.hobbiesInterestOccupation = val;
                                  });
                                } else {
                                  return TextFormField(
                                    style: _optionTextStyle,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(top: 8, bottom: 4),
                                    ),
                                    initialValue: snapshot.data,
                                    onChanged: (val) {
                                      bloc.hobbiesInterestOccupation = val;
                                      setState(() {});
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
