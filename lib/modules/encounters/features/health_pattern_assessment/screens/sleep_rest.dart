import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/sleep_rest_bloc.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';

class SleepRestWidget extends StatefulWidget {
  static const routeName = '/sleepRest';

  @override
  _SleepRestWidgetState createState() => _SleepRestWidgetState();
}

class _SleepRestWidgetState extends State<SleepRestWidget> {
  final bloc = sl<SleepRestBloc>();
  var _formKey = GlobalKey<FormState>();

  DateTime _selectedTime;
  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  void _presentDatePicker() {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (date) {
        if (date == null) {
          return;
        }
        _selectedTime = date;
        bloc.updateBedTime(date.hour.toString() + ':' + date.minute.toString());
      },
      currentTime: _selectedTime == null ? DateTime.now() : _selectedTime,
      locale: LocaleType.en,
    );
  }

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: StreamBuilder<Object>(
          stream: bloc.sleepRestObservable,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MainMenu(8),
                  Row(
                    children: <Widget>[
                      Container(
                        width: deviceWidthPercent * 20,
                        height: deviceHeightPercent,
                        child: SubMenu(7, 8),
                      ),
                      Container(
                        width: deviceWidthPercent * 80,
                        height: deviceHeightPercent,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Any Problems ?', false),
                                    Row(
                                      children: bloc.srProblems.map((p) {
                                        return CheckboxButtonCommon((val) {
                                          bloc.problemCheckboxTap(p.id, val);
                                        }, p.value, p.name);
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Bedtime:', false),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Colors.black),
                                        ),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(bloc.sleepRestData
                                                        .bedTime ==
                                                    null
                                                ? ''
                                                : bloc.sleepRestData.bedTime),
                                          ),
                                          FlatButton(
                                            child: Icon(
                                              Icons.access_time,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              _presentDatePicker();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Hours of sleep/night:', false),
                                    TextFormField(
                                        controller: TextEditingController(
                                          text: bloc.sleepRestData
                                                      .hrsofNightSleep ==
                                                  null
                                              ? ''
                                              : bloc
                                                  .sleepRestData.hrsofNightSleep
                                                  .toString(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Time(in Hours)',
                                        ),
                                        onChanged: (value) =>
                                            bloc.updateHrsofNightSleep(value)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('Number of pillows:', false),
                                    TextFormField(
                                        controller: TextEditingController(
                                          text: bloc.sleepRestData
                                                      .noofpillows ==
                                                  null
                                              ? ''
                                              : bloc.sleepRestData.noofpillows
                                                  .toString(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) =>
                                            bloc.updateNoofpillows(value)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CommonText('What helps you sleep ?', false),
                                    TextFormField(
                                        controller: TextEditingController(
                                            text: bloc
                                                .sleepRestData.helpsToSleep),
                                        onChanged: (value) =>
                                            bloc.updateHelpsToSleep(value)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: bloc.addSleepRest,
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
                                        onPressed: () =>
                                            print('Pressed Cancel'),
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
          }),
    );
  }
}
