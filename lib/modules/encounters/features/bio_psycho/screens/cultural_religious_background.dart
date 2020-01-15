import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/cultural_religious_rackground.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/cultural_religious_background_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/questions.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'blood_brone_pathogenic_Infection_risk.dart';
import 'family_and_environment.dart';

class CulturalReligiousBackgroundScreen extends StatefulWidget {
  static const routeName = '/culturalReligiousBackground';
  @override
  _CulturalReligiousBackgroundScreenState createState() =>
      _CulturalReligiousBackgroundScreenState();
}

class _CulturalReligiousBackgroundScreenState
    extends State<CulturalReligiousBackgroundScreen> {
  final _form = GlobalKey<FormState>();

  String _qualityRadioValueError;
  bool updated = false;

  TextEditingController _holidaysTraditionsObserveController =
      TextEditingController();
  TextEditingController _whoWhatStrengthHopeController =
      TextEditingController();

  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  void _otherLanguagesFun(val) {
    setState(
        () => bloc.culturalReligiousBackgroundData.isFluentInOtherLang = val);
  }

  void _identifyYourselfFun(val) {
    setState(() =>
        bloc.culturalReligiousBackgroundData.isMemberOfReligiouCulture = val);
  }

  void _spirituallifeFun(val) {
    setState(() =>
        bloc.culturalReligiousBackgroundData.isSatisfiedSpiritually = val);
  }

  void _spiritualBeliefFun(val) {
    setState(() =>
        bloc.culturalReligiousBackgroundData.isCopeEverydayStressors = val);
  }

  void _outlookFun(val) {
    setState(() {
      _qualityRadioValueError = null;
      bloc.culturalReligiousBackgroundData.outlookId = val;
    });
  }

  void _skipClick() {
    _pushReplacementNamed(BloodBronePathogenicInfectionRiskScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(FamilyandEnvironmentScreen.routeName);
  }

  void _nextClick() async {
    bool isValid = _form.currentState.validate();

    if (bloc.culturalReligiousBackgroundData.outlookId == null) {
      setState(() {
        _qualityRadioValueError = "Please select an option!";
      });
      isValid = false;
    }
    if (!isValid) {
      return;
    }
    bloc.addCulturalReligiousBackground();
    _pushReplacementNamed(BloodBronePathogenicInfectionRiskScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<CulturalReligiousBackgroundBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata(CulturalReligiousBackground data) {
    setState(() {
      updated = true;
      _holidaysTraditionsObserveController.text =
          bloc.culturalReligiousBackgroundData.holidaysTraditionsObserve;
      _whoWhatStrengthHopeController.text =
          bloc.culturalReligiousBackgroundData.whoWhatStrengthHope;
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
              Row(
                children: <Widget>[
                  Container(
                    width: (blockSizeHorizontal * 20),
                    height: deviceHeightPercent,
                    child: SubMenu(3, 1),
                  ),
                  Container(
                    width: (blockSizeHorizontal * 80),
                    height: deviceHeightPercent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _form,
                        child: StreamBuilder<CulturalReligiousBackground>(
                            stream: bloc.culturalReligiousBackgroundObservable,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && !updated) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _updatedata(snapshot.data);
                                });
                              }

                              return Column(
                                children: <Widget>[
                                  NextPreButton(
                                      _skipClick, _previousClick, _nextClick),
                                  Expanded(
                                    child: ListView(
                                      children: <Widget>[
                                        CommonText(
                                          "1. Do you speak other languages fluently ?",
                                          false,
                                        ),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ..._questions.noYesbool
                                                  .map((answer) => RadioButtonCommon(
                                                      _otherLanguagesFun,
                                                      bloc.culturalReligiousBackgroundData
                                                          .isFluentInOtherLang,
                                                      answer.text,
                                                      answer.index))
                                                  .toList(),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                child: (bloc.culturalReligiousBackgroundData
                                                            .isFluentInOtherLang ==
                                                        true)
                                                    ? _languageDropDown()
                                                    : SizedBox.shrink(),
                                              ),
                                            ]),
                                        CommonText(
                                          "2. Do you identify yourself as a member of a religious or cultural group ?",
                                          false,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _questions.noYesbool
                                              .map((answer) => RadioButtonCommon(
                                                  _identifyYourselfFun,
                                                  bloc.culturalReligiousBackgroundData
                                                      .isMemberOfReligiouCulture,
                                                  answer.text,
                                                  answer.index))
                                              .toList(),
                                        ),
                                        Container(
                                          child: (bloc.culturalReligiousBackgroundData
                                                      .isMemberOfReligiouCulture ==
                                                  true)
                                              ? TextFormField(
                                                  initialValue: bloc
                                                      .culturalReligiousBackgroundData
                                                      .religiouCultureDesc,
                                                  decoration: InputDecoration(
                                                      labelText: 'Specify*'),
                                                  maxLines: 3,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Specify is required';
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (val) => bloc
                                                      .culturalReligiousBackgroundData
                                                      .religiouCultureDesc = val,
                                                )
                                              : null,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CommonText(
                                          "3. What holidays and traditions do you observe ?",
                                          false,
                                        ),
                                        TextFormField(
                                          controller:
                                              _holidaysTraditionsObserveController,
                                          decoration: InputDecoration(),
                                          validator: (value) {},
                                          onSaved: (value) {},
                                          onChanged: (val) => bloc
                                              .culturalReligiousBackgroundData
                                              .holidaysTraditionsObserve = val,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CommonText(
                                          "4. Who or What provides you with strength and hope ?",
                                          false,
                                        ),
                                        TextFormField(
                                          controller:
                                              _whoWhatStrengthHopeController,
                                          decoration: InputDecoration(),
                                          onChanged: (val) => bloc
                                              .culturalReligiousBackgroundData
                                              .whoWhatStrengthHope = val,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "5. Are you satisfied with your spiritual life ?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _questions.noYesbool
                                              .map((answer) => RadioButtonCommon(
                                                  _spirituallifeFun,
                                                  bloc.culturalReligiousBackgroundData
                                                      .isSatisfiedSpiritually,
                                                  answer.text,
                                                  answer.index))
                                              .toList(),
                                        ),
                                        CommonText(
                                          "6. Do your religious/spiritual belief help you cope with everyday stressors?",
                                          false,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _questions.noYesbool
                                              .map((answer) => RadioButtonCommon(
                                                  _spiritualBeliefFun,
                                                  bloc.culturalReligiousBackgroundData
                                                      .isCopeEverydayStressors,
                                                  answer.text,
                                                  answer.index))
                                              .toList(),
                                        ),
                                        CommonText(
                                          "7. Overall is your outlook on life: ",
                                          true,
                                        ),
                                        StreamBuilder<List<GenricQuestions>>(
                                            stream: bloc
                                                .culturalandreligiousOutlookObservable,
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Text('No-Data');
                                              }
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: snapshot.data
                                                        .map((answer) =>
                                                            RadioButtonCommon(
                                                                _outlookFun,
                                                                bloc.culturalReligiousBackgroundData
                                                                    .outlookId,
                                                                answer
                                                                    .description,
                                                                answer.id))
                                                        .toList(),
                                                  ),
                                                  _qualityRadioValueError ==
                                                          null
                                                      ? SizedBox.shrink()
                                                      : Text(
                                                          _qualityRadioValueError ??
                                                              "",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                  (bloc.culturalReligiousBackgroundData
                                                              .outlookId ==
                                                          5)
                                                      ? TextFormField(
                                                          initialValue: bloc
                                                              .culturalReligiousBackgroundData
                                                              .otherOutlook,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Other *',
                                                          ),
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Other is required';
                                                            }
                                                            return null;
                                                          },
                                                          onChanged: (val) => bloc
                                                              .culturalReligiousBackgroundData
                                                              .otherOutlook = val,
                                                        )
                                                      : SizedBox(
                                                          height: 5,
                                                        ),
                                                ],
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _languageDropDown() {
    return StreamBuilder<List<Language>>(
        stream: bloc.languageListObservable,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }
          return Container(
            width: 150,
            child: DropdownButton<String>(
              hint: Text('Informant'),
              isExpanded: true,
              iconSize: 24,
              value: bloc.culturalReligiousBackgroundData.langDesc,
              onChanged: (newValue) {
                setState(() {
                  bloc.culturalReligiousBackgroundData.langDesc = newValue;
                });
              },
              items: snapshot.data
                  ?.map<DropdownMenuItem<String>>((Language answer) {
                return DropdownMenuItem<String>(
                  value: answer.value,
                  child: Text(answer.value, style: _optionTextStyle),
                );
              })?.toList(),
            ),
          );
        });
  }
}
