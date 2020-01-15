import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';
import '../providers/vitals_questions.dart';

class VitalsScreen extends StatefulWidget {
  static const routeName = '/vitals';

  @override
  _VitalsScreenState createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  int _locationApicalRadioValue = 0;
  int _locationArmRadioValue = 0;
  int _qualityRadioValue = 0;
  int _positionRadioValue = 0;

  int _heightSelectValue = 0;
  int _heightSelectValue1 = 0;
  String _heightSelectValue2 = '0';

  int _oralAxRadioValue = 0;
  int _weightSelectValue = 0;

  _locationApicalRadioValueHandler(val) {
    setState(() {
      _locationApicalRadioValue = val;
    });
  }

  _locationArmRadioValueHandler(val) {
    setState(() {
      _locationArmRadioValue = val;
    });
  }

  _positionRadioValueHandler(val) {
    setState(() {
      _positionRadioValue = val;
    });
  }

  _qualityRadioValueHandler(val) {
    setState(() {
      _qualityRadioValue = val;
    });
  }

  _heightSelectValueHandler(val) {
    setState(() {
      _heightSelectValue = val;
    });
  }

  _heightSelectValueHandler1(val) {
    setState(() {
      _heightSelectValue1 = val;
    });
  }

  _heightSelectValueHandler2(val) {
    setState(() {
      _heightSelectValue2 = val;
    });
  }

  _oralAxRadioValueHandler(val) {
    setState(() {
      _oralAxRadioValue = val;
    });
  }

  _weightSelectValueHandler(val) {
    setState(() {
      _weightSelectValue = val;
    });
  }

  _numbers(int max) {
    List<int> numbers = [];
    for (int i = 0; i <= max; i++) {
      numbers.add(i);
    }
    return numbers;
  }

  TextEditingController _pulseController,
      _respiratoryController,
      _bmiController,
      _tempController,
      _bloodGulcoseController,
      _spo2Controller,
      _caloriesController,
      _stepsController,
      _systolicPressureController,
      _dialosticPressureController,
      _bloodPresssureController,
      _heartRateController,
      _gulcoseBeforeMealController,
      _gulcoseAfterMealController,
      _commentsController;

  @override
  void initState() {
    _pulseController = TextEditingController();
    _respiratoryController = TextEditingController();
    _bmiController = TextEditingController();
    _tempController = TextEditingController();
    _bloodGulcoseController = TextEditingController();
    _spo2Controller = TextEditingController();
    _caloriesController = TextEditingController();
    _stepsController = TextEditingController();
    _systolicPressureController = TextEditingController();
    _dialosticPressureController = TextEditingController();
    _bloodPresssureController = TextEditingController();
    _heartRateController = TextEditingController();
    _gulcoseBeforeMealController = TextEditingController();
    _gulcoseAfterMealController = TextEditingController();
    _commentsController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    final _vitals = Provider.of<VitalsQuestions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MainMenu(4),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(1, 4),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: <Widget>[
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _pulseController,
                        decoration: InputDecoration(
                          labelText: 'Pulse',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      CommonText("Location", true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _vitals.locationApicalRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _locationApicalRadioValueHandler,
                                _locationApicalRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      CommonText("Quality", true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _vitals.qualityRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _qualityRadioValueHandler,
                                _qualityRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      CommonText("Height FT/IN", false),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: DropdownButton<int>(
                              value: _heightSelectValue,
                              isExpanded: true,
                              iconSize: 24,
                              style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              onChanged: _heightSelectValueHandler,
                              items: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                                  .map<DropdownMenuItem<int>>((val) {
                                return DropdownMenuItem<int>(
                                  value: val,
                                  child: Text(val.toString(),
                                      style: _optionTextStyle),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: DropdownButton<int>(
                              value: _heightSelectValue1,
                              isExpanded: true,
                              iconSize: 24,
                              style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              onChanged: _heightSelectValueHandler1,
                              items: _numbers(36)
                                  .map<DropdownMenuItem<int>>((val) {
                                return DropdownMenuItem<int>(
                                  value: val,
                                  child: Text(val.toString(),
                                      style: _optionTextStyle),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: DropdownButton<String>(
                              value: _heightSelectValue2,
                              isExpanded: true,
                              iconSize: 24,
                              style: _textStyle,
                              underline: Container(
                                color: Colors.black54,
                                height: 1,
                              ),
                              onChanged: _heightSelectValueHandler2,
                              items: ['0', '0.25', '0.5', '0.75']
                                  .map<DropdownMenuItem<String>>((val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val.toString(),
                                      style: _optionTextStyle),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _respiratoryController,
                        decoration: InputDecoration(
                          labelText: 'Respiratory',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _bmiController,
                        decoration: InputDecoration(
                          labelText: 'BMI',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _tempController,
                        decoration: InputDecoration(
                          labelText: 'Temperature',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _vitals.oralAxRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _oralAxRadioValueHandler,
                                _oralAxRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _bloodGulcoseController,
                        decoration: InputDecoration(
                          labelText: 'BloodGulcose',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _spo2Controller,
                        decoration: InputDecoration(
                          labelText: 'SPO2',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _caloriesController,
                        decoration: InputDecoration(
                          labelText: 'Calories',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _stepsController,
                        decoration: InputDecoration(
                          labelText: 'Steps',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      CommonText('Weight(lbs)', false),
                      DropdownButton<int>(
                        value: _weightSelectValue,
                        isExpanded: true,
                        iconSize: 24,
                        style: _textStyle,
                        underline: Container(
                          color: Colors.black54,
                          height: 1,
                        ),
                        onChanged: _weightSelectValueHandler,
                        items: _numbers(300).map<DropdownMenuItem<int>>((val) {
                          return DropdownMenuItem<int>(
                            value: val,
                            child:
                                Text(val.toString(), style: _optionTextStyle),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _systolicPressureController,
                        decoration: InputDecoration(
                          labelText: 'SystolicPressure',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _dialosticPressureController,
                        decoration: InputDecoration(
                          labelText: 'DialosticPressure',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _bloodPresssureController,
                        decoration: InputDecoration(
                          labelText: 'BloodPressure',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      CommonText("Location", true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _vitals.locationArmRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _locationArmRadioValueHandler,
                                _locationArmRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      CommonText("Position", true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _vitals.positionRadioValues
                            .map(
                              (val) => RadioButtonCommon(
                                _positionRadioValueHandler,
                                _positionRadioValue,
                                val.text,
                                val.index,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _heartRateController,
                        decoration: InputDecoration(
                          labelText: 'HeartRate',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _gulcoseBeforeMealController,
                        decoration: InputDecoration(
                          labelText: 'Glucose Before Meal',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _gulcoseAfterMealController,
                        decoration: InputDecoration(
                          labelText: 'Gulcose After Meal',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        style: _optionTextStyle,
                        controller: _bloodPresssureController,
                        decoration: InputDecoration(
                          labelText: 'Comments',
                          contentPadding: EdgeInsets.only(top: 8, bottom: 4),
                        ),
                        maxLines: 3,
                        minLines: 2,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              onPressed: () => print('Pressed Save'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
