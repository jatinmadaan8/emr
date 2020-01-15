import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/blocs/other_information_bloc.dart';
import 'package:provider/provider.dart';

import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';

class EmergencyContactInformationWidget extends StatefulWidget {
  static const routeName = '/emergencyContactInformation';
  @override
  _EmergencyContactInformationWidgetState createState() =>
      _EmergencyContactInformationWidgetState();
}

class _EmergencyContactInformationWidgetState
    extends State<EmergencyContactInformationWidget> {
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

  String _relationshipSelectValue;

  _relationshipSelectValueHandler(val) {
    setState(() {
      _relationshipSelectValue = val;
    });
  }

  TextEditingController _firstnameController,
      _lastnameController,
      _middleinitialController,
      _phonenumberController;

  final bloc = sl<OtherInformationBloc>();

  @override
  void initState() {
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _middleinitialController = TextEditingController();
    _phonenumberController = TextEditingController();

    init();

    super.initState();
  }

  init() async {
    Future.wait(<Future>[
      bloc.getRelationship(),
    ]);

    bloc.initialize();
  }

  OtherInformationModel _otherInfo;

  void _updateOtherInformation(List<OtherInformationModel> otherInfo) {
    setState(() {
      _otherInfo = otherInfo[0];

      _firstnameController.text = _otherInfo.ecfirstName ?? "";
      _lastnameController.text = _otherInfo.eclastName ?? "";
      _middleinitialController.text = _otherInfo.ecmiddleInitial ?? "";
      _phonenumberController.text = _otherInfo.ecphoneNumber ?? "";

      _relationshipSelectValue = _otherInfo.ecrelationship;

      _updated = true;
    });
  }

  _onSavePressed() {
    setState(() {
      _otherInfo.ecfirstName = _firstnameController.text;
      _otherInfo.eclastName = _lastnameController.text;
      _otherInfo.ecmiddleInitial = _middleinitialController.text;
      _otherInfo.ecphoneNumber = _phonenumberController.text;
      _otherInfo.ecrelationship = _relationshipSelectValue;

      bloc.onSavePressed(_otherInfo);
    });
  }

  bool _relationShipLoaded = false, _updated = false;

  List<String> _relationshipSelectValues = [];

  Widget _relationShipWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Relationship',
          style: _optionTextStyle,
        ),
        StreamBuilder(
          stream: bloc.relationship,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData && !_relationShipLoaded) {
              _relationshipSelectValues = snapshot.data;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _relationShipLoaded = true;
                });
              });
            }
            return DropdownButton<String>(
              isDense: true,
              isExpanded: true,
              iconSize: 24,
              underline: Container(
                color: Colors.black54,
                height: 1,
              ),
              value: _relationshipSelectValue,
              onChanged: _relationshipSelectValueHandler,
              items: _relationshipSelectValues
                  .map<DropdownMenuItem<String>>((answer) {
                return DropdownMenuItem<String>(
                  value: answer,
                  child: Text(answer),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
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
                child: SubMenu(3, 3, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<List<OtherInformationModel>>(
                    stream: bloc.otherInformationObservable,
                    builder: (context, snapshot) {
                      print(snapshot);

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
                            CommonText('Emergency Contact Information', false),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _firstnameController,
                              decoration: InputDecoration(
                                labelText: 'First Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _lastnameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _middleinitialController,
                              onChanged: (t) => setState(
                                  () => _middleinitialController.text = t[0]),
                              decoration: InputDecoration(
                                labelText: 'Middle Initial',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _phonenumberController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            _relationShipWidget(),
                            SizedBox(
                              height: 12,
                            ),
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
                                    onPressed: () => print('Pressed Cancel'),
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
