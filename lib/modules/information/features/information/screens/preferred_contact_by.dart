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

class PreferredContactByWidget extends StatefulWidget {
  static const routeName = '/preferredContactBy';

  @override
  _PreferredContactByWidgetState createState() =>
      _PreferredContactByWidgetState();
}

class _PreferredContactByWidgetState extends State<PreferredContactByWidget> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

  bool _updated = false;
  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      _preferredContactByCheckBoxValues[0].value =
          patientInfo.resultsEmail ?? false;
      _preferredContactByCheckBoxValues[1].value =
          patientInfo.resultsMail ?? false;
      _preferredContactByCheckBoxValues[2].value =
          patientInfo.resultsPickup ?? false;
      _preferredContactByCheckBoxValues[3].value =
          patientInfo.resultsPhone ?? false;
      _preferredContactByCheckBoxValues[4].value =
          patientInfo.resultsFax ?? false;
      _preferredContactByCheckBoxValues[5].value =
          patientInfo.resultsEaccess ?? false;

      _updated = true;
    });
  }

  final bloc = sl<PatientInformationBloc>();

  @override
  void initState() {
    bloc.initialize();

    super.initState();
  }

  List<GroupModelForCheckBoxEnable> _preferredContactByCheckBoxValues = [
    GroupModelForCheckBoxEnable("Email", false),
    GroupModelForCheckBoxEnable("Mail", false),
    GroupModelForCheckBoxEnable("Pickup", false),
    GroupModelForCheckBoxEnable("Phone", false),
    GroupModelForCheckBoxEnable("Fax", false),
    GroupModelForCheckBoxEnable("Patient Portal", false),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(1, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(8, 1, demographics: true),
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
                            CommonText("Preferred Contact By", false),
                            SizedBox(height: 12),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _preferredContactByCheckBoxValues
                                  .map((var pf) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: pf.value,
                                      onChanged: (val) {
                                        if (!pf.disabled)
                                          setState(() {
                                            pf.value = val;
                                            switch (
                                                _preferredContactByCheckBoxValues
                                                    .indexOf(pf)) {
                                              case 0:
                                                _patientInfo.resultsEmail = val;
                                                break;
                                              case 1:
                                                _patientInfo.resultsMail = val;
                                                break;
                                              case 2:
                                                _patientInfo.resultsPickup =
                                                    val;
                                                break;
                                              case 3:
                                                _patientInfo.resultsPhone = val;
                                                break;
                                              case 4:
                                                _patientInfo.resultsFax = val;
                                                break;
                                              case 5:
                                                _patientInfo.resultsEaccess =
                                                    val;
                                                break;
                                            }
                                          });
                                      },
                                      activeColor:
                                          (pf.disabled) ? Colors.grey : null,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Text(pf.title),
                                  ],
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 8),
                            // -------

                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () =>
                                        bloc.onSavePressed(_patientInfo),
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
