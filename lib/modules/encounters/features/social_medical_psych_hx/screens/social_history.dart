import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/social_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/social_history_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/radio_button.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';

import '../providers/social_medical_psych_questions.dart';
import 'hospitalization_history.dart';

class SocialHistoryScreen extends StatefulWidget {
  SocialHistoryScreen({Key key}) : super(key: key);
  static const routeName = '/socialHistory';

  @override
  _SocialHistoryScreenState createState() => _SocialHistoryScreenState();
}

class _SocialHistoryScreenState extends State<SocialHistoryScreen> {
  final _form = GlobalKey<FormState>();

  int _maritalStatus = -1;
  int _drinks = -1;
  int _prescribedMeds = -1;
  int _coitusAge = -1;
  int _sexualPartners = -1;
  int _smokingStatus = -1;
  int _drinksPerWeek = -1;
  int _coitusAgeDropDown = -1;
  int _sexualPartnersDropDown = -1;
  int _sexualActivity = -1;
  bool _employed = false;
  bool _exercise = false;
  bool _drugs = false;

  var _perWeekList = Iterable<int>.generate(29).toList();
  var _coitusAgeList = Iterable<int>.generate(36).toList();

  String _maritalStatusError, _smokingStatusError;

  void _maritalStatusFun(val) {
    setState(() {
      _maritalStatus = val;
      _maritalStatusError = null;
    });
  }

  void _drinksFun(val) {
    setState(() => _drinks = val);
  }

  void _prescribedMedsFun(val) {
    setState(() => _prescribedMeds = val);
  }

  void _coitusAgeFun(val) {
    setState(() => _coitusAge = val);
  }

  void _sexualPartnersFun(val) {
    setState(() => _sexualPartners = val);
  }

  _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (_maritalStatus == -1) {
      setState(() {
        _maritalStatusError = "Marital Status is required";
      });

      isValid = false;
    }

    if (_smokingStatus == -1) {
      setState(() {
        _smokingStatusError = "Smoking Status is required";
      });

      isValid = false;
    }

    if (!isValid) {
      return;
    }

    setState(() {
      if (_maritalStatus != -1)
        _socialHistoryModel.maritalStatusId = _maritalStatus;
      _socialHistoryModel.employed = _employed;
      _socialHistoryModel.occupation = _occupationController.text;
      _socialHistoryModel.exercise = _exercise;

      _socialHistoryModel.exerciseType = _exerciseTypeController.text;

      if (_smokingStatus != -1)
        _socialHistoryModel.smokingStatusId = _smokingStatus;

      if (_drinks != -1)
        _socialHistoryModel.drinksYesNo = (_drinks == 1) ? true : false;

      if (_drinksPerWeek != -1)
        _socialHistoryModel.drinksPerWeek = _drinksPerWeek;

      _socialHistoryModel.drugs = _drugs;

      _socialHistoryModel.streetDrugDesc = _drugController.text;

      _socialHistoryModel.substanceAbuse = _abuseList[0].value;
      _socialHistoryModel.seatBelt = _abuseList[1].value;
      _socialHistoryModel.physicalAbuse = _abuseList[2].value;

      if (_prescribedMeds != -1)
        _socialHistoryModel.hasCompliantPrescribedTreatment =
            (_prescribedMeds == 1) ? true : false;

      if (_prescribedMeds == 0) {
        _socialHistoryModel.hasCompliantPrescribedTreatmentDesc =
            _whyController.text;
      }

      if (_coitusAgeDropDown != -1)
        _socialHistoryModel.coitusAge = _coitusAgeDropDown;

      if (_sexualPartnersDropDown != -1)
        _socialHistoryModel.sexpartnerNumber = _sexualPartnersDropDown;

      if (_sexualActivity != -1)
        _socialHistoryModel.sexualActivityId = _sexualActivity;

      _socialHistoryModel.comments = _commentController.text;
    });

    await bloc.onSavePressed(_socialHistoryModel);
  }

  void _skipClick() {
    // _pushReplacementNamed('');
  }

  void _previousClick() {
    _pushReplacementNamed(HospitalizationHistoryScreen.routeName);
  }

  void _nextClick() async {
    await _saveForm();
    // _pushReplacementNamed('');
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  bool _maritalStatusLoaded = false,
      _smokingStatusLoaded = false,
      _sexualActivityLoaded = false;

  List<GroupModel> _maritalStatusRadioValues = [],
      _smokingStatusSelectValues = [],
      _sexualActivitySelectValues = [];

  Widget _maritalStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "Marital status",
          true,
        ),
        StreamBuilder(
            stream: bloc.maritalStatus,
            builder: (BuildContext context,
                AsyncSnapshot<List<MaritalStatus>> snapshot) {
              if (snapshot.hasData && !_maritalStatusLoaded) {
                _maritalStatusRadioValues = snapshot.data
                    .map((d) => GroupModel(d.status, d.id))
                    .toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _maritalStatusLoaded = true;
                  });
                });
              }
              return Row(
                children: _maritalStatusRadioValues
                    .map((answer) => RadioButtonCommon(
                          _maritalStatusFun,
                          _maritalStatus,
                          answer.text,
                          answer.index,
                        ))
                    .toList(),
              );
            }),
        _maritalStatusError == null
            ? SizedBox.shrink()
            : Text(
                _maritalStatusError ?? "",
                style: TextStyle(color: Colors.red),
              ),
      ],
    );
  }

  Widget _smokingStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder(
            stream: bloc.smokingStatus,
            builder: (BuildContext context,
                AsyncSnapshot<List<SexualActivity>> snapshot) {
              if (snapshot.hasData && !_smokingStatusLoaded) {
                _smokingStatusSelectValues = snapshot.data
                    .map((d) => GroupModel(d.status, d.id))
                    .toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _smokingStatusLoaded = true;
                  });
                });
              }
              return DropdownButton<int>(
                value: _smokingStatus == -1 ? null : _smokingStatus,
                hint: Text('Smoking Status'),
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black54,
                  height: 1,
                ),
                onChanged: (int value) {
                  setState(() {
                    _smokingStatus = value;
                    _smokingStatusError = null;
                  });
                },
                items: _smokingStatusSelectValues
                    .map<DropdownMenuItem<int>>((answer) {
                  return DropdownMenuItem<int>(
                    value: answer.index,
                    child: Text(answer.text),
                  );
                }).toList(),
              );
            }),
        _smokingStatusError == null
            ? SizedBox.shrink()
            : Text(
                _smokingStatusError ?? "",
                style: TextStyle(color: Colors.red),
              ),
      ],
    );
  }

  Widget _sexualActivityWidget() {
    return StreamBuilder(
        stream: bloc.sexualActivity,
        builder: (BuildContext context,
            AsyncSnapshot<List<SexualActivity>> snapshot) {
          if (snapshot.hasData && !_sexualActivityLoaded) {
            _sexualActivitySelectValues =
                snapshot.data.map((d) => GroupModel(d.status, d.id)).toList();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _sexualActivityLoaded = true;
              });
            });
          }
          return Container(
            width: double.infinity,
            child: DropdownButton<int>(
              value: _sexualActivity == -1 ? null : _sexualActivity,
              hint: Text('Sexual Activity'),
              isExpanded: true,
              iconSize: 24,
              underline: Container(
                color: Colors.black54,
                height: 1,
              ),
              onChanged: (int value) {
                setState(() {
                  _sexualActivity = value;
                });
              },
              items: _sexualActivitySelectValues
                  .map<DropdownMenuItem<int>>((answer) {
                return DropdownMenuItem<int>(
                  value: answer.index,
                  child: Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(answer.text),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  SocialMedicalPsychQuestions _questions;

  final bloc = sl<SocialHistoryBloc>();

  bool _updated = false;

  TextEditingController _occupationController,
      _exerciseTypeController,
      _drugController,
      _commentController,
      _whyController;

  @override
  void initState() {
    _occupationController = TextEditingController();
    _exerciseTypeController = TextEditingController();
    _drugController = TextEditingController();
    _commentController = TextEditingController();
    _whyController = TextEditingController();

    bloc.initialize();
    super.initState();
  }

  SocialHistoryModel _socialHistoryModel;

  _updateSocialHistory(SocialHistoryModel socialHistoryModel) {
    setState(() {
      _socialHistoryModel = socialHistoryModel;

      if (socialHistoryModel.id != null && socialHistoryModel.id > 0) {
        _maritalStatus = socialHistoryModel.maritalStatusId;
        _employed = socialHistoryModel.employed ?? false;
        _occupationController.text = socialHistoryModel.occupation ?? "";
        _exercise = socialHistoryModel.exercise ?? false;
        _exerciseTypeController.text = socialHistoryModel.exerciseType ?? "";

        _smokingStatus = socialHistoryModel.smokingStatusId;

        if (socialHistoryModel.drinksYesNo != null)
          _drinks = socialHistoryModel.drinksYesNo ? 1 : 0;
        _drinksPerWeek = socialHistoryModel.drinksPerWeek;

        _drugs = socialHistoryModel.drugs ?? false;

        _drugController.text = socialHistoryModel.streetDrugDesc;

        _abuseList[0].value = socialHistoryModel.substanceAbuse ?? false;
        _abuseList[1].value = socialHistoryModel.seatBelt ?? false;
        _abuseList[2].value = socialHistoryModel.physicalAbuse ?? false;

        _prescribedMeds =
            socialHistoryModel.hasCompliantPrescribedTreatment ? 1 : 0;
        if (_prescribedMeds == 0) {
          _whyController.text =
              socialHistoryModel.hasCompliantPrescribedTreatmentDesc;
        }

        _coitusAgeDropDown = socialHistoryModel.coitusAge;
        if (socialHistoryModel.coitusAge != null)
          _coitusAge = (socialHistoryModel.coitusAge < 18) ? 0 : 1;

        _sexualPartnersDropDown = socialHistoryModel.sexpartnerNumber;
        if (socialHistoryModel.sexpartnerNumber != null)
          _sexualPartners = (socialHistoryModel.sexpartnerNumber < 4) ? 0 : 1;

        _sexualActivity = socialHistoryModel.sexualActivityId;

        _commentController.text = socialHistoryModel.comments ?? "";
      }

      _updated = true;
    });
  }

  List<GroupModelForCheckBox> _abuseList = [
    GroupModelForCheckBox('Substance Abuse', false),
    GroupModelForCheckBox('Seatbelt use', false),
    GroupModelForCheckBox('Physical/Sexual Abuse', false),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final deviceHeightPercent = deviceSize.height - 130;

    _questions = Provider.of<SocialMedicalPsychQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(6),
            Row(
              children: <Widget>[
                Container(
                  width: (blockSizeHorizontal * 20),
                  height: deviceHeightPercent,
                  child: SubMenu(5, 6),
                ),
                Container(
                  width: (blockSizeHorizontal * 80),
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<SocialHistoryModel>(
                        stream: bloc.socialHistoryObservable,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !_updated) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updateSocialHistory(snapshot.data);
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
                                      _maritalStatusWidget(),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            margin: EdgeInsets.only(top: 10),
                                            child: CheckboxButtonCommon(
                                              (value) {
                                                setState(() {
                                                  _employed = value;
                                                });
                                              },
                                              _employed,
                                              "Employed",
                                            ),
                                          ),
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(left: 30),
                                            child: TextFormField(
                                              controller: _occupationController,
                                              decoration: InputDecoration(
                                                labelText: 'Occupation',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            margin: EdgeInsets.only(top: 10),
                                            child: CheckboxButtonCommon(
                                              (value) {
                                                setState(() {
                                                  _exercise = value;
                                                });
                                              },
                                              _exercise,
                                              "Exercise",
                                            ),
                                          ),
                                          Container(
                                            width: 300,
                                            margin: EdgeInsets.only(left: 30),
                                            child: TextFormField(
                                              controller:
                                                  _exerciseTypeController,
                                              decoration: InputDecoration(
                                                labelText: 'Type',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CommonText(
                                        "Tobacco/Alcohol/Drugs",
                                        false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Smoking Status"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _smokingStatusWidget(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            child: CommonText(
                                              "Drinks",
                                              false,
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: _questions.noYes
                                                  .map(
                                                    (answer) =>
                                                        RadioButtonCommon(
                                                            _drinksFun,
                                                            _drinks,
                                                            answer.text,
                                                            answer.index),
                                                  )
                                                  .toList(),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 30),
                                            width: 120,
                                            child: DropdownButton<int>(
                                              value: _drinksPerWeek == -1
                                                  ? null
                                                  : _drinksPerWeek,
                                              hint: Text('Per Week'),
                                              isExpanded: true,
                                              iconSize: 24,
                                              underline: Container(
                                                color: Colors.black54,
                                                height: 1,
                                              ),
                                              onChanged: (int value) {
                                                setState(() {
                                                  _drinksPerWeek = value;
                                                });
                                              },
                                              items: _perWeekList
                                                  .map<DropdownMenuItem<int>>(
                                                      (answer) {
                                                return DropdownMenuItem<int>(
                                                  value: answer,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                          answer.toString())),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            margin: EdgeInsets.only(top: 10),
                                            child: CheckboxButtonCommon(
                                              (value) {
                                                setState(() {
                                                  _drugs = value;
                                                });
                                              },
                                              _drugs,
                                              "Drugs",
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: TextFormField(
                                              controller: _drugController,
                                              decoration: InputDecoration(
                                                labelText: 'Drugs',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: _abuseList
                                            .map((answer) =>
                                                CheckboxButtonCommon(
                                                  (value) {
                                                    setState(() {
                                                      answer.value = value;
                                                    });
                                                  },
                                                  answer.value,
                                                  answer.title,
                                                ))
                                            .toList(),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CommonText(
                                        "Has Client been complaint with prescribed meds/treatment ?",
                                        false,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: _questions.noYes
                                                .map((answer) =>
                                                    RadioButtonCommon(
                                                      _prescribedMedsFun,
                                                      _prescribedMeds,
                                                      answer.text,
                                                      answer.index,
                                                    ))
                                                .toList(),
                                          ),
                                          SizedBox(width: 12),
                                          (_prescribedMeds == 0)
                                              ? Container(
                                                  width: 300,
                                                  child: TextFormField(
                                                    controller: _whyController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Why?',
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CommonText(
                                        "Sexual History",
                                        false,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: CommonText(
                                                "Age of 1st Time Coitus",
                                                false),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _questions.coitusAge
                                                  .map((answer) =>
                                                      RadioButtonCommon(
                                                        _coitusAgeFun,
                                                        _coitusAge,
                                                        answer.text,
                                                        answer.index,
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            child: DropdownButton<int>(
                                              value: _coitusAgeDropDown == -1
                                                  ? null
                                                  : _coitusAgeDropDown,
                                              hint: Text('Age'),
                                              isExpanded: true,
                                              iconSize: 24,
                                              underline: Container(
                                                color: Colors.black54,
                                                height: 1,
                                              ),
                                              onChanged: (int value) {
                                                setState(() {
                                                  _coitusAgeDropDown = value;
                                                });
                                              },
                                              items: _coitusAgeList
                                                  .map<DropdownMenuItem<int>>(
                                                      (answer) {
                                                return DropdownMenuItem<int>(
                                                  value: answer,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                          answer.toString())),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: CommonText(
                                                "# Sexual Partners", false),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: _questions
                                                  .sexualPartners
                                                  .map((answer) =>
                                                      RadioButtonCommon(
                                                        _sexualPartnersFun,
                                                        _sexualPartners,
                                                        answer.text,
                                                        answer.index,
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            child: DropdownButton<int>(
                                              value:
                                                  _sexualPartnersDropDown == -1
                                                      ? null
                                                      : _sexualPartnersDropDown,
                                              hint: Text('Number'),
                                              isExpanded: true,
                                              iconSize: 24,
                                              underline: Container(
                                                color: Colors.black54,
                                                height: 1,
                                              ),
                                              onChanged: (int value) {
                                                setState(() {
                                                  _sexualPartnersDropDown =
                                                      value;
                                                });
                                              },
                                              items: _coitusAgeList
                                                  .map<DropdownMenuItem<int>>(
                                                      (answer) {
                                                return DropdownMenuItem<int>(
                                                  value: answer,
                                                  child: Container(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Text(
                                                          answer.toString())),
                                                );
                                              }).toList(),
                                            ),
                                          )
                                        ],
                                      ),
                                      _sexualActivityWidget(),
                                      Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          controller: _commentController,
                                          decoration: InputDecoration(
                                            labelText: 'Comments',
                                          ),
                                          maxLines: 3,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
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
      ),
    );
  }
}
