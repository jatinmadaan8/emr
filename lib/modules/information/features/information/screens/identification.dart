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

class IdentificationWidget extends StatefulWidget {
  static const routeName = '/identification';

  @override
  _IdentificationWidgetState createState() => _IdentificationWidgetState();
}

class _IdentificationWidgetState extends State<IdentificationWidget> {
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

  int _defaultProviderSelectValue = 0;
  int _genderSelectValue = 1;

  _defaultProviderSelectValueHandler(val) {
    setState(() {
      _defaultProviderSelectValue = val;
    });
  }

  _genderSelectValueHandler(val) {
    setState(() {
      _genderSelectValue = val;
    });
  }

  final bloc = sl<PatientInformationBloc>();

  TextEditingController _lastNameController,
      _firstNameController,
      _nickNameController,
      _maidenNameController,
      _middleNameController,
      _billingIdController;

  @override
  void initState() {
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _nickNameController = TextEditingController();
    _maidenNameController = TextEditingController();
    _middleNameController = TextEditingController();
    _billingIdController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  bool _updated = false, _genderLoaded = false, _defaultProviderLoaded = false;

  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      print("Hello In Update Identification");
      _patientInfo = patientInfo;

      _patientId = patientInfo.id.toString();
      _billingIdController.text = patientInfo.billingID ?? "";

      _defaultProviderSelectValue = patientInfo.providerId;

      _firstNameController.text = patientInfo.firstName ?? "";
      _lastNameController.text = patientInfo.lastName ?? "";
      _nickNameController.text = patientInfo.nicknameAc ?? "";
      _maidenNameController.text = patientInfo.maidenName ?? "";
      _middleNameController.text = patientInfo.mi ?? "";

      _genderSelectValue = patientInfo.genderId;

      _updated = true;
    });
  }

  String _patientId = '';

  List<GroupModel> _genderSelectValues = [
    GroupModel("Male", 0),
    GroupModel("Female", 1),
    GroupModel("Unknown", 2),
  ];
  List<GroupModel> _defaultProviderSelectValues = [
    GroupModel(" ", 0),
  ];

  Widget _genderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: _optionTextStyle,
        ),
        SizedBox(height: 4),
        StreamBuilder<List<PatientInformationLookUpData>>(
            stream: bloc.gender,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_genderLoaded) {
                _genderSelectValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _genderLoaded = true;
                  });
                });
              }

              return DropdownButton<int>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black54,
                  height: 1,
                ),
                value: _genderSelectValue,
                onChanged: _genderSelectValueHandler,
                items: _genderSelectValues.map<DropdownMenuItem<int>>((answer) {
                  return DropdownMenuItem<int>(
                    value: answer.index,
                    child: Text(answer.text),
                  );
                }).toList(),
              );
            }),
      ],
    );
  }

  Widget _defaultProviderWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Default Provier',
          style: _optionTextStyle,
        ),
        SizedBox(height: 4),
        StreamBuilder<List<DefaultProviderModel>>(
            stream: bloc.defaultProvider,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_defaultProviderLoaded) {
                _defaultProviderSelectValues = snapshot.data.map((d) {
                  return GroupModel(d.userFullName, d.userId);
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _defaultProviderSelectValue =
                        _defaultProviderSelectValues[0].index;
                    _defaultProviderLoaded = true;
                  });
                });
              }
              if (!snapshot.hasData || !_defaultProviderLoaded) {
                return Container();
              }
              return DropdownButton<int>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black54,
                  height: 1,
                ),
                value: _defaultProviderSelectValue,
                onChanged: _defaultProviderSelectValueHandler,
                items: _defaultProviderSelectValues
                    .map<DropdownMenuItem<int>>((answer) {
                  return DropdownMenuItem<int>(
                    value: answer.index,
                    child: Text(answer.text),
                  );
                }).toList(),
              );
            }),
      ],
    );
  }

  void _onSavePressed() {
    setState(() {
      _patientInfo.billingID = _billingIdController.text;

      _patientInfo.providerId = _defaultProviderSelectValue;

      _patientInfo.lastName = _lastNameController.text;
      _patientInfo.firstName = _firstNameController.text;
      _patientInfo.nicknameAc = _nickNameController.text;
      _patientInfo.maidenName = _maidenNameController.text;
      _patientInfo.mi = _middleNameController.text;

      _patientInfo.genderId = _genderSelectValue;

      bloc.onSavePressed(_patientInfo);
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
          MainMenu(1, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(1, 1, demographics: true),
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
                            CommonText("Identification", false),
                            SizedBox(height: 12),
                            Text(
                              'Patient ID',
                              style: _optionTextStyle,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                _patientId,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted,
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _billingIdController,
                              decoration: InputDecoration(
                                labelText: 'Billing ID *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _defaultProviderWidget(),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: 'First Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _nickNameController,
                              decoration: InputDecoration(
                                labelText: 'Nick Name',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _maidenNameController,
                              decoration: InputDecoration(
                                labelText: 'Maiden Name',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _middleNameController,
                              decoration: InputDecoration(
                                labelText: 'Middle',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _genderWidget(),
                            SizedBox(height: 12),
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
