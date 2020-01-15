import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/information_questions.dart';

class InformationWidget extends StatefulWidget {
  static const routeName = '/information';

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 16,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  String _ethnicitySelectValue;
  String _religionSelectValue;
  String _prefLanguageSelectValue;

  _ethnicitySelectValueHandler(val) {
    setState(() {
      _ethnicitySelectValue = val;
    });
  }

  _religionSelectValueHandler(val) {
    setState(() {
      _religionSelectValue = val;
    });
  }

  _prefLanguageSelectValueHandler(val) {
    setState(() {
      _prefLanguageSelectValue = val;
    });
  }

  TextEditingController _socialSecurityController,
      _pgxReportIdController,
      _spouseNameController,
      _emailController,
      _ageController,
      _dobController;

  final bloc = sl<PatientInformationBloc>();

  @override
  void initState() {
    _socialSecurityController = TextEditingController();
    _pgxReportIdController = TextEditingController();
    _spouseNameController = TextEditingController();
    _emailController = TextEditingController();
    _ageController = TextEditingController();
    _dobController = TextEditingController();

    init();

    super.initState();
  }

  Future init() async {
    Future.wait(<Future>[
      bloc.getLanguage(),
      bloc.getEthnicity(),
      bloc.getReligion(),
      bloc.getRace(),
    ]);
    bloc.initialize();
  }

  bool _updated = false,
      _languageLoaded = false,
      _ethnicityLoaded = false,
      _religionLoaded = false,
      _raceLoaded = false;

  String _heightOne, _heightTwo, _heightThree;

  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      if (patientInfo.dob != null) {
        var arr = patientInfo.dob.split("-");

        int _year = int.tryParse(arr[0]);
        int _date = int.tryParse(arr[2].substring(0, 2));
        int _month = int.tryParse(arr[1]);

        if (_year != null && _date != null && _month != null) {
          _dobController.text = "$_month/$_date/$_year";
          _selectedDate = DateTime(_year, _month, _date);
        }
      }

      _ageController.text = patientInfo.age.toString();
      _socialSecurityController.text = patientInfo.ssn;
      _pgxReportIdController.text = patientInfo.pgxReportId;
      _spouseNameController.text = patientInfo.spouseName;
      _emailController.text = patientInfo.email;

      _prefLanguageSelectValue = patientInfo.language;
      _ethnicitySelectValue = patientInfo.ethnicity;
      _religionSelectValue = patientInfo.religion;

      _patientInfo.patientRaces.forEach((r) {
        _raceSelectValues.singleWhere((t) => t.index == r.raceId).value = true;
      });

      _heightOne = _patientInfo.height.split("'")[0];
      _heightTwo = _patientInfo.height.split("'")[1].trim().split(".")[0];
      _heightThree =
          _patientInfo.height.split("'")[1].trim().split(".")[1].split("\"")[0];

      _updated = true;
    });
  }

  List<String> _prefLanguageSelectValues = [];
  List<String> _ethnicitySelectValues = [];
  List<String> _religionSelectValues = [];

  List<GroupModelForCheckBoxInformationTab> _raceSelectValues = [];

  Widget _preferredLanguageWidget() {
    return StreamBuilder<List<String>>(
        stream: bloc.language,
        builder: (context, snapshot) {
          if (snapshot.hasData && !_languageLoaded) {
            _prefLanguageSelectValues = snapshot.data;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _languageLoaded = true;
              });
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (_prefLanguageSelectValue != null)
                  ? Text(
                      'Pref.Language',
                      style: _optionTextStyle,
                    )
                  : Container(),
              SizedBox(height: 4),
              DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                style: _textStyle,
                underline: Container(
                  color: Colors.black54,
                  height: 1,
                ),
                hint: Text(
                  "Pref.Language",
                  style:
                      _optionTextStyle.copyWith(fontSize: _textStyle.fontSize),
                ),
                value: _prefLanguageSelectValue,
                onChanged: _prefLanguageSelectValueHandler,
                items: _prefLanguageSelectValues
                    .map<DropdownMenuItem<String>>((answer) {
                  return DropdownMenuItem<String>(
                    value: answer,
                    child: Text(answer),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }

  Widget _ethnicityWidget() {
    return StreamBuilder<List<String>>(
        stream: bloc.ethnicity,
        builder: (context, snapshot) {
          if (snapshot.hasData && !_ethnicityLoaded) {
            _ethnicitySelectValues = snapshot.data;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _ethnicityLoaded = true;
              });
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (_ethnicitySelectValue != null)
                  ? Text(
                      'Ethnicity',
                      style: _optionTextStyle,
                    )
                  : Container(),
              SizedBox(height: 4),
              DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                style: _textStyle,
                hint: Text(
                  "Ethnicity",
                  style:
                      _optionTextStyle.copyWith(fontSize: _textStyle.fontSize),
                ),
                underline: Container(
                  color: Colors.black54,
                  height: 1,
                ),
                value: _ethnicitySelectValue,
                onChanged: _ethnicitySelectValueHandler,
                items: _ethnicitySelectValues
                    .map<DropdownMenuItem<String>>((answer) {
                  return DropdownMenuItem<String>(
                    value: answer,
                    child: Text(answer),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }

  Widget _religionWidget() {
    return StreamBuilder<List<String>>(
      stream: bloc.religion,
      builder: (context, snapshot) {
        if (snapshot.hasData && !_religionLoaded) {
          _religionSelectValues = snapshot.data;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _religionLoaded = true;
            });
          });
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            (_religionSelectValue != null)
                ? Text(
                    'Religion',
                    style: _optionTextStyle,
                  )
                : Container(),
            SizedBox(height: 4),
            DropdownButton<String>(
              isDense: true,
              isExpanded: true,
              iconSize: 24,
              style: _textStyle,
              hint: Text(
                'Religion',
                style: _optionTextStyle.copyWith(fontSize: _textStyle.fontSize),
              ),
              underline: Container(
                color: Colors.black54,
                height: 1,
              ),
              value: _religionSelectValue,
              onChanged: _religionSelectValueHandler,
              items:
                  _religionSelectValues.map<DropdownMenuItem<String>>((answer) {
                return DropdownMenuItem<String>(
                  value: answer,
                  child: Text(answer),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _raceWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Race',
          style: _optionTextStyle,
        ),
        StreamBuilder<List<RaceNavigation>>(
            stream: bloc.race,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_raceLoaded) {
                _raceSelectValues = snapshot.data
                    .map((d) => GroupModelForCheckBoxInformationTab(
                        d.raceId, d.description, false))
                    .toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _raceLoaded = true;
                  });
                });
              }

              if (!snapshot.hasData && !_raceLoaded) {
                return Container();
              }

              return Wrap(
                children: _raceSelectValues.map((answer) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Checkbox(
                        value: answer.value,
                        onChanged: (val) {
                          setState(() {
                            answer.value = val;
                          });
                        },
                      ),
                      Text(answer.title),
                    ],
                  );
                }).toList(),
              );
            }),
      ],
    );
  }

  _onSavePressed() {
    setState(() {
      _patientInfo.dob = _selectedDate.toUtc().toString();
      _patientInfo.age =
          (_selectedDate.difference(DateTime.now()).inDays ~/ 365).abs();

      _patientInfo.ssn = '';
      _patientInfo.pgxReportId = _pgxReportIdController.text;
      _patientInfo.spouseName = _spouseNameController.text;
      _patientInfo.email = _emailController.text;
      _patientInfo.language = _prefLanguageSelectValue;
      _patientInfo.ethnicity = _ethnicitySelectValue;
      _patientInfo.religion = _religionSelectValue;

      List<PatientRaces> _temp = [];
      _raceSelectValues.forEach((s) {
        if (s.value) _temp.add(PatientRaces(raceId: s.index));
      });
      _patientInfo.patientRaces = _temp;

      _patientInfo.height = "$_heightOne' $_heightTwo.$_heightThree\"";

      bloc.onSavePressed(_patientInfo);
    });
  }

  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          MainMenu(1, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(2, 1, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<PatientInformationModel>(
                    stream: bloc.patientInformationObservable,
                    builder: (context,
                        AsyncSnapshot<PatientInformationModel> snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updatePatientInformation(snapshot.data);
                        });
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(16),
                          children: <Widget>[
                            CommonText("Information", false),
                            SizedBox(height: 12),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: TextFormField(
                                    style: _textStyle,
                                    controller: _dobController,
                                    decoration: InputDecoration(
                                      labelText: 'Date of Birth *',
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 4),
                                      suffix: GestureDetector(
                                        onTap: () async {
                                          final DateTime picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                _selectedDate ?? DateTime.now(),
                                            firstDate: DateTime(1920, 8),
                                            lastDate: DateTime.now(),
                                          );

                                          if (picked != null) {
                                            setState(() {
                                              _selectedDate = picked;
                                              _dobController.text =
                                                  '${picked.day}/${picked.month}/${picked.year}';
                                              _ageController
                                                  .text = (_selectedDate
                                                          .difference(
                                                              DateTime.now())
                                                          .inDays ~/
                                                      365)
                                                  .abs()
                                                  .toString();
                                            });
                                          }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: Colors.black,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    style: _textStyle,
                                    controller: _ageController,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      labelText: 'Age *',
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 4),
                                      suffix: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "yrs",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _textStyle,
                              controller: _socialSecurityController,
                              decoration: InputDecoration(
                                labelText: 'Social Security',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _textStyle,
                              controller: _pgxReportIdController,
                              decoration: InputDecoration(
                                labelText: 'PGx ReportID',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _textStyle,
                              controller: _spouseNameController,
                              decoration: InputDecoration(
                                labelText: 'Spouse Name',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _textStyle,
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email Address *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _preferredLanguageWidget(),
                            SizedBox(height: 12),
                            _ethnicityWidget(),
                            SizedBox(height: 12),
                            _religionWidget(),
                            SizedBox(height: 12),
                            _raceWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Height FT/IN *',
                                    ),
                                    hint: Text(
                                      "Pref.Language",
                                      style: _optionTextStyle.copyWith(
                                          fontSize: _textStyle.fontSize),
                                    ),
                                    value: _heightOne,
                                    onChanged: (val) =>
                                        setState(() => _heightOne = val),
                                    items: [
                                      '0',
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9'
                                    ].map<DropdownMenuItem<String>>((answer) {
                                      return DropdownMenuItem<String>(
                                        value: answer,
                                        child: Text(answer.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Height FT/IN *',
                                    ),
                                    hint: Text(
                                      "Pref.Language",
                                      style: _optionTextStyle.copyWith(
                                          fontSize: _textStyle.fontSize),
                                    ),
                                    value: _heightTwo,
                                    onChanged: (val) =>
                                        setState(() => _heightTwo = val),
                                    items: [
                                      '0',
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6',
                                      '7',
                                      '8',
                                      '9',
                                      '10',
                                      '11',
                                      '12',
                                      '13',
                                      '14',
                                      '15',
                                      '16',
                                      '17',
                                      '18',
                                      '19',
                                      '20',
                                      '21',
                                      '22',
                                      '23',
                                      '24',
                                      '25',
                                      '26',
                                      '27',
                                      '28',
                                      '29',
                                      '30',
                                      '31',
                                      '32',
                                      '33',
                                      '34',
                                      '35',
                                      '36'
                                    ].map<DropdownMenuItem<String>>((answer) {
                                      return DropdownMenuItem<String>(
                                        value: answer,
                                        child: Text(answer.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Height FT/IN *',
                                    ),
                                    hint: Text(
                                      "Pref.Language",
                                      style: _optionTextStyle.copyWith(
                                          fontSize: _textStyle.fontSize),
                                    ),
                                    value: _heightThree,
                                    onChanged: (val) =>
                                        setState(() => _heightThree = val),
                                    items: [
                                      '0',
                                      '25',
                                      '5',
                                      '75',
                                    ].map<DropdownMenuItem<String>>((answer) {
                                      return DropdownMenuItem<String>(
                                        value: answer,
                                        child: Text((answer == "0")
                                            ? answer
                                            : ".$answer"),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
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
    );
  }
}
