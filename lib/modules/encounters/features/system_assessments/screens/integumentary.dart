import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/integumentary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/integumentary_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import '../providers/system_assessments_questions.dart';

class IntegumentaryScreen extends StatefulWidget {
  static const routeName = '/integumentary';

  @override
  _IntegumentaryScreenState createState() => _IntegumentaryScreenState();
}

class _IntegumentaryScreenState extends State<IntegumentaryScreen> {
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

  int _skinColorRadioValue = 0;
  int _historyOfSkinProblemsRadioValue = 0;
  int _temperatureRadioValue = 0;
  int _turgorRadioValue = 0;
  int _conditionRadioValue = 0;
  int _footCareRadioValue = 0;

  _skinColorRadioValueHandler(val) {
    setState(() {
      _skinColorRadioValue = val;
      _integumentary.colorId = val;
    });
  }

  _historyOfSkinProblemsRadioValueHandler(val) {
    setState(() {
      _historyOfSkinProblemsRadioValue = val;
      _integumentary.isSkinProblem = (val == 0) ? true : false;
    });
  }

  _temperatureRadioValueHandler(val) {
    setState(() {
      _temperatureRadioValue = val;
      _integumentary.tempId = val;
    });
  }

  _turgorRadioValueHandler(val) {
    setState(() {
      _turgorRadioValue = val;
      _integumentary.turgorId = val;
    });
  }

  _conditionRadioValueHandler(val) {
    setState(() {
      _conditionRadioValue = val;
      _integumentary.conditionId = val;
    });
  }

  _footCareRadioValueHandler(val) {
    setState(() {
      _footCareRadioValue = val;
      _integumentary.isFootCare = (val == 0) ? true : false;
    });
  }

  TextEditingController _skinColorController;
  TextEditingController _skinProblemController;
  TextEditingController _skinConditionController;
  TextEditingController _footCareController;

  final bloc = sl<IntegumentaryBloc>();

  var _integumentary = new IntegumentaryModel();

  void _updateIntegumentary(var data) {
    setState(() {
      _integumentary = data as IntegumentaryModel;

      if (_integumentary.id != null) {
        _skinColorRadioValue = _integumentary.colorId;
        _historyOfSkinProblemsRadioValue = _integumentary.isSkinProblem ? 0 : 1;
        _temperatureRadioValue = _integumentary.tempId;
        _turgorRadioValue = _integumentary.turgorId;
        _conditionRadioValue = _integumentary.conditionId;
        _footCareRadioValue = _integumentary.isFootCare ? 0 : 1;

        if (_skinColorRadioValue == 6) {
          _skinColorController.text = _integumentary.colorDesc;
        }

        if (_historyOfSkinProblemsRadioValue == 0) {
          _skinProblemController.text = _integumentary.skinProblemDesc;
        }

        if (_conditionRadioValue == 7) {
          _skinConditionController.text = _integumentary.conditionDesc;
        }

        if (_footCareRadioValue == 0) {
          _footCareController.text = _integumentary.footCareDesc;
        }
      }

      updated = true;
    });
  }

  @override
  void initState() {
    _skinColorController = TextEditingController();
    _skinProblemController = TextEditingController();
    _skinConditionController = TextEditingController();
    _footCareController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  bool skinColorLoaded = false,
      skinTemperatureLoaded = false,
      skinTurgorLoaded = false,
      skinConditionLoaded = false,
      updated = false;

  List<CheckBoxDataModel> _skinColorRadioValues = [];
  List<CheckBoxDataModel> _skinTempRadioValues = [];
  List<CheckBoxDataModel> _skinTurgorRadioValues = [];
  List<CheckBoxDataModel> _skinConditionRadioValues = [];
  List<GroupModel> _yesNoRadioValues = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];

  Widget _skinColorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Skin Color", false),
        Wrap(
          children: <Widget>[
            StreamBuilder<List<IntegumentaryLookUpData>>(
                stream: bloc.skinColor,
                builder: (context,
                    AsyncSnapshot<List<IntegumentaryLookUpData>> snapshot) {
                  if (snapshot.hasData && !skinColorLoaded) {
                    _skinColorRadioValues = snapshot.data.map((d) {
                      return CheckBoxDataModel(d.id, d.name, false);
                    }).toList();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        skinColorLoaded = true;
                      });
                    });
                  }

                  return Wrap(
                    children: _skinColorRadioValues
                        .map(
                          (val) => RadioButtonCommon(
                            _skinColorRadioValueHandler,
                            _skinColorRadioValue,
                            val.title,
                            val.id,
                          ),
                        )
                        .toList(),
                  );
                }),
            (_skinColorRadioValue == 6)
                ? Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: _optionTextStyle,
                      controller: _skinColorController,
                      onChanged: (val) => _integumentary.colorDesc = val,
                      decoration: InputDecoration(
                        labelText: 'Describe *',
                        contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget _skinProblemsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("History of skin problems", false),
        Wrap(
          children: <Widget>[
            Wrap(
              children: _yesNoRadioValues
                  .map(
                    (val) => RadioButtonCommon(
                      _historyOfSkinProblemsRadioValueHandler,
                      _historyOfSkinProblemsRadioValue,
                      val.text,
                      val.index,
                    ),
                  )
                  .toList(),
            ),
            (_historyOfSkinProblemsRadioValue == 0)
                ? Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: _optionTextStyle,
                      controller: _skinProblemController,
                      onChanged: (val) => _integumentary.skinProblemDesc = val,
                      decoration: InputDecoration(
                        labelText: 'Describe *',
                        contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget _skinTemperatureWiget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Temperature", false),
        StreamBuilder<List<IntegumentaryLookUpData>>(
            stream: bloc.skinTemp,
            builder: (context,
                AsyncSnapshot<List<IntegumentaryLookUpData>> snapshot) {
              if (snapshot.hasData && !skinTemperatureLoaded) {
                _skinTempRadioValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    skinTemperatureLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _skinTempRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _temperatureRadioValueHandler,
                        _temperatureRadioValue,
                        val.title,
                        val.id,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _skinTurgorWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Turgor", false),
        StreamBuilder<List<IntegumentaryLookUpData>>(
            stream: bloc.skinTurgor,
            builder: (context,
                AsyncSnapshot<List<IntegumentaryLookUpData>> snapshot) {
              if (snapshot.hasData && !skinTurgorLoaded) {
                _skinTurgorRadioValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    skinTurgorLoaded = true;
                  });
                });
              }

              return Wrap(
                children: _skinTurgorRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _turgorRadioValueHandler,
                        _turgorRadioValue,
                        val.title,
                        val.id,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  Widget _skinConditionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Condition", false),
        StreamBuilder<List<IntegumentaryLookUpData>>(
            stream: bloc.skinCondition,
            builder: (context,
                AsyncSnapshot<List<IntegumentaryLookUpData>> snapshot) {
              if (snapshot.hasData && !skinConditionLoaded) {
                _skinConditionRadioValues = snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    skinConditionLoaded = true;
                  });
                });
              }

              return Wrap(children: [
                ..._skinConditionRadioValues
                    .map(
                      (val) => RadioButtonCommon(
                        _conditionRadioValueHandler,
                        _conditionRadioValue,
                        val.title,
                        val.id,
                      ),
                    )
                    .toList(),
                (_conditionRadioValue == 7)
                    ? Container(
                        width: 250,
                        padding: EdgeInsets.only(left: 16),
                        child: TextFormField(
                          style: _optionTextStyle,
                          controller: _skinConditionController,
                          onChanged: (val) =>
                              _integumentary.conditionDesc = val,
                          decoration: InputDecoration(
                            labelText: 'Describe *',
                            contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                          ),
                        ),
                      )
                    : Container(),
              ]);
            }),
      ],
    );
  }

  Widget _footCareWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText("Foot care needs", false),
        Wrap(
          children: <Widget>[
            Wrap(
              children: _yesNoRadioValues
                  .map(
                    (val) => RadioButtonCommon(
                      _footCareRadioValueHandler,
                      _footCareRadioValue,
                      val.text,
                      val.index,
                    ),
                  )
                  .toList(),
            ),
            (_footCareRadioValue == 0)
                ? Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: _optionTextStyle,
                      controller: _footCareController,
                      onChanged: (val) => _integumentary.footCareDesc = val,
                      decoration: InputDecoration(
                        labelText: 'Describe *',
                        contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                      ),
                    ),
                  )
                : Container(),
          ],
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
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(6, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<IntegumentaryModel>(
                    stream: bloc.integumentaryObservable,
                    builder:
                        (context, AsyncSnapshot<IntegumentaryModel> snapshot) {
                      if (snapshot.hasData && !updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateIntegumentary(snapshot.data);
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
                            _skinColorWidget(),
                            SizedBox(height: 8),
                            _skinProblemsWidget(),
                            SizedBox(height: 8),
                            _skinTemperatureWiget(),
                            SizedBox(height: 8),
                            _skinTurgorWidget(),
                            SizedBox(height: 8),
                            _skinConditionWidget(),
                            SizedBox(height: 8),
                            _footCareWidget(),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () =>
                                        bloc.onSavePressed(_integumentary),
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

// todo-Uj required fields checking
