import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/radio_button.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/blocs/other_information_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';

class LegalWidget extends StatefulWidget {
  static const routeName = '/legal';

  @override
  _LegalWidgetState createState() => _LegalWidgetState();
}

class _LegalWidgetState extends State<LegalWidget> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  String _gStateSelectValue;
  String _pStateSelectValue;

  _stateSelectValueHandler(val) {
    setState(() {
      _gStateSelectValue = val;
    });
  }

  TextEditingController _pAddress2Controller,
      _pCityController,
      _pZipController,
      _pNameController,
      _pAddress1Controller;

  TextEditingController _gAddress2Controller,
      _gCityController,
      _gZipController,
      _gNameController,
      _gAddress1Controller;

  TextEditingController _medicalReleaseNameController;

  final bloc = sl<OtherInformationBloc>();

  @override
  void initState() {
    _pAddress2Controller = TextEditingController();
    _pCityController = TextEditingController();
    _pZipController = TextEditingController();
    _pAddress1Controller = TextEditingController();
    _pNameController = TextEditingController();

    _gAddress2Controller = TextEditingController();
    _gCityController = TextEditingController();
    _gZipController = TextEditingController();
    _gAddress1Controller = TextEditingController();
    _gNameController = TextEditingController();

    _medicalReleaseNameController = TextEditingController();

    init();

    super.initState();
  }

  Widget _gStateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'State',
          style: _optionTextStyle,
        ),
        SizedBox(height: 4),
        StreamBuilder<List<String>>(
            stream: bloc.states,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_gStateLoaded) {
                _gStateSelectValues = snapshot.data.map((d) {
                  return d;
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _gStateLoaded = true;
                  });
                });
              }
              return DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black45,
                  height: 1,
                ),
                value: _gStateSelectValue,
                onChanged: _stateSelectValueHandler,
                items:
                    _gStateSelectValues.map<DropdownMenuItem<String>>((answer) {
                  return DropdownMenuItem<String>(
                    value: answer,
                    child: Text(answer),
                  );
                }).toList(),
              );
            }),
      ],
    );
  }

  Widget _pStateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'State',
          style: _optionTextStyle,
        ),
        SizedBox(height: 4),
        StreamBuilder<List<String>>(
            stream: bloc.states,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_pStateLoaded) {
                _pStateSelectValues = snapshot.data.map((d) {
                  return d;
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _pStateLoaded = true;
                  });
                });
              }
              return DropdownButton<String>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black45,
                  height: 1,
                ),
                value: _pStateSelectValue,
                onChanged: _stateSelectValueHandler,
                items:
                    _pStateSelectValues.map<DropdownMenuItem<String>>((answer) {
                  return DropdownMenuItem<String>(
                    value: answer,
                    child: Text(answer),
                  );
                }).toList(),
              );
            }),
      ],
    );
  }

  void init() async {
    Future.wait(<Future>[
      bloc.getStates(),
    ]);
    bloc.initialize();
  }

  bool _updated = false, _pStateLoaded = false, _gStateLoaded = false;
  OtherInformationModel _otherInfo;

  void _updateOtherInformation(List<OtherInformationModel> otherInfo) {
    setState(() {
      _otherInfo = otherInfo[0];

      _resuscitationRadioValue = _otherInfo.resesitate;
      _livingRadioValue = _otherInfo.livingWill;

      _pNameController.text = _otherInfo.poaname;
      _pAddress1Controller.text = _otherInfo.poaaddress1;
      _pAddress2Controller.text = _otherInfo.poaaddress2;
      _pCityController.text = _otherInfo.poacity;
      _pStateSelectValue = _otherInfo.poastate;
      _pZipController.text = _otherInfo.poazip;

      _gNameController.text = _otherInfo.gname;
      _gAddress1Controller.text = _otherInfo.gaddress1;
      _gAddress2Controller.text = _otherInfo.gaddress2;
      _gCityController.text = _otherInfo.gcity;
      _gStateSelectValue = _otherInfo.gstate;
      _gZipController.text = _otherInfo.gzip;

      _medicalReleaseNameController.text = _otherInfo.medicalRelNames;

      _updated = true;
    });
  }

  List<String> _pStateSelectValues = [];
  List<String> _gStateSelectValues = [];

  List<GroupModel> _resuscitationRadioValues = [
    GroupModel('Resuscitation', 1),
    GroupModel('Do not Resuscitation', 0),
    GroupModel('Unknown', -1),
  ];

  int _resuscitationRadioValue;
  _resuscitationRadioValueHandler(val) {
    setState(() {
      _resuscitationRadioValue = val;
    });
  }

  List<GroupModel> _livingRadioValues = [
    GroupModel('Yes', 1),
    GroupModel('No', 0),
    GroupModel('Unknown', -1),
  ];

  int _livingRadioValue;
  _directiveRadioValueHandler(val) {
    setState(() {
      _livingRadioValue = val;
    });
  }

  _onSavePressed() {
    setState(() {
      _otherInfo.resesitate = _resuscitationRadioValue;
      _otherInfo.livingWill = _livingRadioValue;

      _otherInfo.poaname = _pNameController.text;
      _otherInfo.poaaddress1 = _pAddress1Controller.text;
      _otherInfo.poaaddress2 = _pAddress2Controller.text;
      _otherInfo.poacity = _pCityController.text;
      _otherInfo.poastate = _pStateSelectValue;
      _otherInfo.poazip = _pZipController.text;

      _otherInfo.gname = _gNameController.text;
      _otherInfo.gaddress1 = _gAddress1Controller.text;
      _otherInfo.gaddress2 = _gAddress2Controller.text;
      _otherInfo.gcity = _gCityController.text;
      _otherInfo.gstate = _gStateSelectValue;
      _otherInfo.gzip = _gZipController.text;

      _otherInfo.medicalRelNames = _medicalReleaseNameController.text;

      bloc.onSavePressed(_otherInfo);
    });
  }

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
          MainMenu(3, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(1, 3, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<List<OtherInformationModel>>(
                    stream: bloc.otherInformationObservable,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateOtherInformation(snapshot.data);
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
                            CommonText("Legal", false),
                            SizedBox(height: 12),
                            SizedBox(height: 12),
                            CommonText("Resuscitation", false),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _resuscitationRadioValues
                                  .map(
                                    (val) => RadioButtonCommon(
                                      _resuscitationRadioValueHandler,
                                      _resuscitationRadioValue,
                                      val.text,
                                      val.index,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: 12),
                            CommonText(
                                "Living Will or Advanced Directive", false),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _livingRadioValues
                                  .map(
                                    (val) => RadioButtonCommon(
                                      _directiveRadioValueHandler,
                                      _livingRadioValue,
                                      val.text,
                                      val.index,
                                    ),
                                  )
                                  .toList(),
                            ),
                            CommonText("Power of Attorney", false),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _pNameController,
                              decoration: InputDecoration(
                                labelText: ' Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _pAddress1Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 1',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _pAddress2Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 2',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _pCityController,
                              decoration: InputDecoration(
                                labelText: 'City',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _pStateWidget(),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _pZipController,
                              decoration: InputDecoration(
                                labelText: 'Zip *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            CommonText("Guardianship", false),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _gNameController,
                              decoration: InputDecoration(
                                labelText: ' Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _gAddress1Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 1',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _gAddress2Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 2',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _gCityController,
                              decoration: InputDecoration(
                                labelText: 'City',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _gStateWidget(),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _gZipController,
                              decoration: InputDecoration(
                                labelText: 'Zip *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            CommonText("Medical Release Names", false),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _medicalReleaseNameController,
                              maxLines: 5,
                              minLines: 5,
                              decoration: InputDecoration(
                                labelText: ' Medical Release Names',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
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
