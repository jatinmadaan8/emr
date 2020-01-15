import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/common_text.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/radio_button.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/sub_menu.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/blocs/other_information_bloc.dart';
//import 'package:practiceinsights_emr_provider/modules/information/features/blocs/patient_information_bloc.dart';
import 'package:provider/provider.dart';

import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';

class ImmunizationRegistryWidget extends StatefulWidget {
  static const routeName = '/immunizationRegistry';

  @override
  _ImmunizationRegistryWidgetState createState() =>
      _ImmunizationRegistryWidgetState();
}

class _ImmunizationRegistryWidgetState
    extends State<ImmunizationRegistryWidget> {
  var _formKey = GlobalKey<FormState>();

  bool _publicityLoaded = false,
      _registryStatusLoaded = false,
      _updated = false;

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  int _publicitySelectValue;
  int _registryStatusSelectValue;
  int _shareHealthStatusStatusSelectValue;

  _publicitySelectValueHandler(val) {
    setState(() {
      _publicitySelectValue = val;
    });
  }

  _registryStatusSelectValueHandler(val) {
    setState(() {
      _registryStatusSelectValue = val;
    });
  }

  _shareHealthStatusSelectValueHandler(val) {
    setState(() {
      _shareHealthStatusStatusSelectValue = val;
    });
  }

  TextEditingController _effectivepublicityController,
      _effectiveregistrystatusController,
      _effectivesharehealthstatusController;

  final bloc = sl<OtherInformationBloc>();

  @override
  void initState() {
    _effectivepublicityController = TextEditingController();
    _effectiveregistrystatusController = TextEditingController();
    _effectivesharehealthstatusController = TextEditingController();

    init();

    super.initState();
  }

  init() async {
    Future.wait(<Future>[
      bloc.getPublicity(),
      bloc.getRegistryStatus(),
    ]);

    bloc.initialize();
  }

  OtherInformationModel _otherInfo;

  DateTime _publicityDate, _registryDate, _shareHealthDate;

  void _updateOtherInformation(List<OtherInformationModel> otherInfo) {
    setState(() {
      _otherInfo = otherInfo[0];

      _publicitySelectValue = _otherInfo.publicityCodeId;
      _registryStatusSelectValue = _otherInfo.registryStatusCodeId;
      _shareHealthStatusStatusSelectValue = _otherInfo.shareHealthData;

      if (_otherInfo.publicityEffDate != null) {
        _publicityDate = _getDate(_otherInfo.publicityEffDate);
        _effectivepublicityController.text = _getString(_publicityDate);
      }

      if (_otherInfo.registryEffDate != null) {
        _registryDate = _getDate(_otherInfo.registryEffDate);
        _effectiveregistrystatusController.text = _getString(_registryDate);
      }

      if (_otherInfo.shareHealthDataEffDate != null) {
        _shareHealthDate = _getDate(_otherInfo.shareHealthDataEffDate);
        _effectivesharehealthstatusController.text =
            _getString(_shareHealthDate);
      }

      _updated = true;
    });
  }

  String _getString(DateTime d) => "${d.month}/${d.day}/${d.year}";

  DateTime _getDate(String s) {
    var dArr = s.split("-");

    return DateTime(int.parse(dArr[0]), int.parse(dArr[1]),
        int.parse(dArr[2].substring(0, 2)));
  }

  List<GroupModel> _publicitySelectValues = [],
      _registryStatusSelectValues = [];

  Widget _publicityWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Publicity',
                style: _optionTextStyle,
              ),
              StreamBuilder(
                stream: bloc.publicity,
                builder: (BuildContext context,
                    AsyncSnapshot<List<PublicityCodeNavigation>> snapshot) {
                  if (snapshot.hasData && !_publicityLoaded) {
                    _publicitySelectValues = snapshot.data
                        .map((d) => GroupModel(d.description, d.id))
                        .toList();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _publicityLoaded = true;
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
                    value: _publicitySelectValue,

                    onChanged: _publicitySelectValueHandler,
                    items: _publicitySelectValues
                        .map<DropdownMenuItem<int>>((answer) {
                      return DropdownMenuItem<int>(
                        value: answer.index,
                        child: Text(answer.text),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            style: _optionTextStyle,
            controller: _effectivepublicityController,
            decoration: InputDecoration(
              labelText: 'Effective Date',
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
                      _effectivepublicityController.text =
                          '${picked.day}/${picked.month}/${picked.year}';
                      print(_effectivepublicityController.text);
                    });
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    top: 0,
                    right: 4,
                    bottom: 6,
                    left: 4,
                  ),
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
    );
  }

  Widget _registryStatusWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Registry Status',
                    style: _optionTextStyle,
                  ),
                  StreamBuilder(
                    stream: bloc.registryStatus,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<RegistryStatusCodeNavigation>>
                            snapshot) {
                      if (snapshot.hasData && !_registryStatusLoaded) {
                        _registryStatusSelectValues = snapshot.data
                            .map((d) => GroupModel(d.description, d.id))
                            .toList();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _registryStatusLoaded = true;
                          });
                        });
                      }
                      return DropdownButton<int>(
                        isDense: true,
                        isExpanded: true,
                        iconSize: 24,
                        underline: Container(
                          color: Colors.black54,
                          height: 1,
                        ),
                        value: _registryStatusSelectValue,
                        onChanged: _registryStatusSelectValueHandler,
                        items: _registryStatusSelectValues
                            .map<DropdownMenuItem<int>>((answer) {
                          return DropdownMenuItem<int>(
                            value: answer.index,
                            child: Text(answer.text),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: TextFormField(
                style: _optionTextStyle,
                controller: _effectiveregistrystatusController,
                decoration: InputDecoration(
                  labelText: 'Effective Date',
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
                          _effectiveregistrystatusController.text =
                              '${picked.day}/${picked.month}/${picked.year}';
                          print(_effectiveregistrystatusController.text);
                        });
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        top: 0,
                        right: 4,
                        bottom: 6,
                        left: 4,
                      ),
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
      ],
    );
  }

  void _onSavePressed() {
    setState(() {
      _otherInfo.publicityCodeId = _publicitySelectValue;
      _otherInfo.registryStatusCodeId = _registryStatusSelectValue;
      _otherInfo.shareHealthData = _shareHealthStatusStatusSelectValue;

      bloc.onSavePressed(_otherInfo);
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
          MainMenu(3, demographics: true),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(2, 3, demographics: true),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<List<OtherInformationModel>>(
                    stream: bloc.otherInformationObservable,
                    builder: (context, snapshot) {
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
                            CommonText('Immunization Registry', false),
                            SizedBox(
                              height: 12,
                            ),
                            _publicityWidget(),
                            SizedBox(height: 12),
                            _registryStatusWidget(),
                            SizedBox(height: 12),
                            Text(
                              'Share Health Status:',
                              style: _optionTextStyle,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: <Widget>[
                                      RadioButtonCommon(
                                        _shareHealthStatusSelectValueHandler,
                                        _shareHealthStatusStatusSelectValue,
                                        'Yes',
                                        1,
                                      ),
                                      RadioButtonCommon(
                                        _shareHealthStatusSelectValueHandler,
                                        _shareHealthStatusStatusSelectValue,
                                        'No',
                                        0,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: TextFormField(
                                      style: _optionTextStyle,
                                      controller:
                                          _effectivesharehealthstatusController,
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
                                                _effectivesharehealthstatusController
                                                        .text =
                                                    '${picked.day}/${picked.month}/${picked.year}';
                                                print(
                                                    _effectivesharehealthstatusController
                                                        .text);
                                              });
                                          },
                                          child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.only(
                                              top: 0,
                                              right: 4,
                                              bottom: 6,
                                              left: 4,
                                            ),
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
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}

// todo-Uj format of sending date and validation and required
