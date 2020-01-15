import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/legal_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/legal_history_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/checkbox_button.dart';
import '../providers/questions.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/common_text.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'education_vocation.dart';
import 'support_recovery.dart';

class LegalHistoryScreen extends StatefulWidget {
  static const routeName = '/legalHistory';
  @override
  _LegalHistoryScreenState createState() => _LegalHistoryScreenState();
}

class _LegalHistoryScreenState extends State<LegalHistoryScreen> {
  final _form = GlobalKey<FormState>();

  DateTime _selectedDate;

  bool _chargesNA = true;
  bool updateScreen = false;

  TextEditingController _attorneyNameController = TextEditingController();
  TextEditingController _attorneyPhoneController = TextEditingController();
  TextEditingController _probationOfficerNameController =
      TextEditingController();
  TextEditingController _nameCsCaseworkerController = TextEditingController();
  TextEditingController _childSupportAmtController = TextEditingController();

  void _attorneyFun(val) {
    setState(() {
      bloc.legalHistoryData.haveAttorney = val;
    });
  }

  void _probationFun(val) {
    setState(() {
      bloc.legalHistoryData.haveProbationOfficer = val;
    });
  }

  void _juvenileFun(val) {
    setState(() {
      bloc.legalHistoryData.haveYouBeenJuvenile = val;
    });
  }

  void _isJuvenileAbuseFun(val) {
    setState(() {
      bloc.legalHistoryData.isJuvenileAbuse = val;
    });
  }

  void _childrenServiceFun(val) {
    setState(() {
      bloc.legalHistoryData.haveYouBeenChildService = val;
    });
  }

  void _childSupportFun(val) {
    setState(() {
      bloc.legalHistoryData.haveCourtOrderChild = val;
    });
  }

  void _outcomeFun(val, charge) {
    setState(() {
      charge.statusId = val;
    });
  }

  void _presentDatePicker(charge) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1920),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        if (date == null) {
          return;
        }
        setState(() {
          charge.date = date.toUtc();
        });
      },
      currentTime: _selectedDate == null ? DateTime.now() : _selectedDate,
      locale: LocaleType.en,
    );
  }

  void _addCharge() {
    setState(() {
      bloc.legalHistoryData.criminalCharges
          .add(CriminalCharges(id: null, charge: '', date: null));
    });
  }

  void _removeCharge(charge) {
    setState(() {
      bloc.legalHistoryData.criminalCharges.remove(charge);
    });
  }

  void _skipClick() {
    _pushReplacementNamed(SupportRecoveryScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(EducationVocationScreen.routeName);
  }

  void _nextClick() async {
    bool isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addLegalHistory();
    // _pushReplacementNamed(SupportRecoveryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<LegalHistoryBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  void _updatedata() {
    setState(() {
      _attorneyNameController.text = bloc.legalHistoryData.attorneyName;
      _attorneyPhoneController.text = bloc.legalHistoryData.attorneyPhone;
      _probationOfficerNameController.text =
          bloc.legalHistoryData.probationOfficerName;
      _nameCsCaseworkerController.text = bloc.legalHistoryData.nameCsCaseworker;
      _childSupportAmtController.text =
          bloc.legalHistoryData.childSupportAmt == null
              ? ''
              : bloc.legalHistoryData.childSupportAmt.toString();
      if (bloc.legalHistoryData.criminalCharges.length > 0) {
        _chargesNA = false;
      }
      updateScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 200;

    final _questions = Provider.of<Questions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MainMenu(1),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(7, 1),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<LegalHistory>(
                        stream: bloc.legalHistoryObservable,
                        builder: (context, snapshotlegalHistory) {
                          if (snapshotlegalHistory.hasData && !updateScreen) {
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
                                    child: ListView(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CommonText(
                                              "1. Describe any criminal charges and their convictions",
                                              false),
                                          Container(
                                            width: 80,
                                            child: CheckboxButtonCommon(
                                              (value) {
                                                setState(() {
                                                  _chargesNA = value;
                                                });
                                              },
                                              _chargesNA,
                                              'NA',
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            child: !_chargesNA
                                                ? RaisedButton(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Text(
                                                      'Add',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    onPressed: _addCharge,
                                                  )
                                                : Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    !_chargesNA
                                        ? Container(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 50,
                                                      child: Text(''),
                                                    ),
                                                    Flexible(
                                                      fit: FlexFit.tight,
                                                      child: Text(
                                                        'Charges',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 210,
                                                      child: Text(
                                                        'Date',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 340,
                                                      child: Text(
                                                        'Outcome',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ...bloc.legalHistoryData
                                                    .criminalCharges
                                                    .map((charge) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 50,
                                                        child: IconButton(
                                                          icon: Icon(
                                                              Icons.delete),
                                                          onPressed: () {
                                                            _removeCharge(
                                                                charge);
                                                          },
                                                        ),
                                                      ),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: TextFormField(
                                                          initialValue:
                                                              charge.charge,
                                                          onChanged: (val) =>
                                                              charge.charge =
                                                                  val,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 210,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(charge
                                                                          .date ==
                                                                      null
                                                                  ? ''
                                                                  : '${DateFormat.yMd().format(charge.date)}'),
                                                            ),
                                                            FlatButton(
                                                              child: Text(
                                                                'Choose Date',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                _presentDatePicker(
                                                                    charge);
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 340,
                                                        child: StreamBuilder<
                                                                List<
                                                                    GenricDropDown>>(
                                                            stream: bloc
                                                                .chargeStatus,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Text(
                                                                    'No-Data');
                                                              }
                                                              return Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: snapshot
                                                                    .data
                                                                    .map((answer) =>
                                                                        RadioButtonCommon(
                                                                            (val) {
                                                                          _outcomeFun(
                                                                              val,
                                                                              charge);
                                                                        },
                                                                            charge.statusId,
                                                                            answer.name,
                                                                            answer.id))
                                                                    .toList(),
                                                              );
                                                            }),
                                                      ),
                                                    ],
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "2. Do you have an attorney that represents you ?",
                                        false),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesNabool
                                          .map((answer) => RadioButtonCommon(
                                              _attorneyFun,
                                              bloc.legalHistoryData
                                                  .haveAttorney,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    bloc.legalHistoryData.haveAttorney == true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              CommonText(
                                                  "Attorney's Name", true),
                                              Container(
                                                width: 250,
                                                child: TextFormField(
                                                  controller:
                                                      _attorneyNameController,
                                                  onChanged: (val) => bloc
                                                      .legalHistoryData
                                                      .attorneyName = val,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Attorney's Name is required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              CommonText(
                                                "Phone #",
                                                true,
                                              ),
                                              Container(
                                                width: 250,
                                                child: TextFormField(
                                                  controller:
                                                      _attorneyPhoneController,
                                                  onChanged: (val) => bloc
                                                      .legalHistoryData
                                                      .attorneyName = val,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Phone is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "3. Do you have a probation/parole officer?",
                                        false),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesNabool
                                          .map((answer) => RadioButtonCommon(
                                              _probationFun,
                                              bloc.legalHistoryData
                                                  .haveProbationOfficer,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    bloc.legalHistoryData
                                                .haveProbationOfficer ==
                                            true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              CommonText(
                                                  "Please provide officer's name ",
                                                  true),
                                              Container(
                                                width: 250,
                                                child: TextFormField(
                                                  controller:
                                                      _probationOfficerNameController,
                                                  onChanged: (val) => bloc
                                                      .legalHistoryData
                                                      .attorneyName = val,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Please provide officer's name  is required";
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "4. Are you involved with Juvenile Court?",
                                        false),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _juvenileFun,
                                              bloc.legalHistoryData
                                                  .haveYouBeenJuvenile,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    bloc.legalHistoryData.haveYouBeenJuvenile ==
                                            true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: _questions
                                                    .childNeglect
                                                    .map((answer) =>
                                                        RadioButtonCommon(
                                                            _isJuvenileAbuseFun,
                                                            bloc.legalHistoryData
                                                                .isJuvenileAbuse,
                                                            answer.text,
                                                            answer.index))
                                                    .toList(),
                                              )
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "5. Are you involved with Children's Services?",
                                        false),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _questions.noYesbool
                                          .map((answer) => RadioButtonCommon(
                                              _childrenServiceFun,
                                              bloc.legalHistoryData
                                                  .haveYouBeenChildService,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                    bloc.legalHistoryData
                                                .haveYouBeenChildService ==
                                            true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              CheckboxButtonCommon(
                                                (value) {
                                                  setState(() {
                                                    bloc.legalHistoryData
                                                            .haveDependentChild =
                                                        value;
                                                  });
                                                },
                                                bloc.legalHistoryData
                                                            .haveDependentChild ==
                                                        null
                                                    ? false
                                                    : bloc.legalHistoryData
                                                        .haveDependentChild,
                                                'Dependent Child',
                                              ),
                                              bloc.legalHistoryData
                                                          .haveDependentChild ==
                                                      true
                                                  ? Row(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        CommonText(
                                                            "Name of Children's Services Caseworker",
                                                            true),
                                                        Container(
                                                          width: 150,
                                                          child: TextFormField(
                                                            controller:
                                                                _nameCsCaseworkerController,
                                                            onChanged: (val) => bloc
                                                                .legalHistoryData
                                                                .nameCsCaseworker = val,
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return "Name of Children's Services Caseworker  is required";
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox.shrink(),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "6. Are you currently involved in:",
                                        false),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream: bloc.proceedings,
                                        builder:
                                            (context, snapshotProceedings) {
                                          if (!snapshotProceedings.hasData) {
                                            return Text('No-Data');
                                          }
                                          return Wrap(
                                            children: snapshotProceedings.data
                                                .map((proceeding) =>
                                                    CheckboxButtonCommon(
                                                      (value) {
                                                        setState(() {
                                                          bloc.setValueForLegalProceeding(
                                                              proceeding);
                                                        });
                                                      },
                                                      bloc.checkLegalProceedingValue(
                                                          proceeding),
                                                      proceeding.name,
                                                    ))
                                                .toList(),
                                          );
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CommonText(
                                        "7. Are you court ordered to pay child support?",
                                        false),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ..._questions.noYesbool
                                              .map((answer) =>
                                                  RadioButtonCommon(
                                                      _childSupportFun,
                                                      bloc.legalHistoryData
                                                          .haveCourtOrderChild,
                                                      answer.text,
                                                      answer.index))
                                              .toList(),
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: bloc.legalHistoryData
                                                        .haveCourtOrderChild ==
                                                    true
                                                ? Container(
                                                    width: 250,
                                                    child: TextFormField(
                                                      controller:
                                                          _childSupportAmtController,
                                                      onChanged: (val) => bloc
                                                              .legalHistoryData
                                                              .childSupportAmt =
                                                          int.parse(val),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return "Amount is required";
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ),
                                        ]),
                                  ],
                                )),
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
