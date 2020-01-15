import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/Cognitive_perceptual_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/screens/coping_stress.dart';
import 'package:provider/provider.dart';
import '../../health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/cognitive_perceptual_model.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/next_prev_button.dart';

class PerceptualWidget extends StatefulWidget {
  static const routeName = '/perceptual';

  @override
  _PerceptualWidgetState createState() => _PerceptualWidgetState();
}

class _PerceptualWidgetState extends State<PerceptualWidget> {
  var _formKey = GlobalKey<FormState>();

  double optionSize = 148;

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

  final bloc = sl<CognitivePerceptualBloc>();

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
    _pushReplacementNamed(CopingStressWidget.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getCognitivePerceptual();
    bloc.getCommunication();
    bloc.getLangSpoken();
    bloc.getVision();
    bloc.getHearing();

    bloc.cognitivePerceptualSubjectObservable.listen((data) {
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MainMenu(8),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(3, 8),
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
                              CommonText('Communication', false),
                              StreamBuilder<List<CogitivePeceptualCommonModel>>(
                                stream: bloc.communicationObservable,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                        children: snapshot.data
                                            .map((question) =>
                                                RadioButtonCommon((val) {
                                                  setState(() {
                                                    bloc.communicationRadioValue =
                                                        val;
                                                  });
                                                }, bloc.communicationRadioValue,
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
                              CommonText('Primary Language Spoken', false),
                              StreamBuilder<List<CogitivePeceptualCommonModel>>(
                                stream: bloc.langSpokenObservable,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(children: <Widget>[
                                      Row(
                                          children: snapshot.data
                                              .map((question) =>
                                                  RadioButtonCommon((val) {
                                                    setState(() {
                                                      bloc.primaryLanguageSpokenValue =
                                                          val;
                                                    });
                                                  },
                                                      bloc.primaryLanguageSpokenValue,
                                                      question.name,
                                                      question.id))
                                              .toList()),
                                      (bloc.primaryLanguageSpokenValue == 2)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Container(
                                                  width: 200,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Description',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 4),
                                                    ),
                                                    initialValue:
                                                        bloc.languageList,
                                                    onChanged: (val) {
                                                      bloc.languageList = val;
                                                    },
                                                  )))
                                          : SizedBox.shrink()
                                    ]);
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
                              CommonText('Hearing', false),
                              StreamBuilder<List<CogitivePeceptualCommonModel>>(
                                stream: bloc.hearingObservable,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Wrap(children: <Widget>[
                                      Wrap(
                                          children: snapshot.data
                                              .map((question) =>
                                                  RadioButtonCommon((val) {
                                                    setState(() {
                                                      bloc.hearingRadioValue =
                                                          val;
                                                    });
                                                  },
                                                      bloc.hearingRadioValue,
                                                      question.name,
                                                      question.id))
                                              .toList()),
                                      (bloc.hearingRadioValue == 6)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Container(
                                                  width: 200,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Description',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 4),
                                                    ),
                                                    initialValue:
                                                        bloc.hearingList,
                                                    onChanged: (val) {
                                                      bloc.hearingList = val;
                                                    },
                                                  )))
                                          : SizedBox.shrink()
                                    ]);
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
                              CommonText('Vision', false),
                              StreamBuilder<List<CogitivePeceptualCommonModel>>(
                                stream: bloc.visionObservable,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Wrap(children: <Widget>[
                                      Wrap(
                                          children: snapshot.data
                                              .map((question) =>
                                                  RadioButtonCommon((val) {
                                                    setState(() {
                                                      bloc.visionRadioValue =
                                                          val;
                                                    });
                                                  },
                                                      bloc.visionRadioValue,
                                                      question.name,
                                                      question.id))
                                              .toList()),
                                      (bloc.visionRadioValue == 8)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Container(
                                                  width: 200,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Description',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 4),
                                                    ),
                                                    initialValue:
                                                        bloc.visionList,
                                                    onChanged: (val) {
                                                      bloc.visionList = val;
                                                    },
                                                  )))
                                          : SizedBox.shrink()
                                    ]);
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
                              CommonText('Paraesthesia, numbness', false),
                              Row(children: <Widget>[
                                Row(
                                  children: _healthPatternAssessment.yesNo
                                      .map((answer) => RadioButtonCommon((val) {
                                            setState(() {
                                              bloc.numbnessRadioValue = val;
                                            });
                                          }, bloc.numbnessRadioValue,
                                              answer.text, answer.index))
                                      .toList(),
                                ),
                                (bloc.numbnessRadioValue == 1)
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
                                              initialValue:
                                                  bloc.paraesthesiaNumbnessDesc,
                                              onChanged: (val) {
                                                bloc.paraesthesiaNumbnessDesc =
                                                    val;
                                              },
                                            )))
                                    : SizedBox.shrink()
                              ])
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    bloc.callAnAPI();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
