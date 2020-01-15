import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
//import 'package:practiceinsights_emr_provider/modules/information/features/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';

class GuarantorInformationWidget extends StatefulWidget {
  static const routeName = '/guarantorInformation';
  @override
  _GuarantorInformationWidgetState createState() =>
      _GuarantorInformationWidgetState();
}

class _GuarantorInformationWidgetState
    extends State<GuarantorInformationWidget> {
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

  int _relOfGuarantorSelectValue = 0;
  int _sexSelectValue = 0;
  int _stateSelectValue = 0;
  int _prefferedContactSelectValue = 0;

  _relOfGuarantorSelectValueHandler(val) {
    setState(() {
      _relOfGuarantorSelectValue = val;
    });
  }

  _sexSelectValueHandler(val) {
    setState(() {
      _sexSelectValue = val;
    });
  }

  _stateSelectValueHandler(val) {
    setState(() {
      _stateSelectValue = val;
    });
  }

  _prefferedContactSelectValueHandler(val) {
    setState(() {
      _prefferedContactSelectValue = val;
    });
  }

  TextEditingController _firstnameController,
      _lastnameController,
      _dobController,
      _address1Controller,
      _address2Controller,
      _cityController,
      _zipController,
      _homephoneController,
      _cellphoneController,
      _workphoneController;

  @override
  void initState() {
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _dobController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
    _cityController = TextEditingController();
    _zipController = TextEditingController();
    _homephoneController = TextEditingController();
    _cellphoneController = TextEditingController();
    _workphoneController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    final _informations = Provider.of<InformationQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(2, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(2, 2, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      CommonText('Guarantor Information', false),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Rel of Guarantor',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: DropdownButton<int>(
                              isDense: true,
                              isExpanded: true,
                              iconSize: 24,
                              // style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              value: _relOfGuarantorSelectValue,
                              onChanged: _relOfGuarantorSelectValueHandler,
                              items: _informations.relOfGuarantorSelectValues
                                  .map<DropdownMenuItem<int>>((answer) {
                                return DropdownMenuItem<int>(
                                  value: answer.index,
                                  child: Text(answer.text),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  labelText: 'First Name *',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _lastnameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name *',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _dobController,
                              decoration: InputDecoration(
                                labelText: 'DOB',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 0),
                                suffix: GestureDetector(
                                  onTap: () async {
                                    final DateTime picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1990, 8),
                                      lastDate: DateTime(2101),
                                    );
                                    if (picked != null)
                                      setState(() {
                                        _dobController.text =
                                            '${picked.day}/${picked.month}/${picked.year}';
                                        print(_dobController.text);
                                      });
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
                          )
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Sex',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: DropdownButton<int>(
                              isDense: true,
                              isExpanded: true,
                              iconSize: 24,
                              // style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              value: _sexSelectValue,
                              onChanged: _sexSelectValueHandler,
                              items: _informations.genderSelectValues
                                  .map<DropdownMenuItem<int>>((answer) {
                                return DropdownMenuItem<int>(
                                  value: answer.index,
                                  child: Text(answer.text),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _address1Controller,
                                decoration: InputDecoration(
                                  labelText: 'Address 1',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _address2Controller,
                              decoration: InputDecoration(
                                labelText: 'Address 2',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _cityController,
                              decoration: InputDecoration(
                                labelText: 'City',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'State',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: DropdownButton<int>(
                              isDense: true,
                              isExpanded: true,
                              iconSize: 24,
                              // style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              value: _stateSelectValue,
                              onChanged: _stateSelectValueHandler,
                              items: _informations.stateSelectValues
                                  .map<DropdownMenuItem<int>>((answer) {
                                return DropdownMenuItem<int>(
                                  value: answer.index,
                                  child: Text(answer.text),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _zipController,
                                decoration: InputDecoration(
                                  labelText: 'Zip *',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Preffered Contact',
                        style: _optionTextStyle,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: DropdownButton<int>(
                              isDense: true,
                              isExpanded: true,
                              iconSize: 24,
                              // style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              value: _prefferedContactSelectValue,
                              onChanged: _prefferedContactSelectValueHandler,
                              items: _informations.preferredPhonesSelectValues
                                  .map<DropdownMenuItem<int>>((answer) {
                                return DropdownMenuItem<int>(
                                  value: answer.index,
                                  child: Text(answer.text),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _homephoneController,
                                decoration: InputDecoration(
                                  labelText: 'Home Phone',
                                  contentPadding:
                                      EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _cellphoneController,
                              decoration: InputDecoration(
                                labelText: 'Cell Phone',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              style: _optionTextStyle,
                              controller: _workphoneController,
                              decoration: InputDecoration(
                                labelText: 'Work Phone',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
