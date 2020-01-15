import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/tuberculosis/bloc/tuberculosis_block.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/next_prev_button.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';

class TuberculosisScreen extends StatefulWidget {
  static const routeName = '/tuberculosis';

  @override
  _TuberculosisScreenState createState() => _TuberculosisScreenState();
}

class _TuberculosisScreenState extends State<TuberculosisScreen> {
  var _formKey = GlobalKey<FormState>();

  int tbSknTestRadioValue = 0;
  int chestXrayRadioValue = 0;
  int coughRadioValue = 0;
  int sputumRadioValue = 0;
  int feverChillsRadioValue = 0;
  int lostRadioValue = 0;
  int riskIndicatedRadioValue = 0;
  int odhRadioValue = 0;

  void _skipClick() {}

  void _previousClick() {}

  void _nextClick() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    bloc.addTuberculosis();
    // _pushReplacementNamed(FamilyandEnvironmentScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  final bloc = sl<TuberculosisBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 130;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(3),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(1, 3),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            NextPreButton(
                                _skipClick, _previousClick, _nextClick),
                            StreamBuilder<List<GenricQuestions>>(
                                stream: bloc.nvTbQuestionsObservable,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text('Nodata');
                                  }

                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data
                                            .map((question) => Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      CommonText(
                                                          question.description,
                                                          false),
                                                      SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Radio(
                                                                groupValue: bloc
                                                                    .checkAwnser(
                                                                        question),
                                                                value: true,
                                                                onChanged:
                                                                    (val) {
                                                                  bloc.changeQuestion(
                                                                      question,
                                                                      val);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                activeColor: Color
                                                                    .fromRGBO(
                                                                        45,
                                                                        133,
                                                                        185,
                                                                        1),
                                                              ),
                                                              Text(
                                                                'Yes',
                                                                style: new TextStyle(
                                                                    fontSize:
                                                                        14.0),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Radio(
                                                                groupValue: bloc
                                                                    .checkAwnser(
                                                                        question),
                                                                value: false,
                                                                onChanged:
                                                                    (val) {
                                                                  bloc.changeQuestion(
                                                                      question,
                                                                      val);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                activeColor: Color
                                                                    .fromRGBO(
                                                                        45,
                                                                        133,
                                                                        185,
                                                                        1),
                                                              ),
                                                              Text(
                                                                'No',
                                                                style: new TextStyle(
                                                                    fontSize:
                                                                        14.0),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          ((question.id == 1 ||
                                                                          question.id ==
                                                                              2) &&
                                                                      bloc.checkAwnser(
                                                                              question) ==
                                                                          null
                                                                  ? false
                                                                  : (question.id ==
                                                                              1 ||
                                                                          question.id ==
                                                                              2) &&
                                                                      bloc.checkAwnser(
                                                                          question))
                                                              ? Container(
                                                                  width: 200,
                                                                  child:
                                                                      TextFormField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Description *',
                                                                      contentPadding: EdgeInsets.only(
                                                                          top:
                                                                              8,
                                                                          bottom:
                                                                              4),
                                                                    ),
                                                                    initialValue:
                                                                        bloc.checkQuestionDescription(
                                                                            question),
                                                                    onChanged:
                                                                        (val) {
                                                                      bloc.changeQuestionDescription(
                                                                          question,
                                                                          val);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    validator:
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Description is Required';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ))
                                                              : SizedBox
                                                                  .shrink(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList());
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
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
