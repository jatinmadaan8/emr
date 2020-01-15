import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/coping_stress_bloc.dart';
import 'package:provider/provider.dart';
import '../../health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';

class CopingStressWidget extends StatefulWidget {
  static const routeName = '/copingStress';

  @override
  _CopingStressWidgetState createState() => _CopingStressWidgetState();
}

class _CopingStressWidgetState extends State<CopingStressWidget> {
  var _formKey = GlobalKey<FormState>();

  double optionSize = 148;

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  int recentLossesRadioValue = 0;
  int separatedLovedRadioValue = 0;
  int suicideRadioValue = 0;
  int familySuicideRadioValue = 0;
  int stressRadioValue = 0;
  bool updateScreen = false;

  TextEditingController _actionUnderStressController = TextEditingController();

  recentLossesRadioValueHandler(val) {
    setState(() {
      recentLossesRadioValue = val;
    });
  }

  separatedLovedRadioValueHandler(val) {
    setState(() {
      separatedLovedRadioValue = val;
    });
  }

  suicideRadioValueHandler(val) {
    setState(() {
      suicideRadioValue = val;
    });
  }

  familySuicideRadioValueHandler(val) {
    setState(() {
      familySuicideRadioValue = val;
    });
  }

  stressRadioValueHandler(val) {
    setState(() {
      stressRadioValue = val;
    });
  }

  void _nextClick() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addCopingStress();
  }

  final bloc = sl<CopingStressBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata() {
    updateScreen = true;
    setState(() {
      _actionUnderStressController.text =
          bloc.copingStressData.actionUnderStress;
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
          children: <Widget>[
            MainMenu(8),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(4, 8),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: <Widget>[
                        StreamBuilder<List<GenricQuestions>>(
                            stream: bloc.copingStressQuestions,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text('Nodata');
                              }
                              if (snapshot.hasData) {
                                if (!updateScreen) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _updatedata();
                                  });
                                }

                                return Column(
                                    children: snapshot.data
                                        .map((question) => Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  CommonText(
                                                      question.description,
                                                      false),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Radio(
                                                            groupValue: bloc
                                                                .checkAwnser(
                                                                    question),
                                                            value: true,
                                                            onChanged: (val) {
                                                              bloc.changeQuestion(
                                                                  question,
                                                                  val);
                                                              setState(() {});
                                                            },
                                                            activeColor:
                                                                Color.fromRGBO(
                                                                    45,
                                                                    133,
                                                                    185,
                                                                    1),
                                                          ),
                                                          Text(
                                                            'Yes',
                                                            style:
                                                                new TextStyle(
                                                                    fontSize:
                                                                        14.0),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Radio(
                                                            groupValue: bloc
                                                                .checkAwnser(
                                                                    question),
                                                            value: false,
                                                            onChanged: (val) {
                                                              bloc.changeQuestion(
                                                                  question,
                                                                  val);
                                                              setState(() {});
                                                            },
                                                            activeColor:
                                                                Color.fromRGBO(
                                                                    45,
                                                                    133,
                                                                    185,
                                                                    1),
                                                          ),
                                                          Text(
                                                            'No',
                                                            style:
                                                                new TextStyle(
                                                                    fontSize:
                                                                        14.0),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      (bloc.checkAwnser(
                                                                      question) ==
                                                                  null
                                                              ? false
                                                              : bloc
                                                                  .checkAwnser(
                                                                      question))
                                                          ? Container(
                                                              width: 200,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Describe *',
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          top:
                                                                              8,
                                                                          bottom:
                                                                              4),
                                                                ),
                                                                initialValue: bloc
                                                                    .checkQuestionDescription(
                                                                        question),
                                                                onChanged:
                                                                    (val) {
                                                                  bloc.changeQuestionDescription(
                                                                      question,
                                                                      val);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Describe is required';
                                                                  }
                                                                  return null;
                                                                },
                                                              ))
                                                          : SizedBox.shrink(),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList());
                              }
                            }),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CommonText(
                                  '6. What do you do when you are under stress ?',
                                  false),
                              SizedBox(height: 4),
                              TextFormField(
                                controller: _actionUnderStressController,
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                onChanged: (val) => bloc
                                    .copingStressData.actionUnderStress = val,
                              ),
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
                                  onPressed: _nextClick,
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
