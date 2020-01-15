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

class PhonesWidget extends StatefulWidget {
  static const routeName = '/phones';

  @override
  _PhonesWidgetState createState() => _PhonesWidgetState();
}

class _PhonesWidgetState extends State<PhonesWidget> {
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

  int _preferredSelectValue;

  _preferredSelectValueHandler(val) {
    setState(() {
      _preferredSelectValue = val;
    });
  }

  TextEditingController _cellPhoneController,
      _workPhoneController,
      _homePhoneController;

  final bloc = sl<PatientInformationBloc>();

  @override
  void initState() {
    _cellPhoneController = TextEditingController();
    _workPhoneController = TextEditingController();
    _homePhoneController = TextEditingController();
    bloc.initialize();

    super.initState();
  }

  bool _updated = false, _preferredPhoneLoaded = false;
  PatientInformationModel _patientInfo;

  void _updatePatientInformation(PatientInformationModel patientInfo) {
    setState(() {
      _patientInfo = patientInfo;

      _homePhoneController.text = patientInfo.phoneNumber ?? "";
      _cellPhoneController.text = patientInfo.mobilePhoneNumber ?? "";
      _workPhoneController.text = patientInfo.workPhoneNumber ?? "";

      // todo-Uj
//      _preferredSelectValue =
//          patientInfo.preferredPhoneNumber.hashCode ?? 0;

      _updated = true;
    });
  }

  List<GroupModel> _preferredPhoneSelectValues = [];

  Widget _preferredPhoneWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Preferred',
          style: _optionTextStyle,
        ),
        SizedBox(height: 4),
        StreamBuilder<List<PreferredPhoneModel>>(
            // todo-Uj preferred phone - which api ???
            stream: bloc.preferredPhone,
            builder: (context, snapshot) {
              if (snapshot.hasData && !_preferredPhoneLoaded) {
                _preferredPhoneSelectValues = snapshot.data.map((d) {
                  return GroupModel(d.displayTest, d.dataValue.hashCode);
                }).toList();

                _preferredSelectValue = _preferredPhoneSelectValues[0].index;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _preferredPhoneLoaded = true;
                  });
                });
              }

              if (_preferredSelectValue == null) return Container();

              return DropdownButton<int>(
                isDense: true,
                isExpanded: true,
                iconSize: 24,
                // style: _textStyle,
                underline: Container(
                  color: Colors.black45,
                  height: 1,
                ),
                value: _preferredSelectValue,
                onChanged: _preferredSelectValueHandler,
                items: _preferredPhoneSelectValues
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
                child: SubMenu(6, 1, demographics: true),
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
                            CommonText("Phones", false),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _homePhoneController,
                              onChanged: (txt) => setState(
                                  () => _patientInfo.phoneNumber = txt),
                              decoration: InputDecoration(
                                labelText: 'Home Phone',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _cellPhoneController,
                              onChanged: (txt) => setState(
                                  () => _patientInfo.mobilePhoneNumber = txt),
                              decoration: InputDecoration(
                                labelText: 'Cell Phone',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _workPhoneController,
                              onChanged: (txt) => setState(
                                  () => _patientInfo.workPhoneNumber = txt),
                              decoration: InputDecoration(
                                labelText: 'Works Phone',
                                contentPadding:
                                    EdgeInsets.only(top: 0, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 12),
                            _preferredPhoneWidget(),
                            SizedBox(height: 8),
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
