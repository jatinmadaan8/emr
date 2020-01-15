import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/abuse_neglect_bloc.dart';
import 'package:provider/provider.dart';

import '../../health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class AbuseNeglectWidget extends StatefulWidget {
  static const routeName = '/abuseNeglect';

  @override
  _AbuseNeglectWidgetState createState() => _AbuseNeglectWidgetState();
}

class _AbuseNeglectWidgetState extends State<AbuseNeglectWidget> {
  final bloc = sl<AbuseNeglectBloc>();
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  @override
  void initState() {
    bloc.initialize();
    super.initState();
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
      body: StreamBuilder<Object>(
          stream: bloc.abuseNeglectObservable,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MainMenu(8),
                  Row(
                    children: <Widget>[
                      Container(
                        width: deviceWidthPercent * 20,
                        height: deviceHeightPercent,
                        child: SubMenu(5, 8),
                      ),
                      Container(
                        width: deviceWidthPercent * 80,
                        height: deviceHeightPercent,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText(
                                        '1. Do you feel safe at home ?', false),
                                    Row(
                                      children: _healthPatternAssessment
                                          .yesNobool
                                          .map((value) {
                                        return RadioButtonCommon(
                                          bloc.feelSafeRadioValueHandler,
                                          bloc
                                              .abuseNeglectData
                                              .abuseNeglectQuestionnaire
                                              .feelSafeAthome,
                                          value.text,
                                          value.index,
                                        );
                                      }).toList(),
                                    ),
                                    bloc.abuseNeglectData.abuseNeglectQuestionnaire
                                                .feelSafeAthome ==
                                            true
                                        ? TextFormField(
                                            initialValue: bloc
                                                .abuseNeglectData
                                                .abuseNeglectQuestionnaire
                                                .safeAtHomeDesc,
                                            decoration: InputDecoration(
                                                labelText: 'Describe *'),
                                            onChanged: (value) => bloc
                                                .updateSafeAtHomeDesc(value))
                                        : Container(),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText(
                                        '2. Nurse\'s observation ?', false),
                                    Row(
                                      children:
                                          bloc.anObservations.map((value) {
                                        return RadioButtonCommon(
                                          bloc.observationRadioValueHandler,
                                          bloc
                                              .abuseNeglectData
                                              .abuseNeglectQuestionnaire
                                              .observationId,
                                          value.name,
                                          value.id,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              bloc.abuseNeglectData.abuseNeglectQuestionnaire
                                          .observationId ==
                                      2
                                  ? TextFormField(
                                      initialValue: bloc
                                          .abuseNeglectData
                                          .abuseNeglectQuestionnaire
                                          .observationDesc,
                                      decoration: InputDecoration(
                                          labelText: 'Describe *'),
                                      onChanged: (value) =>
                                          bloc.updateObservationDesc(value))
                                  : Column(),
                              SizedBox(height: 16),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('3. Nurse\'s follow-up action ?',
                                        false),
                                    Row(
                                      children:
                                          bloc.anFollowupActions.map((value) {
                                        return RadioButtonCommon(
                                          bloc.followupRadioValueHandler,
                                          bloc
                                              .abuseNeglectData
                                              .abuseNeglectQuestionnaire
                                              .followupActId,
                                          value.name,
                                          value.id,
                                        );
                                      }).toList(),
                                    ),
                                    bloc
                                                .abuseNeglectData
                                                .abuseNeglectQuestionnaire
                                                .followupActId ==
                                            4
                                        ? TextFormField(
                                            initialValue: bloc
                                                .abuseNeglectData
                                                .abuseNeglectQuestionnaire
                                                .followupActDesc,
                                            decoration: InputDecoration(
                                                labelText: 'Describe *'),
                                            onChanged: (value) => bloc
                                                .updateFollowupActDesc(value))
                                        : Column(),
                                    SizedBox(height: 8),
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
                                        onPressed: bloc.addAbuseNeglect,
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
                                        onPressed: () => {},
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
