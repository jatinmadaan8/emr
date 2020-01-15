import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';
import '../../../../../modules/encounters/data/models/bio_psycho/problem_checklist.dart';
import '../../../../../app/di/injection_container.dart';
import '../../../../../modules/encounters/features/bio_psycho/blocs/problem_checklist_bloc.dart';

import '../../widgets/sub_menu.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'family_and_environment.dart';

class ProblemCheckListScreen extends StatefulWidget {
  static const routeName = '/problemCheckList';

  @override
  _ProblemCheckListScreenState createState() => _ProblemCheckListScreenState();
}

class _ProblemCheckListScreenState extends State<ProblemCheckListScreen> {
  final bloc = sl<ProblemChecklistBloc>();
  var _form = GlobalKey<FormState>();
  bool _viewLoaded = false;
  List<TextEditingController> _controllers = new List();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  void _skipClick() {
    _pushReplacementNamed(FamilyandEnvironmentScreen.routeName);
  }

  void _previousClick() {}

  void _nextClick() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    // bloc.savecheckList();
    bloc.savecheckList();
    _pushReplacementNamed(FamilyandEnvironmentScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
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
    final deviceHeightPercent = deviceSize.height - 200;

    final Patient args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: StreamBuilder<Object>(
          stream: bloc.problemChecklistObservable,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _viewLoaded = true;
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  MainMenu(1),
                  Row(
                    children: <Widget>[
                      Container(
                        width: deviceWidthPercent * 20,
                        height: deviceHeightPercent,
                        child: SubMenu(1, 1),
                      ),
                      Container(
                        width: deviceWidthPercent * 80,
                        height: deviceHeightPercent,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                              key: _form,
                              child: bloc.problemChecklistData != null
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          NextPreButton(_skipClick,
                                              _previousClick, _nextClick),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  CommonText(
                                                      "1. Pain Management Concerns",
                                                      false),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    value: bloc
                                                        .problemChecklistData
                                                        .havePainConcerns,
                                                    onChanged: (value) => bloc
                                                        .updatePainManagement(),
                                                    activeColor: Color.fromRGBO(
                                                        45, 133, 185, 1),
                                                  ),
                                                  CommonText(
                                                      "None Reported", false),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  CommonText(
                                                      "2. Psychosocial Stressors",
                                                      false),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    value: bloc
                                                        .psychoSocialStressorsCB,
                                                    onChanged: (val) => bloc
                                                        .updatePsychoSocialStressorsCB(),
                                                    activeColor: Color.fromRGBO(
                                                        45, 133, 185, 1),
                                                  ),
                                                  CommonText(
                                                      "None Reported", false),
                                                ],
                                              ),
                                            ],
                                          ),
                                          bloc.psychoSocialStressorsCB
                                              ? Container()
                                              : _psychosocialCheckboxList(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  CommonText(
                                                      "3. Current Physical Health Issue",
                                                      false),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Checkbox(
                                                    value: bloc
                                                        .problemChecklistData
                                                        .haveCurrentHealthIssues,
                                                    onChanged: (value) => bloc
                                                        .updateCurrentHealth(),
                                                    activeColor: Color.fromRGBO(
                                                        45, 133, 185, 1),
                                                  ),
                                                  CommonText(
                                                      "None Reported", false),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // Row(
                                          //   children: <Widget>[
                                          //     Expanded(
                                          //       child: MaterialButton(
                                          //         onPressed: bloc.savecheckList,
                                          //         child: Row(
                                          //           mainAxisAlignment:
                                          //               MainAxisAlignment
                                          //                   .center,
                                          //           children: <Widget>[
                                          //             Icon(
                                          //               Icons.check,
                                          //               size: 24,
                                          //               color: Colors.white,
                                          //             ),
                                          //             SizedBox(width: 8),
                                          //             Text(
                                          //               'Save',
                                          //               style:
                                          //                   _textStyle.copyWith(
                                          //                       color: Colors
                                          //                           .white),
                                          //             ),
                                          //           ],
                                          //         ),
                                          //         color: Color(0XFF048ABF),
                                          //       ),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    )
                                  : Container()),
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

  Widget _psychosocialCheckboxList() {
    return StreamBuilder<List<PsychostressDisplay>>(
        stream: bloc.psychosocialStressorsDisplayObservable,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return Column(
            children: snapshot.data.map((answer) {
              TextEditingController editingController =
                  new TextEditingController();
              editingController.text = answer.description;
              _controllers.add(editingController);

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 320,
                        child: CheckboxButtonCommon(
                          (value) => bloc.updatePsychosocialStressorReported(
                              value, answer.id),
                          answer.reported,
                          answer.name,
                        ),
                      ),
                      Container(
                        width: 300,
                        child: answer.reported
                            ? TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'description *',
                                ),
                                controller: editingController,
                                onChanged: (value) =>
                                    bloc.updatePsychosocialStressorDesc(
                                        value, answer.id),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'description required';
                                  }
                                  return null;
                                },
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        });
  }
}
