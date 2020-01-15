import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/hospitalization_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/hospitalization_history_bloc.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../widgets/radio_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';

import '../providers/social_medical_psych_questions.dart';
import 'psychiatric_history.dart';
import 'social_history.dart';

class HospitalizationHistoryScreen extends StatefulWidget {
  HospitalizationHistoryScreen({Key key}) : super(key: key);
  static const routeName = '/hospitalizationHistory';

  @override
  _HospitalizationHistoryScreenState createState() =>
      _HospitalizationHistoryScreenState();
}

class _HospitalizationHistoryScreenState
    extends State<HospitalizationHistoryScreen> {
  final _form = GlobalKey<FormState>();

  DateTime _selectedDate;
  int _history = -1;

  _saveForm() async {
    setState(() {
      _hospitalHistory.isHospitalized = (_history == 1) ? true : false;
      _hospitalHistory.hospitalizationDate = _selectedDate.toUtc().toString();
    });
    await bloc.onSavePressed(_hospitalHistory);
  }

  void _historyFun(val) {
    setState(() => _history = val);
  }

  void _presentDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1920),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        if (date == null) {
          return;
        }
        setState(() {
          _selectedDate = date;
        });
      },
      currentTime: _selectedDate == null ? DateTime.now() : _selectedDate,
      locale: LocaleType.en,
    );
  }

  void _skipClick() {
    _pushReplacementNamed(SocialHistoryScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(PsychiatricHistoryScreen.routeName);
  }

  void _nextClick() async {
    await _saveForm();
    _pushReplacementNamed(SocialHistoryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<HospitalizationHistoryBloc>();

  bool _updated = false;

  @override
  void initState() {
    _selectedDate = DateTime.now().subtract(Duration(days: 1));

    bloc.initialize();
    super.initState();
  }

  HospitalizationHistoryModel _hospitalHistory;

  // todo-Uj date format

  _updateHospitalizationHistory(HospitalizationHistoryModel hospitalHistory) {
    setState(() {
      _hospitalHistory = hospitalHistory;

      if (hospitalHistory.id != null && hospitalHistory.id > 0) {
        _history = hospitalHistory.isHospitalized ? 1 : 0;

        if (hospitalHistory.isHospitalized) {
//          2020-01-06T00:00:00
          var dArr = hospitalHistory.hospitalizationDate.split("-");

          _selectedDate = DateTime(
            int.parse(dArr[0]),
            int.parse(dArr[1]),
            int.parse(dArr[2].substring(0, 2)),
          );
        }
      }

      _updated = true;
    });
  }

  List<GroupModel> _noYes = [
    GroupModel("Yes", 1),
    GroupModel("No", 0),
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final deviceHeightPercent = deviceSize.height - 130;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(6),
            Row(
              children: <Widget>[
                Container(
                  width: (blockSizeHorizontal * 20),
                  height: deviceHeightPercent,
                  child: SubMenu(4, 6),
                ),
                Container(
                  width: (blockSizeHorizontal * 80),
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<HospitalizationHistoryModel>(
                        stream: bloc.hospitalizationHistoryObservable,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !_updated) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updateHospitalizationHistory(snapshot.data);
                            });
                          }

                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Form(
                            key: _form,
                            child: Column(
                              children: <Widget>[
                                NextPreButton(
                                    _skipClick, _previousClick, _nextClick),
                                Expanded(
                                  child: ListView(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Row(
                                            children: _noYes
                                                .map((answer) =>
                                                    RadioButtonCommon(
                                                        _historyFun,
                                                        _history,
                                                        answer.text,
                                                        answer.index))
                                                .toList(),
                                          ),
                                          _history == 1
                                              ? Container(
                                                  width: 250,
                                                  padding:
                                                      EdgeInsets.only(left: 40),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Text(_selectedDate ==
                                                                null
                                                            ? ''
                                                            : '${DateFormat.yMd().format(_selectedDate)}'),
                                                      ),
                                                      FlatButton(
                                                        child: Text(
                                                          'Choose Date',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          _presentDatePicker();
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
