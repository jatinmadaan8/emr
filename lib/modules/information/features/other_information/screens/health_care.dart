import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/blocs/other_information_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';

import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';

class HealthCareWidget extends StatefulWidget {
  static const routeName = '/healthcare';
  @override
  _HealthCareWidgetState createState() => _HealthCareWidgetState();
}

class _HealthCareWidgetState extends State<HealthCareWidget> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  bool _updated = false;
  OtherInformationModel _otherInfo;

  void _updateOtherInfo(OtherInformationModel otherInformation) {
    setState(() {
      _otherInfo = otherInformation;

      _homeHealthCheckBoxValue = otherInformation.homeHealth ?? false;
      if (_homeHealthCheckBoxValue) {
        _homeHealthController.text = _otherInfo.homeHealthLoc;
      }

      _nursingHomeCheckBoxValue = otherInformation.nursingHome ?? false;
      if (_nursingHomeCheckBoxValue) {
        _nursingHomeController.text = _otherInfo.nursingHomeLoc;
      }

      _hospiceCheckBoxValue = otherInformation.hospice ?? false;
      if (_hospiceCheckBoxValue) {
        _hospiceController.text = _otherInfo.hospiceLoc;
      }

      _impairmentsCheckBoxValue = otherInformation.impairment ?? false;
      if (_impairmentsCheckBoxValue) {
        _impairmentsController.text = _otherInfo.impairmentLoc;
      }

      _updated = true;
    });
  }

  _onSavePressed() {
    setState(() {
      _otherInfo.homeHealthLoc = _homeHealthController.text;
      _otherInfo.nursingHomeLoc = _nursingHomeController.text;
      _otherInfo.hospiceLoc = _hospiceController.text;
      _otherInfo.impairmentLoc = _impairmentsController.text;

      bloc.onSavePressed(_otherInfo);
    });
  }

  final bloc = sl<OtherInformationBloc>();

  @override
  void initState() {
    _homeHealthController = TextEditingController();
    _nursingHomeController = TextEditingController();
    _hospiceController = TextEditingController();
    _impairmentsController = TextEditingController();

    bloc.initialize();
    super.initState();
  }

  bool _homeHealthCheckBoxValue = false,
      _nursingHomeCheckBoxValue = false,
      _hospiceCheckBoxValue = false,
      _impairmentsCheckBoxValue = false;

  TextEditingController _homeHealthController,
      _nursingHomeController,
      _hospiceController,
      _impairmentsController;

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
                child: SubMenu(4, 3, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<List<OtherInformationModel>>(
                    stream: bloc.otherInformationObservable,
                    builder: (context,
                        AsyncSnapshot<List<OtherInformationModel>> snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateOtherInfo(snapshot.data[0]);
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
                            CommonText("Health Care", false),
                            SizedBox(height: 12),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: _homeHealthCheckBoxValue,
                                      onChanged: (val) => setState(() {
                                        _homeHealthCheckBoxValue = val;
                                        _otherInfo.homeHealth = val;
                                      }),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        enabled: _homeHealthCheckBoxValue,
//                                      style: _optionTextStyle,
                                        controller: _homeHealthController,
                                        decoration: InputDecoration(
                                          labelText: 'Home Health',
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: _nursingHomeCheckBoxValue,
                                      onChanged: (val) => setState(() {
                                        _nursingHomeCheckBoxValue = val;
                                        _otherInfo.nursingHome = val;
                                      }),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        enabled: _nursingHomeCheckBoxValue,
//                                      style: _optionTextStyle,
                                        controller: _nursingHomeController,
                                        decoration: InputDecoration(
                                          labelText: 'Nursing Home',
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: _hospiceCheckBoxValue,
                                      onChanged: (val) => setState(() {
                                        _hospiceCheckBoxValue = val;
                                        _otherInfo.hospice = val;
                                      }),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        enabled: _hospiceCheckBoxValue,
//                                      style: _optionTextStyle,
                                        controller: _hospiceController,
                                        decoration: InputDecoration(
                                          labelText: 'Hospice',
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: _impairmentsCheckBoxValue,
                                      onChanged: (val) => setState(() {
                                        _impairmentsCheckBoxValue = val;
                                        _otherInfo.impairment = val;
                                      }),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        enabled: _impairmentsCheckBoxValue,
//                                      style: _optionTextStyle,
                                        controller: _impairmentsController,
                                        decoration: InputDecoration(
                                          labelText: 'Impairments',
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 8),
                            // -------

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
              )
            ],
          )
        ],
      ),
    );
  }
}
