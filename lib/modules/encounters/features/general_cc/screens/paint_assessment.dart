import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/pain_assessment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/general_cc/block/pain_assessment.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/common_text.dart';
import '../../widgets/radio_button.dart';

import '../../general_cc/providers/general_cc_questions.dart';

class PainAssessmentWidget extends StatefulWidget {
  static const routeName = '/painAssessment';

  @override
  _PainAssessmentWidgetState createState() => _PainAssessmentWidgetState();
}

class _PainAssessmentWidgetState extends State<PainAssessmentWidget> {
  var _form = GlobalKey<FormState>();

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

  int _painRadioValue = 0;
  int _stageRadioValue = 0;

  TextEditingController onsetController;
  DateTime onsetDate;
  String _qualityRadioValueError;
  String _painManagementReferralError;
  String _typeError;
  String _painScaleError;
  String _clientgoalError;
  String _locationError;
  String _durationError;

  final bloc = sl<PainAssessmentBloc>();

  TextEditingController aggtavatingController = TextEditingController();
  TextEditingController alleviatingController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController impactofFunController = TextEditingController();
  TextEditingController currentPlanController = TextEditingController();

  _painRadioValueHandler(val) {
    setState(() {
      _painRadioValue = val;
      if (_painRadioValue == 1) {
        bloc.painAssessmentData.isPain = true;
      } else {
        bloc.painAssessmentData.isPain = false;
      }
    });
  }

  _stageRadioValueHandler(val) {
    setState(() {
      _stageRadioValue = val;
      if (_stageRadioValue == 1) {
        bloc.painAssessmentData.isControlled = true;
      } else {
        bloc.painAssessmentData.isControlled = false;
      }
    });
  }

  _typeRadioValueHandler(val) {
    setState(() {
      bloc.painAssessmentData.painType = val;
      _typeError = null;
    });
  }

  _qualityRadioValueHandler(val) {
    setState(() {
      bloc.painAssessmentData.qualityId = val;
      _qualityRadioValueError = null;
    });
  }

  _painManagementReferralRadioValueHandler(val) {
    setState(() {
      bloc.painAssessmentData.painMngmtReferralId = val;
      _painManagementReferralError = null;
    });
  }

  double painScale = 0;
  double goalPainScale = 0;
  bool updated = false;

  var _separator = Container(
    margin: EdgeInsets.only(top: 4, bottom: 8),
    height: 0.25,
  );

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (bloc.painAssessmentData.qualityId == null) {
      setState(() {
        _qualityRadioValueError = "Please select an option!";
      });
      isValid = false;
    }
    if (bloc.painAssessmentData.painMngmtReferralId == null) {
      setState(() {
        _painManagementReferralError = "Please select an option!";
      });
      isValid = false;
    }
    if (bloc.painAssessmentData.painType == null) {
      setState(() {
        _typeError = "Please select an option!";
      });
      isValid = false;
    }
    if (bloc.painAssessmentData.painScale == null) {
      setState(() {
        _painScaleError = "Pain Scale is required";
      });
      isValid = false;
    }
    if (bloc.painAssessmentData.goalforPainRelief == null) {
      setState(() {
        _clientgoalError = "Client's goal for pain relief required";
      });
      isValid = false;
    }
    if (bloc.painAssessmentData.locationId == null) {
      setState(() {
        _locationError = "Location required";
      });
      isValid = false;
    }

    if (bloc.painAssessmentData.durationId == null) {
      setState(() {
        _durationError = "Duration required";
      });
      isValid = false;
    }

    if (!isValid) {
      return;
    }
    bloc.savePainAssessment();
  }

  void _setValues() {
    aggtavatingController.text = bloc.painAssessmentData.aggravatingfactor;
    alleviatingController.text = bloc.painAssessmentData.allevatingfactor;
    goalController.text = bloc.painAssessmentData.goal;
    impactofFunController.text = bloc.painAssessmentData.impactOnFnAbility;
    currentPlanController.text = bloc.painAssessmentData.currentregimen;
    if (bloc.painAssessmentData.isControlled) {
      _stageRadioValue = 0;
    } else {
      _stageRadioValue = 1;
    }

    if (bloc.painAssessmentData.isPain) {
      _painRadioValue = 0;
    } else {
      _painRadioValue = 1;
    }

    updated = true;
  }

  void _presentDatePicker() {
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
          bloc.painAssessmentData.onsetDate = date;
        });
      },
      currentTime: bloc.painAssessmentData.onsetDate == null
          ? DateTime.now()
          : bloc.painAssessmentData.onsetDate,
      locale: LocaleType.en,
    );
  }

  @override
  Widget build(BuildContext context) {
    double optionSize = 148;

    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    final _general = Provider.of<GeneralCCQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(2),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(2, 2),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: StreamBuilder<PainAssessment>(
                      stream: bloc.painAssessment,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !updated) {
                          _setValues();
                        }

                        return Form(
                          key: _form,
                          child: ListView(
                            padding: EdgeInsets.only(
                              right: 16,
                              left: 16,
                              top: 16,
                              bottom:
                                  16 + MediaQuery.of(context).viewInsets.bottom,
                            ),
                            children: <Widget>[
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Pain:', false),
                                    Row(
                                      children: _general.yesNo
                                          .map((answer) => RadioButtonCommon(
                                              _painRadioValueHandler,
                                              _painRadioValue,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              _separator,
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Stage:', true),
                                    Row(
                                      children: _general
                                          .controlledNotControlledRadioValues
                                          .map((answer) => RadioButtonCommon(
                                              _stageRadioValueHandler,
                                              _stageRadioValue,
                                              answer.text,
                                              answer.index))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              _separator,
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Type:', true),
                                    StreamBuilder<List<GenricDropDown>>(
                                        stream: bloc.painType,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text("No data");
                                          }
                                          return Row(
                                            children: snapshot.data
                                                .map((answer) =>
                                                    RadioButtonCommon(
                                                        _typeRadioValueHandler,
                                                        bloc.painAssessmentData
                                                            .painType,
                                                        answer.name,
                                                        answer.id))
                                                .toList(),
                                          );
                                        }),
                                    _typeError == null
                                        ? SizedBox.shrink()
                                        : Text(
                                            _typeError ?? "",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                  ],
                                ),
                              ),
                              _separator,
                              CommonText('Duration', true),
                              _durationDropDown(),
                              _durationError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _durationError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              SizedBox(height: 8),
                              CommonText('Location', true),
                              _locationDropDown(),
                              _locationError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _locationError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  CommonText('Pain Scale:', true),
                                  if (bloc.painAssessmentData.painScale != null)
                                    CommonText(
                                        ' ${bloc.painAssessmentData.painScale.toInt()}',
                                        false),
                                ],
                              ),
                              Slider(
                                value:
                                    (bloc.painAssessmentData.painScale == null
                                            ? 0
                                            : bloc.painAssessmentData.painScale)
                                        .toDouble(),
                                onChanged: (val) {
                                  setState(() {
                                    bloc.painAssessmentData.painScale =
                                        val.toInt();
                                    _painScaleError = null;
                                  });
                                },
                                max: 10,
                                min: 0,
                                divisions: 10,
                                label: bloc.painAssessmentData.painScale != null
                                    ? '${bloc.painAssessmentData.painScale.toInt()}'
                                    : '',
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.insert_emoticon,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text('No Pain', style: _optionTextStyle),
                                ],
                              ),
                              _painScaleError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _painScaleError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              SizedBox(height: 8),
                              _separator,
                              CommonText('Onset', true),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 90,
                                    child: Text(bloc
                                                .painAssessmentData.onsetDate ==
                                            null
                                        ? ''
                                        : '${DateFormat.yMd().format(bloc.painAssessmentData.onsetDate)}'),
                                  ),
                                  FlatButton(
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      _presentDatePicker();
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 16),
                              CommonText('Quality', true),
                              StreamBuilder<List<GenricDropDown>>(
                                  stream: bloc.painQualityObservable,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text('No Data');
                                    }
                                    return Wrap(
                                      children: snapshot.data
                                          .map((answer) => RadioButtonCommon(
                                              _qualityRadioValueHandler,
                                              bloc.painAssessmentData.qualityId,
                                              answer.name,
                                              answer.id))
                                          .toList(),
                                    );
                                  }),
                              _qualityRadioValueError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _qualityRadioValueError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              _separator,
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Aggravating Factor(s)',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: aggtavatingController,
                                onChanged: (val) => bloc
                                    .painAssessmentData.aggravatingfactor = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Alleviating Factor(s)',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: alleviatingController,
                                onChanged: (val) => bloc
                                    .painAssessmentData.allevatingfactor = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Goal',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: goalController,
                                onChanged: (val) =>
                                    bloc.painAssessmentData.goal = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: 'Impact on functional ability',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: impactofFunController,
                                onChanged: (val) => bloc
                                    .painAssessmentData.impactOnFnAbility = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText:
                                      'Current Pain Management Regiemen:(Specify)',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: currentPlanController,
                                onChanged: (val) => bloc
                                    .painAssessmentData.currentregimen = val,
                                maxLines: 2,
                                minLines: 2,
                              ),
                              SizedBox(height: 16),
                              CommonText(
                                  'Client\'s goal for pain relief:', true),
                              Slider(
                                value: (bloc.painAssessmentData
                                                .goalforPainRelief ==
                                            null
                                        ? 0
                                        : bloc.painAssessmentData
                                            .goalforPainRelief)
                                    .toDouble(),
                                onChanged: (val) {
                                  setState(() {
                                    bloc.painAssessmentData.goalforPainRelief =
                                        val.toInt();
                                    _clientgoalError = null;
                                  });
                                },
                                max: 10,
                                min: 0,
                                divisions: 10,
                                label: bloc.painAssessmentData
                                            .goalforPainRelief !=
                                        null
                                    ? '${bloc.painAssessmentData.goalforPainRelief.toInt()}'
                                    : '',
                              ),
                              _clientgoalError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _clientgoalError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              SizedBox(height: 16),
                              CommonText('Pain Management Referral', true),
                              StreamBuilder<List<GenricDropDown>>(
                                  stream: bloc.painManagementReferral,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text('No Data');
                                    }
                                    return Row(
                                      children: snapshot.data
                                          .map((answer) => RadioButtonCommon(
                                              _painManagementReferralRadioValueHandler,
                                              bloc.painAssessmentData
                                                  .painMngmtReferralId,
                                              answer.name,
                                              answer.id))
                                          .toList(),
                                    );
                                  }),
                              _painManagementReferralError == null
                                  ? SizedBox.shrink()
                                  : Text(
                                      _painManagementReferralError ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: _saveForm,
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
                                      onPressed: () => print('Pressed Save'),
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

  Widget _durationDropDown() {
    return StreamBuilder<List<GenricDropDown>>(
        stream: bloc.painDuration,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }
          return DropdownButton<int>(
            hint: Text('Duration'),
            isExpanded: true,
            iconSize: 24,
            style: _textStyle,
            underline: Container(
              color: Colors.black54,
              height: 1,
            ),
            items: snapshot.data
                ?.map<DropdownMenuItem<int>>((GenricDropDown answer) {
              return DropdownMenuItem<int>(
                value: answer.id,
                child: Text(answer.name, style: _optionTextStyle),
              );
            })?.toList(),
            value: bloc.painAssessmentData.durationId,
            onChanged: (int newValue) {
              setState(() {
                bloc.painAssessmentData.durationId = newValue;
                _durationError = null;
              });
            },
          );
        });
  }

  Widget _locationDropDown() {
    return StreamBuilder<List<GenricDropDown>>(
        stream: bloc.painLocation,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          }
          return DropdownButton<int>(
            hint: Text('Location'),
            isExpanded: true,
            iconSize: 24,
            style: _textStyle,
            underline: Container(
              color: Colors.black54,
              height: 1,
            ),
            items: snapshot.data
                ?.map<DropdownMenuItem<int>>((GenricDropDown answer) {
              return DropdownMenuItem<int>(
                value: answer.id,
                child: Text(answer.name, style: _optionTextStyle),
              );
            })?.toList(),
            value: bloc.painAssessmentData.locationId,
            onChanged: (int newValue) {
              setState(() {
                bloc.painAssessmentData.locationId = newValue;
                _locationError = null;
              });
            },
          );
        });
  }
}
