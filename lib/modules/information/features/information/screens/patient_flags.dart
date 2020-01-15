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

class PatientFlagsWidget extends StatefulWidget {
  static const routeName = '/patientFlags';

  @override
  _PatientFlagsWidgetState createState() => _PatientFlagsWidgetState();
}

class _PatientFlagsWidgetState extends State<PatientFlagsWidget> {
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

  TextEditingController _inCollectionsController,
      _alertController,
      _scheduleAlertController,
      _historyOfDrugAbuseController;

  bool _historyOfDrugAbuse = false;
  bool _inCollections = false;
  bool _alert = false;
  bool _blockSchedulingAppointment = false;

  final bloc = sl<PatientInformationBloc>();

  @override
  void initState() {
    _historyOfDrugAbuseController = TextEditingController();
    _inCollectionsController = TextEditingController();
    _alertController = TextEditingController();
    _scheduleAlertController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  bool _updated = false;
  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      _historyOfDrugAbuse = patientInfo.historyOfDrugAbuse ?? false;
      if (_historyOfDrugAbuse) {
        _historyOfDrugAbuseController.text =
            patientInfo.historyOfDrugAbuseComments ?? "";
      }

      _inCollections = patientInfo.inCollections ?? false;
      if (_historyOfDrugAbuse) {
        _inCollectionsController.text = patientInfo.inCollectionsComments ?? "";
      }

      _alert = patientInfo.alert ?? false;
      if (_historyOfDrugAbuse) {
        _alertController.text = patientInfo.alertText ?? "";
      }

      _blockSchedulingAppointment = patientInfo.disallowScheduling ?? false;
      if (_historyOfDrugAbuse) {
        _scheduleAlertController.text = patientInfo.scheduleAlert ?? "";
      }

      _patientFlagsCheckBoxValues[0].value = patientInfo.customAlert1 ?? false;
      _patientFlagsCheckBoxValues[1].value = patientInfo.customAlert2 ?? false;
      _patientFlagsCheckBoxValues[2].value = patientInfo.customAlert3 ?? false;
      _patientFlagsCheckBoxValues[3].value = patientInfo.rpm ?? false;
      _patientFlagsCheckBoxValues[4].value = patientInfo.pgx ?? false;

      _updated = true;
    });
  }

  List<GroupModelForCheckBoxEnable> _patientFlagsCheckBoxValues = [
    GroupModelForCheckBoxEnable("Medicaid", false),
    GroupModelForCheckBoxEnable("Custom Alert 2", false),
    GroupModelForCheckBoxEnable("Custom Alert 3", false),
    GroupModelForCheckBoxEnable("CCM/RPM", false, disabled: true),
    GroupModelForCheckBoxEnable("MMPGx", false, disabled: true),
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
                child: SubMenu(7, 1, demographics: true),
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
                            CommonText("Patient Flags", false),
                            SizedBox(height: 12),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: _historyOfDrugAbuse,
                                        onChanged: (val) => setState(() {
                                          _historyOfDrugAbuse = val;
                                          _patientInfo.historyOfDrugAbuse = val;
                                        }),
                                      ),
                                      Expanded(
                                          child: Text('History of Drug Abuse')),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    enabled: _historyOfDrugAbuse,
                                    onChanged: (txt) => setState(() =>
                                        _patientInfo
                                            .historyOfDrugAbuseComments = txt),
                                    controller: _historyOfDrugAbuseController,
                                    decoration: InputDecoration(
                                      labelText:
                                          'History of Drug Abuse comments',
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
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: _inCollections,
                                        onChanged: (val) => setState(() {
                                          _inCollections = val;
                                          _patientInfo.inCollections = val;
                                        }),
                                      ),
                                      Expanded(child: Text('In Collections')),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    controller: _inCollectionsController,
                                    onChanged: (txt) => setState(() =>
                                        _patientInfo.inCollectionsComments =
                                            txt),
                                    enabled: _inCollections,
                                    decoration: InputDecoration(
                                      labelText: 'In Collections comments',
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
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: _alert,
                                        onChanged: (val) => setState(() {
                                          _alert = val;
                                          _patientInfo.alert = val;
                                        }),
                                      ),
                                      Expanded(child: Text('Alert')),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    onChanged: (txt) => setState(
                                        () => _patientInfo.alertText = txt),
                                    enabled: _alert,
                                    controller: _alertController,
                                    decoration: InputDecoration(
                                      labelText: 'Alert text',
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
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Checkbox(
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        value: _blockSchedulingAppointment,
                                        onChanged: (val) {
                                          setState(() {
                                            _blockSchedulingAppointment = val;
                                            _patientInfo.disallowScheduling =
                                                val;
                                          });
                                        },
                                      ),
                                      Expanded(
                                          child: Text(
                                              'Block Scheduling Appointments')),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    onChanged: (txt) => setState(
                                        () => _patientInfo.scheduleAlert = txt),
                                    controller: _scheduleAlertController,
                                    decoration: InputDecoration(
                                      labelText: 'Schedule Alert',
                                      contentPadding:
                                          EdgeInsets.only(top: 0, bottom: 4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),

                            Wrap(
                              children:
                                  _patientFlagsCheckBoxValues.map((var pf) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Checkbox(
                                      value: pf.value,
                                      onChanged: (val) {
                                        if (!pf.disabled)
                                          setState(() {
                                            switch (_patientFlagsCheckBoxValues
                                                .indexOf(pf)) {
                                              case 0:
                                                _patientInfo.customAlert1 = val;
                                                break;
                                              case 1:
                                                _patientInfo.customAlert2 = val;
                                                break;
                                              case 2:
                                                _patientInfo.customAlert3 = val;
                                                break;
                                              case 3:
                                                _patientInfo.rpm = val;
                                                break;
                                              case 4:
                                                _patientInfo.pgx = val;
                                                break;
                                            }

                                            pf.value = val;
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
