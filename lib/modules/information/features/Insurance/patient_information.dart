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

class PatientInformationWidget extends StatefulWidget {
  static const routeName = '/patientInformationInsurance';

  @override
  _PatientInformationWidgetState createState() =>
      _PatientInformationWidgetState();
}

class _PatientInformationWidgetState extends State<PatientInformationWidget> {
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

  int _billTypeSelectValue = 0;
  int _referralSourceSelectValue = 0;

  _billTypeSelectValueHandler(val) {
    setState(() {
      _billTypeSelectValue = val;
    });
  }

  _referralSourceSelectValueHandler(val) {
    setState(() {
      _referralSourceSelectValue = val;
    });
  }

  TextEditingController _patientsignatureController,
      _primarycaredrController,
      _pharmacyController,
      _referredbyController;

  @override
  void initState() {
    _patientsignatureController = TextEditingController();
    _primarycaredrController = TextEditingController();
    _pharmacyController = TextEditingController();
    _referredbyController = TextEditingController();

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
                child: SubMenu(1, 2, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      CommonText('Patient Information', false),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Bill Type',
                        style: _optionTextStyle,
                      ),
                      SizedBox(height: 4),
                      DropdownButton<int>(
                        isDense: true,
                        isExpanded: true,
                        iconSize: 24,
                        // style: _textStyle,
                        underline: Container(
                          color: Colors.black54,
                          height: 1,
                        ),
                        value: _billTypeSelectValue,
                        onChanged: _billTypeSelectValueHandler,
                        items: _informations.billTypeSelectValues
                            .map<DropdownMenuItem<int>>((answer) {
                          return DropdownMenuItem<int>(
                            value: answer.index,
                            child: Text(answer.text),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 12),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _patientsignatureController,
                        decoration: InputDecoration(
                          labelText: 'Patient Signature',
                          contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                          suffix: GestureDetector(
                            onTap: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990, 8),
                                lastDate: DateTime(2101),
                              );
                              if (picked != null)
                                setState(() {
                                  _patientsignatureController.text =
                                      '${picked.day}/${picked.month}/${picked.year}';
                                  print(_patientsignatureController.text);
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
                      SizedBox(height: 12),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _primarycaredrController,
                        decoration: InputDecoration(
                          labelText: 'Primary Care Dr',
                          contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                        ),
                      ),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _pharmacyController,
                        decoration: InputDecoration(
                          labelText: 'Pharmacy',
                          contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Referral Source',
                        style: _optionTextStyle,
                      ),
                      SizedBox(height: 4),
                      DropdownButton<int>(
                        isDense: true,
                        isExpanded: true,
                        iconSize: 24,
                        // style: _textStyle,
                        underline: Container(
                          color: Colors.black54,
                          height: 1,
                        ),
                        value: _referralSourceSelectValue,
                        onChanged: _referralSourceSelectValueHandler,
                        items: _informations.referralSourceSelectValues
                            .map<DropdownMenuItem<int>>((answer) {
                          return DropdownMenuItem<int>(
                            value: answer.index,
                            child: Text(answer.text),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _referredbyController,
                        decoration: InputDecoration(
                          labelText: 'Referral By',
                          contentPadding: EdgeInsets.only(top: 0, bottom: 4),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
