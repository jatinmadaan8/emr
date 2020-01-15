import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../../../../modules/encounters/features/widgets/checkbox_button.dart';
import '../../../../../modules/encounters/features/social_medical_psych_hx/providers/social_medical_psych_questions.dart';
import '../../../../../modules/encounters/features/widgets/common_text.dart';
import '../../../../../modules/encounters/data/models/social_medical_psych_hx/medical_history_predicate.dart';
import '../../../../../modules/encounters/features/social_medical_psych_hx/block/medical_history_block.dart';
import '../../../../../app/di/injection_container.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/next_prev_button.dart';
import 'surgery_history.dart';

class MedicalHistoryScreen extends StatefulWidget {
  static const routeName = '/medicalHistory';
  MedicalHistoryScreen({Key key}) : super(key: key);

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistoryScreen> {
  final _form = GlobalKey<FormState>();
  final bloc = sl<MedicalHistoryBloc>();

  List<MedicalHistoryPredicate> _medicalHistoryPredicateList = [];

  void _removeCharge(medicalHistoryPredicate) {
    setState(() {
      _medicalHistoryPredicateList.remove(medicalHistoryPredicate);
    });
  }

  void _skipClick() {
    _pushReplacementNamed(SurgeryHistoryScreen.routeName);
  }

  void _previousClick() {
    //_pushReplacementNamed('');
  }

  void _nextClick() {
    _pushReplacementNamed(SurgeryHistoryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final blockSizeHorizontalForSecond = blockSizeHorizontal * 75;
    final deviceHeightPercent = deviceSize.height - 130;
    final _questions = Provider.of<SocialMedicalPsychQuestions>(context);

    return Scaffold(
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
                child: SubMenu(1, 6),
              ),
              Container(
                width: (blockSizeHorizontal * 80),
                height: deviceHeightPercent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        NextPreButton(_skipClick, _previousClick, _nextClick),
                        Expanded(
                          child: ListView(children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                  autofocus: true,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      labelText: 'Search by ICD-10 Code..',
                                      border: OutlineInputBorder())),
                              suggestionsCallback: (pattern) async {
                                return await bloc
                                    .getMedicalHistoryPredicatelist(pattern);
                              },
                              itemBuilder: (context, suggestion) {
                                var medicalHistoryPredicate =
                                    suggestion as MedicalHistoryPredicate;
                                return ListTile(
                                  title: Text(medicalHistoryPredicate.code +
                                      '-' +
                                      medicalHistoryPredicate.description),
                                );
                              },
                              onSuggestionSelected: (suggestion) {
                                var medicalHistoryPredicate =
                                    suggestion as MedicalHistoryPredicate;
                                setState(() {
                                  _medicalHistoryPredicateList
                                      .add(medicalHistoryPredicate);
                                });
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                child: (!_medicalHistoryPredicateList.isEmpty &&
                                        _medicalHistoryPredicateList.length > 0)
                                    ? CommonText('ICD-10', false)
                                    : null),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: (!_medicalHistoryPredicateList.isEmpty &&
                                      _medicalHistoryPredicateList.length > 0)
                                  ? Table(
                                      defaultColumnWidth:
                                          FixedColumnWidth(150.0),
                                      border:
                                          TableBorder.all(color: Colors.grey),
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            width: 150,
                                            alignment: Alignment.center,
                                            child: CommonText('Code', false),
                                            padding: EdgeInsets.all(8.0),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: CommonText(
                                                'Description', false),
                                            padding: EdgeInsets.all(8.0),
                                          ),
                                          Container(
                                            width: 50,
                                            alignment: Alignment.center,
                                            child: CommonText('Actions', false),
                                          )
                                        ]),
                                        ..._medicalHistoryPredicateList
                                            .map((item) {
                                          return TableRow(children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(item.code,
                                                  style: TextStyle(
                                                      fontSize: 20.0)),
                                              padding: EdgeInsets.all(8.0),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(item.description,
                                                  style: TextStyle(
                                                      fontSize: 20.0)),
                                              padding: EdgeInsets.all(8.0),
                                            ),
                                            Container(
                                              width: 50,
                                              child: IconButton(
                                                icon: Icon(Icons.delete),
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
                            CommonText('Existing Medical Diagnoses', false),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: _questions
                                          .checkboxExistingMedicalDiagnoses
                                          .map((answer) => Row(
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        (blockSizeHorizontal *
                                                            25),
                                                    child: CheckboxButtonCommon(
                                                      (bool value) {
                                                        setState(() {
                                                          answer.value = value;
                                                        });
                                                      },
                                                      answer.value,
                                                      answer.title,
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: _questions
                                          .checkboxExistingMedicalDiagnoses2
                                          .map((answer) => Row(
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        (blockSizeHorizontal *
                                                            25),
                                                    child: CheckboxButtonCommon(
                                                      (bool value) {
                                                        setState(() {
                                                          answer.value = value;
                                                        });
                                                      },
                                                      answer.value,
                                                      answer.title,
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: _questions
                                          .checkboxExistingMedicalDiagnoses3
                                          .map((answer) => Row(
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        (blockSizeHorizontal *
                                                            25),
                                                    child: CheckboxButtonCommon(
                                                      (bool value) {
                                                        setState(() {
                                                          answer.value = value;
                                                        });
                                                      },
                                                      answer.value,
                                                      answer.title,
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // CommonText('Comments', false),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Comments',
                                  border: OutlineInputBorder()),
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Previous Concerns',
                                  border: OutlineInputBorder()),
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])
          ],
        )));
  }
}
