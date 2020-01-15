import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/support_recovery.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/support_recovery_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/radio_button.dart';
import '../providers/questions.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'legal_history.dart';
import 'further_evaluation_needed.dart';

class SupportRecoveryScreen extends StatefulWidget {
  SupportRecoveryScreen({Key key}) : super(key: key);
  static const routeName = '/supportRecovery';
  @override
  _SupportRecoveryScreenState createState() => _SupportRecoveryScreenState();
}

class _SupportRecoveryScreenState extends State<SupportRecoveryScreen> {
  final _form = GlobalKey<FormState>();

  bool updateScreen = false;
  TextEditingController _familyExpectationsController = TextEditingController();
  void _circleoffriendsFun(val) {
    setState(() {
      bloc.supportRecoveryData.isSatisfiedCircleOfFriends = val;
    });
  }

  void _helpgroupsFun(val) {
    setState(() {
      bloc.supportRecoveryData.isPartofSelfHelpGroup = val;
    });
  }

  void _environmentSupportiveFun(val) {
    setState(() {
      bloc.supportRecoveryData.isFamilySupportive = val;
    });
  }

  void _positiveChangeFun(val) {
    setState(() {
      bloc.supportRecoveryData.isFriendsHelpful = val;
    });
  }

  void _preventorhurtFun(val) {
    setState(() {
      bloc.supportRecoveryData.isFreindsPreventing = val;
    });
  }

  void _skipClick() {
    _pushReplacementNamed(FurtherEvaluationNeededScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(LegalHistoryScreen.routeName);
  }

  void _nextClick() async {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addSupportRecovery();
    _pushReplacementNamed(FurtherEvaluationNeededScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<SupportRecoveryBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata() {
    setState(() {
      _familyExpectationsController.text =
          bloc.supportRecoveryData.familyExpectations;
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
                  child: SubMenu(8, 1),
                ),
                Container(
                  width: (blockSizeHorizontal * 80),
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _form,
                      child: StreamBuilder<SupportRecovery>(
                          stream: bloc.supportRecovery,
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
                                      "1. Are you satisfied with your circle of friends?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _circleoffriendsFun,
                                              bloc.supportRecoveryData
                                                  .isSatisfiedCircleOfFriends,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    CommonText(
                                      "2. Do you help any self-help groups ?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _helpgroupsFun,
                                              bloc.supportRecoveryData
                                                  .isPartofSelfHelpGroup,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    Container(
                                      child: (bloc.supportRecoveryData
                                                  .isPartofSelfHelpGroup ==
                                              true)
                                          ? TextFormField(
                                              initialValue: bloc
                                                  .supportRecoveryData
                                                  .selfHelpGroupDesc,
                                              decoration: InputDecoration(
                                                  labelText: 'Explain *'),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Explain is required';
                                                }
                                                return null;
                                              },
                                              onChanged: (val) => bloc
                                                  .supportRecoveryData
                                                  .selfHelpGroupDesc = val,
                                            )
                                          : null,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                      "3. Is your family environment supportive of you making positive change?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _environmentSupportiveFun,
                                              bloc.supportRecoveryData
                                                  .isFamilySupportive,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                      "4. What is your family's exceptation of treatment ?",
                                      false,
                                    ),
                                    TextFormField(
                                      controller: _familyExpectationsController,
                                      decoration: InputDecoration(),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'family exceptation  is required';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) => bloc
                                          .supportRecoveryData
                                          .familyExpectations = val,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                      "5. Do you have friends who will be help to you make positive change?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _positiveChangeFun,
                                              bloc.supportRecoveryData
                                                  .isFriendsHelpful,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    CommonText(
                                      "6. Do you have friends who will prevent or hurt you from making positive changes?",
                                      false,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _preventorhurtFun,
                                              bloc.supportRecoveryData
                                                  .isFreindsPreventing,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
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
        ));
  }
}
