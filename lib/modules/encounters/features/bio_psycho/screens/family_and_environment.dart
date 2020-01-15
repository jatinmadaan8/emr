import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/family_environment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/family_environment_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/questions.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'problem_check_list.dart';
import 'cultural_religious_background.dart';

class FamilyandEnvironmentScreen extends StatefulWidget {
  static const routeName = '/familyandEnvironment';
  @override
  _FamilyandEnvironmentScreenState createState() =>
      _FamilyandEnvironmentScreenState();
}

class _FamilyandEnvironmentScreenState
    extends State<FamilyandEnvironmentScreen> {
  final _form = GlobalKey<FormState>();

  int _selcteRelBroOrSis = -1;

  final bloc = sl<FamilyEnvironmentBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  String _movedlifeTimeError;
  String _myRelationshipError;
  String _aschildError;
  String _disciplineIReceivedError;

  void _selctedeliveryFun(val) {
    setState(() {
      bloc.familyEnvironmentData.hadComplicationsPregnancy = val;
    });
  }

  void _selctedBroOrSisFun(val) {
    setState(() {
      bloc.familyEnvironmentData.isHaveSiblings = val;
    });
  }

  void _selcteRelBroOrSisFun(val) {
    setState(() {
      _myRelationshipError = null;
      bloc.familyEnvironmentData.relWithSiblingsId = val;
    });
  }

  void _answerQuestion(val) {
    setState(() => _selcteRelBroOrSis = val);
  }

  void _selcteAsChildFun(val) {
    setState(() {
      _aschildError = null;
      bloc.familyEnvironmentData.childhoodLifeId = val;
    });
  }

  void _selcteDisciplineFun(val) {
    setState(() {
      _disciplineIReceivedError = null;
      bloc.familyEnvironmentData.disciplineId = val;
    });
  }

  void _haveChildrenFun(val) {
    setState(() => bloc.familyEnvironmentData.isHaveChildren = val);
  }

  void _childrenCustodyFun(val) {
    setState(() => bloc.familyEnvironmentData.haveChildCustody = val);
  }

  void _seekingTreatmentFun(val) {
    setState(() => bloc.familyEnvironmentData.seekingReunification = val);
  }

  void _havePetsFun(val) {
    setState(() => bloc.familyEnvironmentData.havePets = val);
  }

  void _currentLivingSituationFun(val) {
    setState(
        () => bloc.familyEnvironmentData.haveConcernsStabilityLiving = val);
  }

  void _currentHomeLifeFun(val) {
    setState(() => bloc.familyEnvironmentData.haveDomesticStress = val);
  }

  void _movedInLifetimeFun(val) {
    setState(() {
      _movedlifeTimeError = null;
      bloc.familyEnvironmentData.movedInLifetimeId = val;
    });
  }

  void _skipClick() {
    _pushReplacementNamed(CulturalReligiousBackgroundScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(ProblemCheckListScreen.routeName);
  }

  void _nextClick() async {
    bool isValid = _form.currentState.validate();

    if (bloc.familyEnvironmentData.movedInLifetimeId == null) {
      setState(() {
        _movedlifeTimeError = "Select one option required";
      });
      isValid = false;
    }
    if (bloc.familyEnvironmentData.relWithSiblingsId == null) {
      setState(() {
        _myRelationshipError = "Select one option  required";
      });
      isValid = false;
    }
    if (bloc.familyEnvironmentData.childhoodLifeId == null) {
      setState(() {
        _aschildError = "Select one option required";
      });
      isValid = false;
    }

    if (bloc.familyEnvironmentData.disciplineId == null) {
      setState(() {
        _disciplineIReceivedError = "Select one option required";
      });
      isValid = false;
    }

    if (!isValid) {
      return;
    }
    await bloc.addFamilyEnviroment();
    _pushReplacementNamed(CulturalReligiousBackgroundScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  bool updateScreen = true;

  void _updatedata() {
    setState(() {
      updateScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final blockSizeHorizontalSecond = (blockSizeHorizontal * 75) / 100;
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
                  child: SubMenu(2, 1),
                ),
                Container(
                  width: (blockSizeHorizontal * 80),
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<FamilyEnvironment>(
                        stream: bloc.familyEnvironment,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !updateScreen) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updatedata();
                            });
                          }

                          return Form(
                            key: _form,
                            child: Column(
                              children: <Widget>[
                                NextPreButton(
                                    _skipClick, _previousClick, _nextClick),
                                Expanded(
                                  child: ListView(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CommonText(
                                            '1. How many times have you moved(Lifetime) ?',
                                            true),
                                      ],
                                    ),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream: bloc.movedLifetime,
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
                                                        _movedInLifetimeFun,
                                                        bloc.familyEnvironmentData
                                                            .movedInLifetimeId,
                                                        answer.name,
                                                        answer.id))
                                                .toList(),
                                          );
                                        }),
                                    _movedlifeTimeError == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            _movedlifeTimeError ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15.0),
                                      child: CommonText(
                                          'How many times in the past year ?',
                                          false),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 35.0),
                                      child: Slider(
                                        activeColor: Colors.grey,
                                        min: 0,
                                        max: 5.0,
                                        divisions: 5,
                                        onChanged: (pastYear) {
                                          setState(() => bloc
                                                  .familyEnvironmentData
                                                  .movedInLifetimeDesc =
                                              pastYear.toString());
                                        },
                                        value: bloc.familyEnvironmentData
                                                    .movedInLifetimeDesc ==
                                                null
                                            ? 0.0
                                            : double.parse(bloc
                                                .familyEnvironmentData
                                                .movedInLifetimeDesc),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 60),
                                      child: getmonthsSliderText(
                                          MainAxisAlignment.spaceBetween),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CommonText(
                                        "2. Are you aware of any complications during your mothers's pregnancy with you or your delivery ?",
                                        false),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _selctedeliveryFun,
                                              bloc.familyEnvironmentData
                                                  .hadComplicationsPregnancy,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .hadComplicationsPregnancy ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                  .familyEnvironmentData
                                                  .complicationsPregnancyDesc,
                                              onChanged: (val) => bloc
                                                  .familyEnvironmentData
                                                  .haveDomesticStressDesc = val,
                                              decoration: InputDecoration(
                                                  labelText: 'Explain'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Explain required';
                                                }
                                                return null;
                                              },
                                            )
                                          : null,
                                    ),
                                    CommonText(
                                      "3. Do you have any brothers or sisters ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _selctedBroOrSisFun,
                                              bloc.familyEnvironmentData
                                                  .isHaveSiblings,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .isHaveSiblings ==
                                              true)
                                          ? Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 35.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 35),
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    45),
                                                            child: Text(
                                                                'Brothers'),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    30),
                                                            child:
                                                                Text('Sisters'),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    46),
                                                            child: Slider(
                                                              activeColor:
                                                                  Colors.grey,
                                                              min: 0.0,
                                                              max: 5.0,
                                                              divisions: 5,
                                                              onChanged:
                                                                  (brothers) {
                                                                setState(() {
                                                                  bloc.familyEnvironmentData
                                                                          .numOfBrothers =
                                                                      brothers
                                                                          .toInt();
                                                                });
                                                              },
                                                              value: bloc.familyEnvironmentData
                                                                          .numOfBrothers ==
                                                                      null
                                                                  ? 0.0
                                                                  : bloc
                                                                      .familyEnvironmentData
                                                                      .numOfBrothers
                                                                      .toDouble(),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    46),
                                                            child: Slider(
                                                              activeColor:
                                                                  Colors.grey,
                                                              min: 0.0,
                                                              max: 5.0,
                                                              divisions: 5,
                                                              onChanged:
                                                                  (sisters) {
                                                                setState(() => bloc
                                                                        .familyEnvironmentData
                                                                        .numOfSisters =
                                                                    sisters
                                                                        .toInt());
                                                              },
                                                              value: bloc.familyEnvironmentData
                                                                          .numOfSisters ==
                                                                      null
                                                                  ? 0.0
                                                                  : bloc
                                                                      .familyEnvironmentData
                                                                      .numOfSisters
                                                                      .toDouble(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width:
                                                          blockSizeHorizontalSecond *
                                                              43,
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 35.0),
                                                      child: getmonthsSliderText(
                                                          MainAxisAlignment
                                                              .spaceBetween),
                                                    ),
                                                    // SizedBox(
                                                    //   width: 30,
                                                    // ),
                                                    Container(
                                                      width:
                                                          blockSizeHorizontalSecond *
                                                              43,
                                                      margin: EdgeInsets.only(
                                                          left: 30,
                                                          right: 35.0),
                                                      child: getmonthsSliderText(
                                                          MainAxisAlignment
                                                              .spaceBetween),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: 35.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 35),
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    45),
                                                            child: Text(
                                                                'Half-Siblings'),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 15),
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    45),
                                                            child: Text(
                                                                'Step-Siblings'),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: <Widget>[
                                                          Container(
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    46),
                                                            child: Slider(
                                                              activeColor:
                                                                  Colors.grey,
                                                              min: 0.0,
                                                              max: 5.0,
                                                              divisions: 5,
                                                              onChanged:
                                                                  (halfSiblings) {
                                                                setState(() => bloc
                                                                        .familyEnvironmentData
                                                                        .numOfHalfSiblings =
                                                                    halfSiblings
                                                                        .toInt());
                                                              },
                                                              value: bloc.familyEnvironmentData
                                                                          .numOfHalfSiblings ==
                                                                      null
                                                                  ? 0.0
                                                                  : bloc
                                                                      .familyEnvironmentData
                                                                      .numOfHalfSiblings
                                                                      .toDouble(),
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                (blockSizeHorizontalSecond *
                                                                    46),
                                                            child: Slider(
                                                              activeColor:
                                                                  Colors.grey,
                                                              min: 0.0,
                                                              max: 5.0,
                                                              onChanged:
                                                                  (stepSiblings) {
                                                                setState(() => bloc
                                                                        .familyEnvironmentData
                                                                        .numOfStepSiblings =
                                                                    stepSiblings
                                                                        .toInt());
                                                              },
                                                              value: bloc.familyEnvironmentData
                                                                          .numOfStepSiblings ==
                                                                      null
                                                                  ? 0.0
                                                                  : bloc
                                                                      .familyEnvironmentData
                                                                      .numOfStepSiblings
                                                                      .toDouble(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width:
                                                          blockSizeHorizontalSecond *
                                                              43,
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 35.0),
                                                      child: getmonthsSliderText(
                                                          MainAxisAlignment
                                                              .spaceBetween),
                                                    ),
                                                    SizedBox(
                                                      width: 0,
                                                    ),
                                                    Container(
                                                      width:
                                                          blockSizeHorizontalSecond *
                                                              43,
                                                      margin: EdgeInsets.only(
                                                          left: 30,
                                                          right: 35.0),
                                                      child: getmonthsSliderText(
                                                          MainAxisAlignment
                                                              .spaceBetween),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            )
                                          : null,
                                    ),
                                    CommonText(
                                      "4. My relationship with my brothers and sisters is/was ? ",
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
                                                        _selcteRelBroOrSisFun,
                                                        bloc.familyEnvironmentData
                                                            .relWithSiblingsId,
                                                        answer.name,
                                                        answer.id))
                                                .toList(),
                                          );
                                        }),
                                    _myRelationshipError == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            _myRelationshipError ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                    CommonText(
                                      "5. As a child i was/am ?",
                                      true,
                                    ),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream: bloc.childhoodLifestyle,
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
                                                        _selcteAsChildFun,
                                                        bloc.familyEnvironmentData
                                                            .childhoodLifeId,
                                                        answer.name,
                                                        answer.id))
                                                .toList(),
                                          );
                                        }),
                                    _aschildError == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            _aschildError ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                    CommonText(
                                      "6. The discipline i received was/is ?",
                                      true,
                                    ),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream: bloc.childhoodLifestyle,
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
                                                        _selcteDisciplineFun,
                                                        bloc.familyEnvironmentData
                                                            .disciplineId,
                                                        answer.name,
                                                        answer.id))
                                                .toList(),
                                          );
                                        }),
                                    _disciplineIReceivedError == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            _disciplineIReceivedError ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                    CommonText(
                                      "7. Do you have children ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _haveChildrenFun,
                                              bloc.familyEnvironmentData
                                                  .isHaveChildren,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .isHaveChildren ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                          .familyEnvironmentData
                                                          .numOfChildren ==
                                                      null
                                                  ? ''
                                                  : bloc.familyEnvironmentData
                                                      .numOfChildren
                                                      .toString(),
                                              onChanged: (val) => bloc
                                                      .familyEnvironmentData
                                                      .numOfChildren =
                                                  int.parse(val),
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  labelText: 'how many*'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'how many is required';
                                                }
                                                return null;
                                              },
                                            )
                                          : null,
                                    ),
                                    CommonText(
                                      "8. Have your children always remained in your custody ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesNabool
                                          .map((answer) => RadioButtonCommon(
                                              _childrenCustodyFun,
                                              bloc.familyEnvironmentData
                                                  .haveChildCustody,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    CommonText(
                                      "9. Are you seeking treatment as apart of a re-unification plan ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesNabool
                                          .map((answer) => RadioButtonCommon(
                                              _seekingTreatmentFun,
                                              bloc.familyEnvironmentData
                                                  .seekingReunification,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: CommonText(
                                        "(If so, we would like a copy to assist you.)",
                                        false,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CommonText(
                                      "10. Do you have pets ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _havePetsFun,
                                              bloc.familyEnvironmentData
                                                  .havePets,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .havePets ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                  .familyEnvironmentData
                                                  .petsKind,
                                              onChanged: (val) => bloc
                                                  .familyEnvironmentData
                                                  .petsKind = val,
                                              decoration: InputDecoration(
                                                  labelText: 'What kind*'),
                                              maxLines: 3,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'What kind';
                                                }
                                                return null;
                                              },
                                            )
                                          : null,
                                    ),
                                    CommonText(
                                      "11. So you have any concerns about the stability of your current living situation ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _currentLivingSituationFun,
                                              bloc.familyEnvironmentData
                                                  .haveConcernsStabilityLiving,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .haveConcernsStabilityLiving ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                  .familyEnvironmentData
                                                  .haveConcernsStabilityLivingDesc,
                                              onChanged: (val) => bloc
                                                      .familyEnvironmentData
                                                      .haveConcernsStabilityLivingDesc =
                                                  val,
                                              decoration: InputDecoration(
                                                  labelText: 'Explain*'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Explian is required';
                                                }
                                                return null;
                                              },
                                            )
                                          : null,
                                    ),
                                    CommonText(
                                      "12. Are there any stressors currently in your home life ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _currentHomeLifeFun,
                                              bloc.familyEnvironmentData
                                                  .haveDomesticStress,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.familyEnvironmentData
                                                  .haveDomesticStress ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                  .familyEnvironmentData
                                                  .haveDomesticStressDesc,
                                              onChanged: (val) => bloc
                                                  .familyEnvironmentData
                                                  .haveDomesticStressDesc = val,
                                              decoration: InputDecoration(
                                                  labelText: 'Explain*'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Explain required';
                                                }
                                                return null;
                                              },
                                            )
                                          : null,
                                    ),
                                  ]),
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
      ),
    );
  }

  Widget getmonthsSliderText(MainAxisAlignment space) {
    return Row(
      mainAxisAlignment: space,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '0',
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('1'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('2'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('3'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('4'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('5'),
          ],
        ),
      ],
    );
  }

  Widget getmonthSlider(blockSizeHorizontalForSecond) {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20),
        width: (blockSizeHorizontalForSecond * 99),
        child: Slider(
          activeColor: Colors.grey,
          min: 0.0,
          max: 30.0,
          onChanged: (brothers) {
            // setState(() => _brothers = brothers);
          },
          value: 5,
        ));
  }
}
