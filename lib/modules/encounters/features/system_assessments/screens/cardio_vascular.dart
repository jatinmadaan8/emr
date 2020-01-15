import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/cardio_vascular.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/cardio_vascular_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class CardioVascularScreen extends StatefulWidget {
  static const routeName = '/cardioVascular';

  @override
  _CardioVascularScreenState createState() => _CardioVascularScreenState();
}

class _CardioVascularScreenState extends State<CardioVascularScreen> {
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

  int _pheripheralPulsesValue = -1, _lRRadioValue = -1;
  int _rhythmRadioValue = 0;
  int _qualityRadioValue = 0;
  int _edemaRadioValue = 0;

  _pheripheralPulsesRadioValueHandler(val) {
    setState(() {
      _pheripheralPulsesValue = val;
      _cardioVascular.palpablePulse =
          (_pheripheralPulsesValue == 0) ? true : false;
      if (val == 0) {
        _cardioVascular.leftNonPalpable = null;
      } else {
        _lRRadioValueHandler(0);
      }
    });
  }

  _rhythmRadioValueHandler(val) {
    setState(() {
      _rhythmRadioValue = val;
      _cardioVascular.rhythmId = val;
    });
  }

  _qualityRadioValueHandler(val) {
    setState(() {
      _qualityRadioValue = val;
      _cardioVascular.qualityId = val;
    });
  }

  _edemaRadioValueHandler(val) {
    setState(() {
      _edemaRadioValue = val;
      _cardioVascular.edemaId = val;
    });
  }

  _lRRadioValueHandler(val) {
    setState(() {
      _lRRadioValue = val;
      _cardioVascular.leftNonPalpable = (_lRRadioValue == 0) ? true : false;
    });
  }

  TextEditingController _describeController;
  TextEditingController _minController;
  TextEditingController _maxController;

  var _cardioVascular = new CardioVascularModel();

  bool updated = false;

  void _updateCardioVascular(var data) {
    setState(() {
      _cardioVascular = data as CardioVascularModel;

      if (_cardioVascular.id != null) {
        _cardioVascular.cardiovascularProblemsDetails.forEach((s) {
          _problemsCheckBoxValues[s.problem.id - 1].value = true;
        });

        _describeController.text = _cardioVascular.comments;
        _minController.text = _cardioVascular.apicalPulseMin.toString();
        _maxController.text = _cardioVascular.apicalPulseMax.toString();

        _pheripheralPulsesValue = _cardioVascular.palpablePulse ? 0 : 1;

        if (!_cardioVascular.palpablePulse) {
          _lRRadioValue = (_cardioVascular.leftNonPalpable) ? 0 : 1;
        }

        _rhythmRadioValue = _cardioVascular.rhythmId;
        _qualityRadioValue = _cardioVascular.qualityId;
        _edemaRadioValue = _cardioVascular.edemaId;
      }

      updated = true;
    });
  }

  final bloc = sl<CardioVascularBloc>();

  @override
  void initState() {
    _describeController = TextEditingController();
    _minController = TextEditingController();
    _maxController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  List<CheckBoxDataModel> _problemsCheckBoxValues = [];
  List<GroupModel> _rhythmRadioValues = [];
  List<GroupModel> _qualityRadioValues = [];
  List<GroupModel> _edemaRadioValues = [];

  List<GroupModel> _peripheralPulsesRadioValues = [
    GroupModel("Palpable", 0),
    GroupModel("Non-palpable", 1),
  ];

  List<GroupModel> _lRRadioValues = [
    GroupModel("L", 0),
    GroupModel("R", 1),
  ];

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
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(2, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<CardioVascularModel>(
                    stream: bloc.cardioVascularObservable,
                    builder:
                        (context, AsyncSnapshot<CardioVascularModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateCardioVascular(snapshot.data);
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
                            CommonText("Any ?", false),
                            SizedBox(height: 12),
                            _cardioVascularProblemWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              onChanged: (text) => setState(
                                  () => _cardioVascular.comments = text),
                              controller: _describeController,
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            _cardioVascularPalpableWidget(),
                            SizedBox(height: 8),
                            Text('If pacemaker,apical pulse'),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) => setState(() =>
                                        _cardioVascular.apicalPulseMin =
                                            int.parse(text)),
                                    controller: _minController,
                                    decoration: InputDecoration(
                                      labelText: 'Min',
                                      contentPadding:
                                          EdgeInsets.only(top: 8, bottom: 4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    style: _optionTextStyle,
                                    keyboardType: TextInputType.number,
                                    onChanged: (text) => setState(() =>
                                        _cardioVascular.apicalPulseMax =
                                            int.parse(text)),
                                    controller: _maxController,
                                    decoration: InputDecoration(
                                      labelText: 'Max',
                                      contentPadding:
                                          EdgeInsets.only(top: 8, bottom: 4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            _cardioVascularRythmWidget(),
                            SizedBox(height: 8),
                            _cardioVascularQualityWidget(),
                            SizedBox(height: 8),
                            _cardioVascularEdemaWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<CardiovascularProblemsDetails>
                                          _temp = [];
                                      _problemsCheckBoxValues.forEach((s) {
                                        if (s.value)
                                          _temp.add(
                                            CardiovascularProblemsDetails(
                                              problemId: s.id,
                                            ),
                                          );
                                      });

                                      _cardioVascular
                                              .cardiovascularProblemsDetails =
                                          _temp;

                                      bloc.onSavePressed(_cardioVascular);
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

  bool qualityLoaded = false,
      rhythmLoaded = false,
      problemsLoaded = false,
      edemaLoaded = false;

  Widget _cardioVascularProblemWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Problems'),
        StreamBuilder<List<CardioVascularDropDown>>(
            stream: bloc.cardiovascularProblems,
            builder: (context,
                AsyncSnapshot<List<CardioVascularDropDown>> snapshot) {
              if (snapshot.hasData && !problemsLoaded) {
                _problemsCheckBoxValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    problemsLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _problemsCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() {
                          if (checkBoxVal.id == 5 && val) {
                            _problemsCheckBoxValues
                                .forEach((v) => v.value = false);
                          }

                          if (checkBoxVal.id != 5 && val) {
                            _problemsCheckBoxValues
                                .where((v) => v.id == 5)
                                .first
                                .value = false;
                          }

                          checkBoxVal.value = val;
                        }),
                        checkBoxVal.value,
                        checkBoxVal.title,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _cardioVascularRythmWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Rhythm", true),
        StreamBuilder<List<CardioVascularDropDown>>(
            stream: bloc.cardiovascularRhythm,
            builder: (context,
                AsyncSnapshot<List<CardioVascularDropDown>> snapshot) {
              if (snapshot.hasData && !rhythmLoaded) {
                _rhythmRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    rhythmLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _rhythmRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _rhythmRadioValueHandler,
                        _rhythmRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _cardioVascularPalpableWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Peripheral Pulses", true),
        Row(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _peripheralPulsesRadioValues
                  .map(
                    (val) => RadioButtonCommon(
                      _pheripheralPulsesRadioValueHandler,
                      _pheripheralPulsesValue,
                      val.text,
                      val.index,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(width: 12),
            (_pheripheralPulsesValue == 1)
                ? Row(
                    children: <Widget>[
                      Text('('),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _lRRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _lRRadioValueHandler,
                                _lRRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(width: 12),
                      Text(')'),
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget _cardioVascularQualityWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Quality", true),
        StreamBuilder<List<CardioVascularDropDown>>(
            stream: bloc.cardiovascularQuality,
            builder: (context,
                AsyncSnapshot<List<CardioVascularDropDown>> snapshot) {
              if (snapshot.hasData && !qualityLoaded) {
                _qualityRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    qualityLoaded = true;
                  });
                });
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _qualityRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _qualityRadioValueHandler,
                        _qualityRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _cardioVascularEdemaWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Edema", true),
        StreamBuilder<List<CardioVascularDropDown>>(
            stream: bloc.cardiovascularEdema,
            builder: (context,
                AsyncSnapshot<List<CardioVascularDropDown>> snapshot) {
              if (snapshot.hasData && !edemaLoaded) {
                _edemaRadioValues = snapshot.data.map((d) {
                  return GroupModel(d.name, d.id);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    edemaLoaded = true;
                  });
                });
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _edemaRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _edemaRadioValueHandler,
                        _edemaRadioValue,
                        val.text,
                        val.index,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }
}

// todo-Uj check required field
