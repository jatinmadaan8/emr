import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/further_evaluation_bloc.dart';
import 'package:provider/provider.dart';

import '../providers/questions.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'support_recovery.dart';

class FurtherEvaluationNeededScreen extends StatefulWidget {
  static const routeName = '/furtherEvaluationNeeded';
  @override
  _FurtherEvaluationNeededScreenState createState() =>
      _FurtherEvaluationNeededScreenState();
}

class _FurtherEvaluationNeededScreenState
    extends State<FurtherEvaluationNeededScreen> {
  final _form = GlobalKey<FormState>();
  void _skipClick() {
    // _pushReplacementNamed('');
  }

  void _previousClick() {
    _pushReplacementNamed(SupportRecoveryScreen.routeName);
  }

  void _nextClick() {
    bloc.addFurtherEvaluation();
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<FurtherEvaluationBloc>();

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

    final _questions = Provider.of<Questions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MainMenu(1),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(9, 1),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StreamBuilder<List<GenricDropDown>>(
                        stream: bloc.evaluationTypesObservable,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Form(
                              key: _form,
                              child: Column(children: [
                                NextPreButton(
                                    _skipClick, _previousClick, _nextClick),
                                ...snapshot.data
                                    .map((answer) => Row(
                                          children: <Widget>[
                                            Container(
                                              width: (deviceWidthPercent * 80) /
                                                  2.5,
                                              child: CheckboxButtonCommon(
                                                (bool value) {
                                                  setState(() {
                                                    bloc.setValueForEvaluation(
                                                        answer);
                                                  });
                                                },
                                                bloc.checkValue(answer),
                                                answer.name,
                                              ),
                                            ),
                                            CheckboxButtonCommon(
                                              (bool value) {
                                                setState(() {
                                                  bloc.setValueForRefEvaluation(
                                                      answer);
                                                });
                                              },
                                              bloc.checkRefValue(answer),
                                              'Referral Offered',
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ]),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
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
