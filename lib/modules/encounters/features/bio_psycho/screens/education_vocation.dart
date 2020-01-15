import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/education_vocation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/education_vocation_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/radio_button.dart';
import '../providers/questions.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'substance_use.dart';
import 'legal_history.dart';

class EducationVocationScreen extends StatefulWidget {
  static const routeName = '/educationVocation';
  @override
  _EducationVocationScreenState createState() =>
      _EducationVocationScreenState();
}

class _EducationVocationScreenState extends State<EducationVocationScreen> {
  final _form = GlobalKey<FormState>();

  bool updateScreen = false;

  TextEditingController _expelledSuspendedDescController =
      TextEditingController();
  TextEditingController _learningDifficultiesDescController =
      TextEditingController();
  TextEditingController _past5yrJobsController = TextEditingController();
  TextEditingController _jobRelatedProblemsDescController =
      TextEditingController();

  void _saveForm() {}

  void _gradesFun(val) {
    setState(() {
      bloc.educationVocationData.gradeId = val;
    });
  }

  void _attendanceFun(val) {
    setState(() {
      bloc.educationVocationData.attendanceId = val;
    });
  }

  void _expelledSuspendedFun(val) {
    setState(() {
      bloc.educationVocationData.isExpelledSuspended = val;
    });
  }

  void _learningDifficultiesFun(val) {
    setState(() {
      bloc.educationVocationData.isLearningDifficulties = val;
    });
  }

  void _vocationalTrainingFun(val) {
    setState(() {
      bloc.educationVocationData.isVocationallyTrained = val;
    });
  }

  void _satisfiedCurrentJoblifeFun(val) {
    setState(() {
      bloc.educationVocationData.isSatisfiedCurrentJob = val;
    });
  }

  void _jobRelatedProblemsFun(val) {
    setState(() {
      bloc.educationVocationData.isJobRelatedProblems = val;
    });
  }

  void _mHSuDproblemsFun(val) {
    setState(() {
      bloc.educationVocationData.isAbilityEffetced = val;
    });
  }

  void _needhelpFun(val) {
    setState(() {
      bloc.educationVocationData.isInterestedBenefitsEmployment = val;
    });
  }

  void _interestedInSpeakingFun(val) {
    setState(() {
      bloc.educationVocationData.isInterestedBenefitsEmployment = val;
    });
  }

  void _skipClick() {
    _pushReplacementNamed(LegalHistoryScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(SubstanceUseScreen.routeName);
  }

  void _nextClick() {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addEducationVocation();
    _pushReplacementNamed(LegalHistoryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<EducationVocationBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata() {
    setState(() {
      _expelledSuspendedDescController.text =
          bloc.educationVocationData.expelledSuspendedDesc;
      _learningDifficultiesDescController.text =
          bloc.educationVocationData.learningDifficultiesDesc;
      _past5yrJobsController.text = bloc.educationVocationData.past5yrJobs;
      _jobRelatedProblemsDescController.text =
          bloc.educationVocationData.jobRelatedProblemsDesc;
      updateScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final deviceHeightPercent = deviceSize.height - 200;

    final _questions = Provider.of<Questions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(1),
            Row(children: <Widget>[
              Container(
                width: (blockSizeHorizontal * 20),
                height: deviceHeightPercent,
                child: SubMenu(6, 1),
              ),
              Container(
                width: (blockSizeHorizontal * 80),
                height: deviceHeightPercent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _form,
                    child: StreamBuilder<EducationVocation>(
                        stream: bloc.educationVocation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !updateScreen) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updatedata();
                            });
                          }

                          return Column(
                            children: <Widget>[
                              NextPreButton(
                                  _skipClick, _previousClick, _nextClick),
                              Expanded(
                                child: ListView(children: <Widget>[
                                  CommonText(
                                    "1. How were your grades in school?",
                                    true,
                                  ),
                                  StreamBuilder<List<GenricDropDown>>(
                                      stream: bloc.grades,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('No-Data');
                                        }
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapshot.data
                                              .map((answer) =>
                                                  RadioButtonCommon(
                                                      _gradesFun,
                                                      bloc.educationVocationData
                                                          .gradeId,
                                                      answer.name,
                                                      answer.id))
                                              .toList(),
                                        );
                                      }),
                                  CommonText(
                                    "2. How was your attendance in school?",
                                    true,
                                  ),
                                  StreamBuilder<List<GenricDropDown>>(
                                      stream: bloc.attendance,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('No-Data');
                                        }
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: snapshot.data
                                              .map((answer) =>
                                                  RadioButtonCommon(
                                                      _attendanceFun,
                                                      bloc.educationVocationData
                                                          .attendanceId,
                                                      answer.name,
                                                      answer.id))
                                              .toList(),
                                        );
                                      }),
                                  CommonText(
                                    "3. Where you ever expelled or suspended?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _expelledSuspendedFun,
                                            bloc.educationVocationData
                                                .isExpelledSuspended,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  Container(
                                    child: bloc.educationVocationData
                                                .isExpelledSuspended ==
                                            true
                                        ? TextFormField(
                                            controller:
                                                _expelledSuspendedDescController,
                                            decoration: InputDecoration(
                                              labelText: 'Why?*',
                                            ),
                                            onChanged: (val) => bloc
                                                .educationVocationData
                                                .expelledSuspendedDesc = val,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Why is required';
                                              }
                                              return null;
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CommonText(
                                    "4. Did/do you have any learning difficulties?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _learningDifficultiesFun,
                                            bloc.educationVocationData
                                                .isLearningDifficulties,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  Container(
                                    child: bloc.educationVocationData
                                                .isLearningDifficulties ==
                                            true
                                        ? TextFormField(
                                            controller:
                                                _learningDifficultiesDescController,
                                            decoration: InputDecoration(
                                              labelText: 'Explain*',
                                            ),
                                            onChanged: (val) => bloc
                                                .educationVocationData
                                                .learningDifficultiesDesc = val,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Explain is required';
                                              }
                                              return null;
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CommonText(
                                    "5. Are you involved in vocational training?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _vocationalTrainingFun,
                                            bloc.educationVocationData
                                                .isVocationallyTrained,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  CommonText(
                                    "6. What jobs have you had in the past 5 years?",
                                    false,
                                  ),
                                  TextFormField(
                                    controller: _past5yrJobsController,
                                    decoration: InputDecoration(),
                                    validator: (value) {},
                                    onChanged: (val) => bloc
                                        .educationVocationData
                                        .past5yrJobs = val,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CommonText(
                                    "7. Are you satisfied with your current job?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _satisfiedCurrentJoblifeFun,
                                            bloc.educationVocationData
                                                .isSatisfiedCurrentJob,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  CommonText(
                                    "8. Are you having/have you had job related problems?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _jobRelatedProblemsFun,
                                            bloc.educationVocationData
                                                .isJobRelatedProblems,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  Container(
                                    child: bloc.educationVocationData
                                                .isJobRelatedProblems ==
                                            true
                                        ? TextFormField(
                                            controller:
                                                _jobRelatedProblemsDescController,
                                            decoration: InputDecoration(
                                              labelText: 'Explain*',
                                            ),
                                            onChanged: (val) => bloc
                                                .educationVocationData
                                                .jobRelatedProblemsDesc = val,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Explain is required';
                                              }
                                              return null;
                                            },
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  CommonText(
                                    "9. Is your ability to work affected by your current MH/SuD problems?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _mHSuDproblemsFun,
                                            bloc.educationVocationData
                                                .isAbilityEffetced,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  ),
                                  CommonText(
                                    "10. Do you need help with any of the following ?",
                                    false,
                                  ),
                                  StreamBuilder<List<GenricDropDown>>(
                                      stream: bloc.helpNeededFor,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text('No-Data');
                                        }

                                        return Wrap(
                                          children: snapshot.data
                                              .map((answer) =>
                                                  CheckboxButtonCommon(
                                                    (value) {
                                                      setState(() {
                                                        bloc.setValueForEvaluation(
                                                            answer);
                                                      });
                                                    },
                                                    bloc.checkValue(answer),
                                                    answer.name,
                                                  ))
                                              .toList(),
                                        );
                                      }),
                                  CommonText(
                                    "11. Are you interested in speaking with someone about benefits and employement?",
                                    false,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _questions.noYesbool
                                        .map((answer) => RadioButtonCommon(
                                            _interestedInSpeakingFun,
                                            bloc.educationVocationData
                                                .isInterestedBenefitsEmployment,
                                            answer.text,
                                            answer.index))
                                        .toList(),
                                  )
                                ]),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
