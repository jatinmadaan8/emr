import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:intl/intl.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/surgery_history_block.dart';
import 'medical_history.dart';
import 'package:provider/provider.dart';

import '../../../../../modules/encounters/features/social_medical_psych_hx/providers/social_medical_psych_questions.dart';
import '../../../../../modules/encounters/features/widgets/common_text.dart';
import '../../../../../modules/encounters/data/models/social_medical_psych_hx/surgery_history.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/next_prev_button.dart';
import 'psychiatric_history.dart';

class SurgeryHistoryScreen extends StatefulWidget {
  static const routeName = '/surgeryHistory';
  SurgeryHistoryScreen({Key key}) : super(key: key);

  @override
  _SurgeryHistoryState createState() => _SurgeryHistoryState();
}

class _SurgeryHistoryState extends State<SurgeryHistoryScreen> {
  final _form = GlobalKey<FormState>();

  DateTime _selectedDate;

  SurgeryHistoryModel _surgeryHistory;

  TextEditingController _notecontroller = TextEditingController();
  List<SurgeryTypes> _surgeryTypes = [];

  void _removeCharge(surgeryTypes) {
    setState(() {
      _surgeryTypes.remove(surgeryTypes);
    });
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
          _dateError = null;
        });
      },
      currentTime: _selectedDate == null ? DateTime.now() : _selectedDate,
      locale: LocaleType.en,
    );
  }

  void _skipClick() {
    _pushReplacementNamed(PsychiatricHistoryScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(MedicalHistoryScreen.routeName);
  }

  bool _updating = false;

  _nextClick() async {
    setState(() {
      _updating = true;
    });
    await _saveForm();
    setState(() {
      _updating = false;
    });
    _pushReplacementNamed(PsychiatricHistoryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  _saveForm() async {
    setState(() {
      _surgeryHistory.comments = commentController.text ?? "";

      _surgeryHistory.surgerytypes = _surgeryTypes
          .map(
            (s) => SurgeryTypes(
              id: s.id,
              surgeryDate: s.surgeryDate,
              surgeryHistoryId: s.surgeryHistoryId,
              surgeryId: s.surgeryId,
              surgeryNotes: s.surgeryNotes,
            ),
          )
          .toList();
    });

    await bloc.onSavePressed(_surgeryHistory);
  }

  final bloc = sl<SurgeryHistoryBloc>();

  TextEditingController commentController;

  @override
  void initState() {
    commentController = TextEditingController();

    bloc.initialize();
    super.initState();
  }

  bool _updated = false, _surgeryTypesLoaded = false;

  List<SurgeryTypesLookupModel> _surgeryTypesSelectValues = [];
  SurgeryTypesLookupModel surgeryTypeSelectValue;

  Widget _surgeryWidget() {
    return StreamBuilder<List<SurgeryTypesLookupModel>>(
        stream: bloc.surgeryTypes,
        builder: (BuildContext context,
            AsyncSnapshot<List<SurgeryTypesLookupModel>> snapshot) {
          if (snapshot.hasData && !_surgeryTypesLoaded) {
            _surgeryTypesSelectValues = snapshot.data;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _surgeryTypesLoaded = true;
              });
            });
          }
          return Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: DropdownButton<SurgeryTypesLookupModel>(
                  hint: CommonText('Surgery', true),
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  items: _surgeryTypesSelectValues
                      .map((SurgeryTypesLookupModel g) {
                    return new DropdownMenuItem<SurgeryTypesLookupModel>(
                      child: new Text(g.name),
                      value: g,
                    );
                  }).toList(),
                  onChanged: (SurgeryTypesLookupModel newValue) {
                    setState(() {
                      surgeryTypeSelectValue = newValue;
                      _surgerySelectError = null;
                    });
                  },
                  value: surgeryTypeSelectValue,
                ),
                padding: EdgeInsets.all(8.0),
              ),
              _surgerySelectError == null
                  ? SizedBox.shrink()
                  : Text(
                      _surgerySelectError ?? "",
                      style: TextStyle(color: Colors.red),
                    ),
              SizedBox(height: 12),
            ],
          );
        });
  }

  _updateSurgeryHistory(SurgeryHistoryModel surgeryHistoryModel) {
    setState(() {
      _surgeryHistory = surgeryHistoryModel;

      if (surgeryHistoryModel.id != null && surgeryHistoryModel.id > 0) {
        print(jsonEncode(surgeryHistoryModel.toJson()));

        commentController.text = surgeryHistoryModel.comments ?? "";

        if (surgeryHistoryModel.surgerytypes != null &&
            surgeryHistoryModel.surgerytypes.length > 0) {
          surgeryHistoryModel.surgerytypes.forEach((s) {
            _surgeryTypes.add(s);
          });
        }
      }

      _updated = true;
    });
  }

  String _surgerySelectError, _dateError;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final blockSizeHorizontalForSecond = blockSizeHorizontal * 75;
    final deviceHeightPercent = deviceSize.height - 130;
    final _questions = Provider.of<SocialMedicalPsychQuestions>(context);

    return Stack(
      children: <Widget>[
        Scaffold(
            appBar: CustomAppBar(true),
            drawer: AppDrawer(),
            body: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                MainMenu(6),
                Row(children: <Widget>[
                  Container(
                    width: (blockSizeHorizontal * 20),
                    height: deviceHeightPercent,
                    child: SubMenu(2, 6),
                  ),
                  Container(
                    width: (blockSizeHorizontal * 80),
                    height: deviceHeightPercent,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StreamBuilder<SurgeryHistoryModel>(
                          stream: bloc.surgeryHistoryModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && !_updated) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                _updateSurgeryHistory(snapshot.data);
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
                                    child: ListView(children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          _surgeryWidget(),
                                          Column(
                                            children: <Widget>[
                                              Container(
                                                width: 200,
                                                alignment: Alignment.center,
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
                                                        'Date',
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
                                                padding: EdgeInsets.all(8.0),
                                              ),
                                              _dateError == null
                                                  ? SizedBox.shrink()
                                                  : Text(
                                                      _dateError ?? "",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                              SizedBox(height: 12),
                                            ],
                                          ),
                                          Container(
                                            width: 200,
                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              controller: _notecontroller,
                                              decoration: InputDecoration(
                                                  labelText: 'Notes',
                                                  border: OutlineInputBorder()),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: new FlatButton(
                                              child: Text(
                                                'Add Surgery',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  bool isValid = _form
                                                      .currentState
                                                      .validate();

                                                  if (surgeryTypeSelectValue ==
                                                      null) {
                                                    setState(() {
                                                      _surgerySelectError =
                                                          "Surgery Type must be selected";
                                                    });
                                                    isValid = false;
                                                  }

                                                  if (_selectedDate == null) {
                                                    setState(() {
                                                      _dateError =
                                                          "Surgery Date must be selected";
                                                    });
                                                    isValid = false;
                                                  }

                                                  if (!isValid) return;

                                                  var s = SurgeryTypes(
                                                      surgery: Surgery(
                                                          name:
                                                              surgeryTypeSelectValue
                                                                  .name),
                                                      surgeryId:
                                                          surgeryTypeSelectValue
                                                              .id,
                                                      surgeryDate: _selectedDate
                                                          .toUtc()
                                                          .toString(),
                                                      surgeryNotes:
                                                          _notecontroller.text);
                                                  _surgeryTypes.add(s);

                                                  surgeryTypeSelectValue = null;
                                                  _selectedDate = null;
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      Table(
                                        border:
                                            TableBorder.all(color: Colors.grey),
                                        children: [
                                          TableRow(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200]),
                                              children: [
                                                Container(
                                                  width: 150,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CommonText(
                                                      'Surgery', false),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(8.0),
                                                  child:
                                                      CommonText('Date', false),
                                                ),
                                                Container(
                                                  width: 50,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CommonText(
                                                      'Notes', false),
                                                ),
                                                Container(
                                                  width: 50,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(8.0),
                                                  child: CommonText(
                                                      'Actions', false),
                                                )
                                              ]),
                                        ],
                                      ),
                                      Container(
                                        child: (!_surgeryTypes.isEmpty &&
                                                _surgeryTypes.length > 0)
                                            ? Table(
                                                defaultColumnWidth:
                                                    FixedColumnWidth(150.0),
                                                border: TableBorder.all(
                                                    color: Colors.grey),
                                                children: [
                                                  ..._surgeryTypes.map((item) {
                                                    return TableRow(children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            item.surgery.name,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.0)),
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            item.surgeryDate
                                                                    .isEmpty
                                                                ? ''
                                                                : item
                                                                    .surgeryDate,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.0)),
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            item.surgeryNotes,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    20.0)),
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        child: IconButton(
                                                          icon: Icon(
                                                              Icons.delete),
                                                          onPressed: () {
                                                            _removeCharge(item);
                                                          },
                                                        ),
                                                      )
                                                    ]);
                                                  }).toList(),
                                                ],
                                              )
                                            : null,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                            labelText: 'Comments',
                                            border: OutlineInputBorder()),
                                        maxLines: 1,
                                        keyboardType: TextInputType.multiline,
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                ])
              ],
            ))),
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          left: 0,
          child: (_updating)
              ? Container(
                  color: Colors.black38,
                  child: Center(
                      child: Container(
                          height: 48,
                          width: 48,
                          child: CircularProgressIndicator())),
                )
              : Container(),
        ),
      ],
    );
  }
}
