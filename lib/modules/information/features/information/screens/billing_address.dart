import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/information_questions.dart';

class BillingAddressWidget extends StatefulWidget {
  static const routeName = '/billingAddress';

  @override
  _BillingAddressWidgetState createState() => _BillingAddressWidgetState();
}

class _BillingAddressWidgetState extends State<BillingAddressWidget> {
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

  String _stateSelectValue;

  _stateSelectValueHandler(val) {
    setState(() {
      _stateSelectValue = val;
    });
  }

  bool _sameAsResidential = false;

  TextEditingController _address2Controller,
      _cityController,
      _zipController,
      _address1Controller;

  final bloc = sl<PatientInformationBloc>();

  @override
  void initState() {
    _address2Controller = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    _address1Controller = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  bool _updated = false, _stateLoaded = false;
  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      _address1Controller.text = patientInfo.billAddress1 ?? "";
      _address2Controller.text = patientInfo.billAddress2 ?? "";
      _cityController.text = patientInfo.billCity ?? "";
      _stateSelectValue = patientInfo.billState ?? "";
      _zipController.text = patientInfo.billZip ?? "";

      _updated = true;
    });
  }

  List<String> _stateSelectValues = [];

  Widget _stateWidget() {
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
              if (snapshot.hasData && !_stateLoaded) {
                _stateSelectValues = snapshot.data.map((d) {
                  return d;
                }).toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _stateLoaded = true;
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
                value: _stateSelectValue,
                onChanged: _stateSelectValueHandler,
                items:
                    _stateSelectValues.map<DropdownMenuItem<String>>((answer) {
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

  _sameAsResidentalHandler(val) {
    setState(() {
      _sameAsResidential = val;

      if (val) {
        _address1Controller.text = _patientInfo.address1;
        _address2Controller.text = _patientInfo.address2;
        _cityController.text = _patientInfo.city;
        _stateSelectValue = _patientInfo.state;
        _zipController.text = _patientInfo.zipCode;
      }
    });
  }

  _onSavePressed() {
    setState(() {
      _patientInfo.billAddress1 = _address1Controller.text;
      _patientInfo.billAddress2 = _address2Controller.text;
      _patientInfo.billCity = _cityController.text;
      _patientInfo.billState = _stateSelectValue;
      _patientInfo.billZip = _zipController.text;
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
                child: SubMenu(5, 1, demographics: true),
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
                            CommonText("Billing Address", false),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _address1Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 1',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),

                            TextFormField(
                              style: _optionTextStyle,
                              controller: _address2Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 2',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),

                            TextFormField(
                              style: _optionTextStyle,
                              controller: _cityController,
                              decoration: InputDecoration(
                                labelText: 'City',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: _stateWidget(),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    controller: _zipController,
                                    decoration: InputDecoration(
                                      labelText: 'Zip',
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),

                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _sameAsResidential,
                                  onChanged: _sameAsResidentalHandler,
                                ),
                                Text('Same as Residental'),
                              ],
                            ),
                            SizedBox(height: 8),
                            // -------

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      _onSavePressed();
                                      bloc.onSavePressed(_patientInfo);
                                    },
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
