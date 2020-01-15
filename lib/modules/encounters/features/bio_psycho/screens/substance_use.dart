import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/substance_use_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/substance_use_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/next_prev_button.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import '../providers/questions.dart';
import 'blood_brone_pathogenic_Infection_risk.dart';
import 'education_vocation.dart';

class SubstanceUseScreen extends StatefulWidget {
  SubstanceUseScreen({Key key}) : super(key: key);
  static const routeName = '/substanceUse';
  @override
  _SubstanceUseScreenState createState() => _SubstanceUseScreenState();
}

class _SubstanceUseScreenState extends State<SubstanceUseScreen> {
  final _form = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  int _physicalHealthRadioValue = -1;
  int _botheredUrgeRadioValue = -1;
  int _botheredByArgRadioValue = -1;
  int _confidentNotDrinkRadioValue = -1;
  int _religionRecoveryRadioValue = -1;
  int _enoughIncomeRadioValue = -1;
  int _progressRadioValue = -1;

  void _physicalHealthRadioValueHandler(val) {
    setState(() => _physicalHealthRadioValue = val);
  }

  void _botheredUrgeRadioValueHandler(val) {
    setState(() => _botheredUrgeRadioValue = val);
  }

  void _botheredByArgRadioValueHandler(val) {
    setState(() => _botheredByArgRadioValue = val);
  }

  void _confidentNotDrinkRadioValueHandler(val) {
    setState(() => _confidentNotDrinkRadioValue = val);
  }

  void _religionRecoveryRadioValueHandler(val) {
    setState(() => _religionRecoveryRadioValue = val);
  }

  void _enoughIncomeRadioValueHandler(val) {
    setState(() => _enoughIncomeRadioValue = val);
  }

  void _progressRadioValueHandler(val) {
    setState(() => _progressRadioValue = val);
  }

  void _skipClick() {
    _pushReplacementNamed(EducationVocationScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(BloodBronePathogenicInfectionRiskScreen.routeName);
  }

  void _nextClick() {
    _pushReplacementNamed(EducationVocationScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  TextEditingController _fallingAsleepController,
      _depressedController,
      _anyAlcoholController,
      _atLeastDrinkController,
      _illegalMedicationsController,
      _selfHelpMeetingController,
      _increasedRiskController,
      _spendMuchTimeController,
      _supportiveController;

  final bloc = sl<SubstanceUseBloc>();

  List<GroupModel> _healthStatusRadioValues = [],
      _botheredUrgeRadioValues = [],
      _confidentNotDrinkRadioValues = [],
      _religionRecoveryRadioValues = [],
      _botheredByArgRadioValues = [],
      _progressRadioValues = [];

  List<GroupModel> _noYes = [
    GroupModel("No (0)", 0),
    GroupModel("Yes (30)", 1)
  ];

  SubstanceUseModel _substanceUseModel;

  void _updateSubstanceUse(SubstanceUseModel data) {
    setState(() {
      _substanceUseModel = data;

      if (data.id != null && data.id > 0) {
        _physicalHealthRadioValue = data.physicalHealthId;
        if (data.numOfDaysAsleep != null)
          _fallingAsleepController.text = data.numOfDaysAsleep.toString();

        if (data.numOfDaysDepression != null)
          _depressedController.text = data.numOfDaysDepression.toString();

        if (data.numOfDaysAlcoholIntake != null)
          _anyAlcoholController.text = data.numOfDaysAlcoholIntake.toString();

        if (data.alcoholIntakeFreq != null)
          _atLeastDrinkController.text = data.alcoholIntakeFreq.toString();

        if (data.numOfDaysDrugabuse != null)
          _illegalMedicationsController.text =
              data.numOfDaysDrugabuse.toString();

        if (data.substanceDrugs != null && data.substanceDrugs.length > 0) {
          data.substanceDrugs.forEach((s) {
            int _tempIndex = _drugsWidgetList
                .where((_SubstanceDrugWidget sub) => sub.id == s.addictedId)
                .single
                .index;
            _drugsCheckValues[_tempIndex] = true;
            _drugsController[_tempIndex].text = s.numOfDays.toString();
          });
        }

        if (data.cravingsid != null) _botheredUrgeRadioValue = data.cravingsid;

        if (data.addictionControlId != null)
          _confidentNotDrinkRadioValue = data.addictionControlId;

        if (data.numOfDaysDrugEviction != null)
          _selfHelpMeetingController.text =
              data.numOfDaysDrugEviction.toString();

        if (data.numOfDaysDrugRisk != null)
          _increasedRiskController.text = data.numOfDaysDrugRisk.toString();

        if (data.numOfDaysRecoveryThruSpiritualityId != null)
          _religionRecoveryRadioValue =
              data.numOfDaysRecoveryThruSpiritualityId;

        if (data.numOfDaysEngaged != null)
          _spendMuchTimeController.text = data.numOfDaysEngaged.toString();

        if (data.haveEnoughIncome != null)
          _enoughIncomeRadioValue = data.haveEnoughIncome ? 1 : 0;

        if (data.numOfDaysBeenBotheredId != null)
          _botheredByArgRadioValue = data.numOfDaysBeenBotheredId;

        if (data.numOfDaysSocial != null)
          _supportiveController.text = data.numOfDaysSocial.toString();

        if (data.numOfDaysProgressRecoveryId != null)
          _progressRadioValue = data.numOfDaysProgressRecoveryId;
      }

      _updated = true;
    });
  }

  // todo-Uj type checking and validation

  void _onSavePressed() {
    setState(() {
      _substanceUseModel.physicalHealthId = _physicalHealthRadioValue;

      _substanceUseModel.numOfDaysAsleep =
          int.parse(_fallingAsleepController.text);
      _substanceUseModel.numOfDaysDepression =
          int.parse(_depressedController.text);
      _substanceUseModel.numOfDaysAlcoholIntake =
          int.parse(_anyAlcoholController.text);
      _substanceUseModel.alcoholIntakeFreq =
          int.parse(_atLeastDrinkController.text);
      _substanceUseModel.numOfDaysDrugabuse =
          int.parse(_illegalMedicationsController.text);

//      if (data.substanceDrugs != null && data.substanceDrugs.length > 0) {
//        data.substanceDrugs.forEach((s) {
//          int _tempIndex = _drugsWidgetList
//              .where((_SubstanceDrugWidget sub) => sub.id == s.addictedId)
//              .single
//              .index;
//          _drugsCheckValues[_tempIndex] = true;
//          _drugsController[_tempIndex].text = s.numOfDays.toString();
//        });
//      }

      List<SubstanceDrugs> _temp = [];

      for (int i = 0; i < _drugsWidgetList.length; i++) {
        if (_drugsCheckValues[i]) {
          int _aId = _drugsWidgetList.singleWhere((d) => d.index == i).id;
          _temp.add(SubstanceDrugs(
              addictedId: _aId,
              numOfDays: int.parse(_drugsController[i].text)));
        }
      }
      _substanceUseModel.substanceDrugs = _temp;

      _substanceUseModel.cravingsid = _botheredUrgeRadioValue;
      _substanceUseModel.addictionControlId = _confidentNotDrinkRadioValue;

      _substanceUseModel.numOfDaysDrugEviction =
          int.parse(_selfHelpMeetingController.text);
      _substanceUseModel.numOfDaysDrugRisk =
          int.parse(_increasedRiskController.text);

      _substanceUseModel.numOfDaysRecoveryThruSpiritualityId =
          _religionRecoveryRadioValue;

      _substanceUseModel.numOfDaysEngaged =
          int.parse(_spendMuchTimeController.text);

      _substanceUseModel.haveEnoughIncome =
          (_enoughIncomeRadioValue == 1) ? true : false;

      _substanceUseModel.numOfDaysBeenBotheredId = _botheredByArgRadioValue;

      _substanceUseModel.numOfDaysSocial =
          int.parse(_supportiveController.text);

      _substanceUseModel.numOfDaysProgressRecoveryId = _progressRadioValue;

      bloc.onSavePressed(_substanceUseModel);
    });
  }

  @override
  void initState() {
    bloc.initialize();

    _fallingAsleepController = TextEditingController();
    _depressedController = TextEditingController();
    _anyAlcoholController = TextEditingController();
    _atLeastDrinkController = TextEditingController();
    _illegalMedicationsController = TextEditingController();

    _selfHelpMeetingController = TextEditingController();
    _increasedRiskController = TextEditingController();
    _spendMuchTimeController = TextEditingController();
    _supportiveController = TextEditingController();
    super.initState();
  }

  bool _updated = false,
      _healthStatusLoaded = false,
      _botheredUrgeLoaded = false,
      _confidentNotDrinkLoaded = false,
      _religionRecoveryLoaded = false,
      _botheredByArgLoaded = false,
      _progressLoaded = false;

  Widget _physicalHealthWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "1. In the past 30 days, how would you say your physical health has been?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.physicalHealth,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_healthStatusLoaded) {
                _healthStatusRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _healthStatusLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _healthStatusRadioValues
                    .map((answer) => RadioButtonCommon(
                        _physicalHealthRadioValueHandler,
                        _physicalHealthRadioValue,
                        answer.text,
                        answer.index))
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _botheredUrgeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "8. In the past 30 days, how much were you bothered by cravings or urges to drink alcohol or use drugs?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.daysConfigSubstance,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_botheredUrgeLoaded) {
                _botheredUrgeRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _botheredUrgeLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _botheredUrgeRadioValues
                    .map((answer) => RadioButtonCommon(
                          _botheredUrgeRadioValueHandler,
                          _botheredUrgeRadioValue,
                          answer.text,
                          answer.index,
                        ))
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _confidentNotDrinkWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "9. How confident are you that you will NOT use alcohol and drugs in the next 30 days?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.daysConfigSubstance,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_confidentNotDrinkLoaded) {
                _confidentNotDrinkRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _confidentNotDrinkLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _confidentNotDrinkRadioValues
                    .map((answer) => RadioButtonCommon(
                        _confidentNotDrinkRadioValueHandler,
                        _confidentNotDrinkRadioValue,
                        answer.text,
                        answer.index))
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _religionRecoveryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "12. Does your religion or spirituality help support your recovery?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.daysConfigSubstance,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_religionRecoveryLoaded) {
                _religionRecoveryRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _religionRecoveryLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _religionRecoveryRadioValues
                    .map((answer) => RadioButtonCommon(
                        _religionRecoveryRadioValueHandler,
                        _religionRecoveryRadioValue,
                        answer.text,
                        answer.index))
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _botheredByArgWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "15. In the past 30 days, how much have you been bothered by arguments or problems getting along with any family members or friends?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.daysConfigSubstance,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_botheredByArgLoaded) {
                _botheredByArgRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _botheredByArgLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _botheredByArgRadioValues
                    .map((answer) => RadioButtonCommon(
                        _botheredByArgRadioValueHandler,
                        _botheredByArgRadioValue,
                        answer.text,
                        answer.index))
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _progressWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "17. How satisfied are you with your progress toward achieving your recovery goals?",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.daysConfigSubstance,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_progressLoaded) {
                _progressRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _progressLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _progressRadioValues
                    .map((answer) => RadioButtonCommon(
                        _progressRadioValueHandler,
                        _progressRadioValue,
                        answer.text,
                        answer.index))
                    .toList(),
              );
            }),
      ],
    );
  }

  bool _drugsLoaded = false;
  List<_SubstanceDrugWidget> _drugsWidgetList = [];
  List<bool> _drugsCheckValues = [];
  List<TextEditingController> _drugsController = [];
  List<SubstanceUseSelectModel> _drugs = [];

  Widget _drugWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "7. In the past 30 days, how many days did you use any of the following drugs:",
          false,
        ),
        StreamBuilder<List<SubstanceUseSelectModel>>(
            stream: bloc.addictedDrugs,
            builder: (context,
                AsyncSnapshot<List<SubstanceUseSelectModel>> snapshot) {
              if (snapshot.hasData && !_drugsLoaded) {
                _drugs = snapshot.data;
                for (int i = 0; i < snapshot.data.length; i++) {
                  _drugsCheckValues.add(false);
                  _drugsController.add(TextEditingController());
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _drugsLoaded = true;
                  });
                });
              }

              _drugsWidgetList = [];
              for (int i = 0; i < _drugs.length; i++) {
                _drugsWidgetList.add(_SubstanceDrugWidget(
                  i,
                  _drugs[i].id,
                  title: _drugs[i].name,
                  onChanged: (val) => _onChange(val, i),
                  value: _drugsCheckValues[i],
                  controller: _drugsController[i],
                ));
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _drugsWidgetList.length,
                itemBuilder: (context, index) => _drugsWidgetList[index],
                separatorBuilder: (_, __) => SizedBox(height: 12),
              );
            }),
      ],
    );
  }

  _onChange(val, index) {
    setState(() {
      _drugsCheckValues[index] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final deviceHeightPercent = deviceSize.height - 200;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          MainMenu(1),
          Row(
            children: <Widget>[
              Container(
                width: (blockSizeHorizontal * 20),
                height: deviceHeightPercent,
                child: SubMenu(5, 1),
              ),
              Container(
                width: (blockSizeHorizontal * 80),
                height: deviceHeightPercent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StreamBuilder<SubstanceUseModel>(
                      stream: bloc.substanceUseObservable,
                      builder:
                          (context, AsyncSnapshot<SubstanceUseModel> snapshot) {
                        if (snapshot.hasData && !_updated) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _updateSubstanceUse(snapshot.data);
                          });
                        }

                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                              NextPreButton(
                                  _skipClick, _previousClick, _nextClick),
                              Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    _physicalHealthWidget(),
                                    SizedBox(height: 12),
                                    CommonText(
                                      "2. In the past 30 days, how may nights did you have trouble falling asleep or staying asleep?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                _fallingAsleepController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "3. In the past 30 days, how many days have you felt depressed, anxious, angry or very upset throughout most of the day?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller: _depressedController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "4. In the past 30 days, how many days did you drink ANY alcohol?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller: _anyAlcoholController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "5. In the past 30 days, how may days, how may days did you have at least 5 drinks (if you are a man) or at least 4 drinks (if you are a woman)? [One drink is considered one shot of hard liquor (1.5 oz) or 12-ounce can/bottle of beer or t-ounce glass of wine.]",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller: _atLeastDrinkController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "6. In the past 30 days, how many days did you use any illegal or street drugs or abuse any prescription medications?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                _illegalMedicationsController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    _drugWidget(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _botheredUrgeWidget(),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    _confidentNotDrinkWidget(),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    CommonText(
                                      "10. In the past 30 days, how many days did you attend self-help meetings like AA or NA to support your recovery?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                _selfHelpMeetingController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      '11. In the past 30 days, how many days were you in any situations or with any people that might put you at an increased risk for using alcohol or drugs(i.e., around risky "people, places or things")?',
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                _increasedRiskController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    _religionRecoveryWidget(),
                                    SizedBox(height: 12),
                                    CommonText(
                                      "13. In the past 30 days, how many days did you spend much of the time at work, school, or doing volunteer work?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller:
                                                _spendMuchTimeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "14. Do you have enough income (from legal sources) to pay for necessities such as housing, transportation, food and clothing for yourself and your dependents?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _noYes
                                          .map((answer) => RadioButtonCommon(
                                              _enoughIncomeRadioValueHandler,
                                              _enoughIncomeRadioValue,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    SizedBox(height: 24),
                                    _botheredByArgWidget(),
                                    SizedBox(height: 24),
                                    CommonText(
                                      "16. In the past 30 days, how many days did you contact or spend time with any family members or friends who are supportive of your recovery?",
                                      false,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 175,
                                          margin:
                                              EdgeInsets.only(left: 16, top: 8),
                                          child: TextFormField(
                                            controller: _supportiveController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 8, bottom: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    _progressWidget(),
                                    SizedBox(height: 24),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: MaterialButton(
                                            onPressed: _onSavePressed,
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
                                            onPressed: () =>
                                                print('Pressed Save'),
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
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubstanceDrugWidget extends StatelessWidget {
  final int index;
  final int id;
  final String title;
  final bool value;
  final Function(bool) onChanged;
  final TextEditingController controller;

  _SubstanceDrugWidget(
    this.index,
    this.id, {
    this.title,
    this.value,
    this.onChanged,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 175,
              margin: EdgeInsets.only(left: 16, top: 8),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
