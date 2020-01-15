import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/psychiatric_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/psychiatric_history_bloc.dart';

import 'package:provider/provider.dart';

import '../../widgets/checkbox_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'hospitalization_history.dart';
import 'surgery_history.dart';
import '../providers/social_medical_psych_questions.dart';

class PsychiatricHistoryScreen extends StatefulWidget {
  PsychiatricHistoryScreen({Key key}) : super(key: key);
  static const routeName = '/psychiatricHistory';

  @override
  _PsychiatricHistoryScreenState createState() =>
      _PsychiatricHistoryScreenState();
}

class _PsychiatricHistoryScreenState extends State<PsychiatricHistoryScreen> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    setState(() {
      _psychiatricHistoryModel.comments = _commentsController.text;
      _psychiatricHistoryModel.prevConcerns = _prevConcernsController.text;

      List<PsychiatricDiseases> _temp = [];
      _existingPsychiatricDiagnosesList.forEach((s) {
        if (s.value)
          _temp.add(PsychiatricDiseases(
            diseaseId: s.id,
          ));
      });

      _psychiatricHistoryModel.psychiatricDiseases = _temp;

      bloc.onSavePressed(_psychiatricHistoryModel);
    });
  }

  void _skipClick() {
    _pushReplacementNamed(HospitalizationHistoryScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(SurgeryHistoryScreen.routeName);
  }

  void _nextClick() {
    _saveForm();
    _pushReplacementNamed(HospitalizationHistoryScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<PsychiatricHistoryBloc>();

  List<GroupModelForCheckBoxWithId> _existingPsychiatricDiagnosesList = [];

  bool _existingPsychiatricDiagnosesLoaded = false, _updated = false;

  Widget _existingPsychiatricDiagnosesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonText(
          "Existing psychiatric diagnoses",
          false,
        ),
        StreamBuilder(
            stream: bloc.psychiatricHistoryDiseases,
            builder:
                (BuildContext context, AsyncSnapshot<List<Disease>> snapshot) {
              if (snapshot.hasData && !_existingPsychiatricDiagnosesLoaded) {
                _existingPsychiatricDiagnosesList = snapshot.data
                    .map(
                        (d) => GroupModelForCheckBoxWithId(d.name, false, d.id))
                    .toList();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _existingPsychiatricDiagnosesLoaded = true;
                  });
                });
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _existingPsychiatricDiagnosesList
                    .map((answer) => CheckboxButtonCommon(
                          (value) {
                            setState(() {
                              answer.value = value;
                            });
                          },
                          answer.value,
                          answer.title,
                        ))
                    .toList(),
              );
            }),
      ],
    );
  }

  PsychiatricHistoryModel _psychiatricHistoryModel;

  _updatePsychiatricHistory(PsychiatricHistoryModel psychiatricHistoryModel) {
    setState(() {
      _psychiatricHistoryModel = psychiatricHistoryModel;

      if (psychiatricHistoryModel.id != null &&
          psychiatricHistoryModel.id > 0) {
        psychiatricHistoryModel.psychiatricDiseases.forEach((d) {
          _existingPsychiatricDiagnosesList
              .singleWhere(
                (cb) => cb.id == d.diseaseId,
              )
              .value = true;
        });

        _commentsController.text = psychiatricHistoryModel.comments ?? "";
        _prevConcernsController.text =
            psychiatricHistoryModel.prevConcerns ?? "";
      }

      _updated = true;
    });
  }

  TextEditingController _commentsController, _prevConcernsController;

  @override
  void initState() {
    _commentsController = TextEditingController();
    _prevConcernsController = TextEditingController();

    bloc.initialize();
    super.initState();
  }

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
                  child: SubMenu(3, 6),
                ),
                Container(
                  width: (blockSizeHorizontal * 80),
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<PsychiatricHistoryModel>(
                        stream: bloc.psychiatricHistoryObservable,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && !_updated) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _updatePsychiatricHistory(snapshot.data);
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
                                      _existingPsychiatricDiagnosesWidget(),
                                      TextFormField(
                                        controller: _commentsController,
                                        decoration: InputDecoration(
                                          labelText: 'Comments',
                                        ),
                                        maxLines: 3,
                                        keyboardType: TextInputType.multiline,
                                      ),
                                      TextFormField(
                                        controller: _prevConcernsController,
                                        decoration: InputDecoration(
                                          labelText: 'Prev. concerns',
                                        ),
                                        maxLines: 3,
                                        keyboardType: TextInputType.multiline,
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

class GroupModelForCheckBoxWithId {
  String title;
  bool value;
  int id;
  GroupModelForCheckBoxWithId(this.title, this.value, this.id);
}
