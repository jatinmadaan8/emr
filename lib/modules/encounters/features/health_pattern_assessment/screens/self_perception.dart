import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/self_perception.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/self_perception_bloc.dart';
import 'package:provider/provider.dart';
import '../../health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class SelfPerceptionWidget extends StatefulWidget {
  static const routeName = '/selfPerception';

  @override
  _SelfPerceptionWidgetState createState() => _SelfPerceptionWidgetState();
}

class _SelfPerceptionWidgetState extends State<SelfPerceptionWidget> {
  var _formKey = GlobalKey<FormState>();

  double optionSize = 148;
  bool updateScreen = false;

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

  int clientBehaviorRadioValue = 0;

  TextEditingController _concernsAbtIllnessController = TextEditingController();
  TextEditingController _behaviorAppropriateDescController =
      TextEditingController();

  clientBehaviorRadioValueHandler(val) {
    setState(() {
      bloc.selfPerceptionData.isBehaviorAppropriate = val;
    });
  }

  final bloc = sl<SelfPerceptionBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata() {
    updateScreen = true;
    setState(() {
      _concernsAbtIllnessController.text =
          bloc.selfPerceptionData.concernsAbtIllness;

      _behaviorAppropriateDescController.text =
          bloc.selfPerceptionData.behaviorAppropriateDesc;
    });
  }

  void _saveClick() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addSelfPerception();
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
                  child: SubMenu(6, 8),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: StreamBuilder<SelfPerception>(
                      stream: bloc.selfPerceptionObservable,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !updateScreen) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _updatedata();
                          });
                        }

                        return Form(
                          key: _formKey,
                          child: ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText(
                                        '1. What most concerns you about your illness ?',
                                        false),
                                    SizedBox(height: 4),
                                    TextFormField(
                                      controller: _concernsAbtIllnessController,
                                      style: _optionTextStyle,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 8, bottom: 4),
                                      ),
                                      onChanged: (val) => bloc
                                          .selfPerceptionData
                                          .concernsAbtIllness = val,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText(
                                        '2. Is client\'s behavior appropriate to situation ?',
                                        false),
                                    Row(
                                      children: _healthPatternAssessment
                                          .yesNobool
                                          .map((value) {
                                        return RadioButtonCommon(
                                          clientBehaviorRadioValueHandler,
                                          bloc.selfPerceptionData
                                              .isBehaviorAppropriate,
                                          value.text,
                                          value.index,
                                        );
                                      }).toList(),
                                    ),
                                    bloc.selfPerceptionData
                                                .isBehaviorAppropriate ==
                                            false
                                        ? Container(
                                            child: TextFormField(
                                              controller:
                                                  _behaviorAppropriateDescController,
                                              style: _optionTextStyle,
                                              decoration: InputDecoration(
                                                labelText: 'Explian*',
                                                contentPadding: EdgeInsets.only(
                                                    top: 8, bottom: 4),
                                              ),
                                              onChanged: (val) => bloc
                                                      .selfPerceptionData
                                                      .behaviorAppropriateDesc =
                                                  val,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Explian is required';
                                                }
                                                return null;
                                              },
                                            ),
                                          )
                                        : SizedBox.shrink()
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
                                        onPressed: _saveClick,
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
                                  ],
                                ),
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
      ),
    );
  }
}
