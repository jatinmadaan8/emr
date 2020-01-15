import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/blocs/insurance_bloc.dart';
//import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';
//import 'package:practiceinsights_emr_provider/modules/information/features/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';


import 'package:practiceinsights_emr_provider/modules/information/features/Insurance/providers/information_questions.dart';

class InsurancePoliciesWidget extends StatefulWidget {
  static const routeName = '/insurancepolicies';
  @override
  _InsurancePoliciesWidgetState createState() => _InsurancePoliciesWidgetState();
}

class _InsurancePoliciesWidgetState extends State<InsurancePoliciesWidget> {
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

  int _policySelectValue = 0;
  int _levelSelectValue = 0;
  int _planTypeSelectValue = 0;
  int _medicSecondarySelectValue = 0;

  _policySelectValueHandler(val) {
    setState(() {
      _policySelectValue = val;
    });
  }

  _levelSelectValueHandler(val) {
    setState(() {
      _levelSelectValue = val;
    });
  }

  _planTypeSelectValueHandler(val) {
    setState(() {
      _planTypeSelectValue = val;
    });
  }

  _medicSecondarySelectValueHandler(val) {
    setState(() {
      _medicSecondarySelectValue = val;
    });
  }

  TextEditingController 
      _groupnumberController,
      _groupnameController,
      _effectivedateController,
      _expirationdateController,
      _copayController,
      _policydeductableController;

  @override
  void initState() {
    _groupnumberController = TextEditingController();
    _groupnameController = TextEditingController();
    _effectivedateController = TextEditingController();
    _expirationdateController = TextEditingController();
    _copayController = TextEditingController();
    _policydeductableController = TextEditingController();
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
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(3, 5),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      CommonText('Insurance Policies', false),
                      SizedBox(height: 12,),
                      Text(
                        'Policy',
                        style: _optionTextStyle,
                      ),
                      DropdownButton<int>(
                          isDense: true,
                          isExpanded: true,
                          iconSize: 24,
                          // style: _textStyle,
                          underline: Container(
                            color: Colors.black54,
                            height: 1,
                          ),
                          value: _policySelectValue,
                          onChanged: _policySelectValueHandler,
                          items: _informations.policySelectValues
                              .map<DropdownMenuItem<int>>((answer) {
                            return DropdownMenuItem<int>(
                              value: answer.index,
                              child: Text(answer.text),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Level',
                                    style: _optionTextStyle,
                                  ),
                                  DropdownButton<int>(
                                    isDense: true,
                                    isExpanded: true,
                                    iconSize: 24,
                                    // style: _textStyle,
                                    underline: Container(
                                      color: Colors.black54,
                                      height: 1,
                                    ),
                                    value: _levelSelectValue,
                                    onChanged: _levelSelectValueHandler,
                                    items: _informations.levelSelectValues
                                        .map<DropdownMenuItem<int>>((answer) {
                                      return DropdownMenuItem<int>(
                                        value: answer.index,
                                        child: Text(answer.text),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Plan Type',
                                    style: _optionTextStyle,
                                  ),
                                  DropdownButton<int>(
                                    isDense: true,
                                    isExpanded: true,
                                    iconSize: 24,
                                    // style: _textStyle,
                                    underline: Container(
                                      color: Colors.black54,
                                      height: 1,
                                    ),
                                    value: _planTypeSelectValue,
                                    onChanged: _planTypeSelectValueHandler,
                                    items: _informations.planTypeSelectValues
                                        .map<DropdownMenuItem<int>>((answer) {
                                      return DropdownMenuItem<int>(
                                        value: answer.index,
                                        child: Text(answer.text),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                style: _optionTextStyle,
                                controller: _groupnumberController,
                                decoration: InputDecoration(
                                  labelText: 'Enter Group Number',
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _groupnameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Group Name',
                              contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                            ),
                              ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _effectivedateController,
                            decoration: InputDecoration(
                              labelText: 'Effective Date',
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
                                      _effectivedateController.text =
                                          '${picked.day}/${picked.month}/${picked.year}';
                                      print(_effectivedateController.text);
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
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _expirationdateController,
                            decoration: InputDecoration(
                              labelText: 'Expiration Date',
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
                                      _expirationdateController.text =
                                          '${picked.day}/${picked.month}/${picked.year}';
                                      print(_expirationdateController.text);
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
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _copayController,
                            decoration: InputDecoration(
                              labelText: 'Copay',
                              contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                            ),
                              ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                            style: _optionTextStyle,
                            controller: _policydeductableController,
                            decoration: InputDecoration(
                              labelText: 'Policy Deductable',
                              contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                            ),
                              ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Media Secondary',
                                    style: _optionTextStyle,
                                  ),
                                  DropdownButton<int>(
                                    isDense: true,
                                    isExpanded: true,
                                    iconSize: 24,
                                    // style: _textStyle,
                                    underline: Container(
                                      color: Colors.black54,
                                      height: 1,
                                    ),
                                    value: _medicSecondarySelectValue,
                                    onChanged: _medicSecondarySelectValueHandler,
                                    items: _informations.medicSecondarySelectValues
                                        .map<DropdownMenuItem<int>>((answer) {
                                      return DropdownMenuItem<int>(
                                        value: answer.index,
                                        child: Text(answer.text),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                         'Check the below fields.',
                         style: _optionTextStyle,
                       ),
                       SizedBox(height: 4),
                       Row(
                         children: <Widget>[
                           FilterChip(
                              label: Text("Policy Holder Signature On File"),
                              selectedColor: Colors.blue, 
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(side: BorderSide()),
                              onSelected: (bool value) {print("selected1");},
                          ),
                          FilterChip(
                              label: Text("Accept Assignment"),
                              selectedColor: Colors.blue, 
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(side: BorderSide()),
                              onSelected: (bool value) {print("selected2");},
                          ),
                          FilterChip(
                              label: Text("Media Gap"), 
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(side: BorderSide()),
                              onSelected: (bool value) {print("selected3");},
                          ),
                          FilterChip(
                              label: Text("Is Active Insurance"), 
                              selectedColor: Colors.blue,
                              backgroundColor: Colors.transparent,
                              shape: StadiumBorder(side: BorderSide()),
                              onSelected: (bool value) {print("selected4");},
                          ),
                         ],
                       )
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