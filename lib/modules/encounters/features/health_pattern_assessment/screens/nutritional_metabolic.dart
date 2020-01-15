import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/nutrition_metabolic_bloc.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/sub_menu.dart';

class NutritionalMetabolicWidget extends StatefulWidget {
  static const routeName = '/nutritionalMetabolic';

  @override
  _NutritionalMetabolicWidgetState createState() =>
      _NutritionalMetabolicWidgetState();
}

class _NutritionalMetabolicWidgetState
    extends State<NutritionalMetabolicWidget> {
  final bloc = sl<NutritionMetabolicBloc>();
  var _formKey = GlobalKey<FormState>();

  double optionSize = 148;
  final activecolor = Color.fromRGBO(45, 133, 185, 1);
  final textFontStyle = new TextStyle(fontSize: 14.0);
  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );

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
      body: Column(
        children: <Widget>[
          MainMenu(8),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(8, 8),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: StreamBuilder<List<GenricQuestions>>(
                          stream: bloc.nomQuestionsObservable,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text('No Data'),
                              );
                            }

                            if (snapshot.hasData) {
                              return Column(
                                children: <Widget>[
                                  Column(
                                    children: snapshot.data
                                        .map(
                                          (question) =>
                                              question.parentQuestionId == null
                                                  ? Container(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          CommonText(
                                                              question
                                                                  .description,
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
                                                                    groupValue:
                                                                        bloc.checkAwnser(
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
                                                                    activeColor:
                                                                        activecolor,
                                                                  ),
                                                                  Text(
                                                                    'Yes',
                                                                    style:
                                                                        textFontStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Radio(
                                                                    groupValue:
                                                                        bloc.checkAwnser(
                                                                            question),
                                                                    value:
                                                                        false,
                                                                    onChanged:
                                                                        (val) {
                                                                      bloc.changeQuestion(
                                                                          question,
                                                                          val);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    activeColor:
                                                                        activecolor,
                                                                  ),
                                                                  Text(
                                                                    'No',
                                                                    style:
                                                                        textFontStyle,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              ((question.id == 1 ||
                                                                              question.id ==
                                                                                  2) &&
                                                                          bloc.checkAwnser(question) ==
                                                                              null
                                                                      ? false
                                                                      : (question.id == 1 ||
                                                                              question.id ==
                                                                                  2) &&
                                                                          bloc.checkAwnser(
                                                                              question))
                                                                  ? Container(
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          TextFormField(
                                                                        decoration:
                                                                            InputDecoration(
                                                                          labelText:
                                                                              'Description *',
                                                                          contentPadding: EdgeInsets.only(
                                                                              top: 8,
                                                                              bottom: 4),
                                                                        ),
                                                                        initialValue:
                                                                            bloc.checkQuestionDescription(question),
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
                                                    )
                                                  : Container(
                                                      child: bloc.showChildQuestion(
                                                              question
                                                                  .parentQuestionId)
                                                          ? Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                CommonText(
                                                                    question
                                                                        .description,
                                                                    false),
                                                                SizedBox(
                                                                    height: 4),
                                                                Row(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Radio(
                                                                          groupValue:
                                                                              bloc.checkAwnser(question),
                                                                          value:
                                                                              true,
                                                                          onChanged:
                                                                              (val) {
                                                                            bloc.changeQuestion(question,
                                                                                val);
                                                                            setState(() {});
                                                                          },
                                                                          activeColor:
                                                                              activecolor,
                                                                        ),
                                                                        Text(
                                                                          'Yes',
                                                                          style:
                                                                              textFontStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Radio(
                                                                          groupValue:
                                                                              bloc.checkAwnser(question),
                                                                          value:
                                                                              false,
                                                                          onChanged:
                                                                              (val) {
                                                                            bloc.changeQuestion(question,
                                                                                val);
                                                                            setState(() {});
                                                                          },
                                                                          activeColor:
                                                                              activecolor,
                                                                        ),
                                                                        Text(
                                                                          'No',
                                                                          style:
                                                                              textFontStyle,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                          : Container(),
                                                    ),
                                        )
                                        .toList(),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CommonText('Dietician referral', false),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: bloc.nOrMDieticianReferral
                                              .map((answer) =>
                                                  RadioButtonCommon((val) {
                                                    bloc.nutritionMetabolicData
                                                            .dieticianReferralId =
                                                        val;
                                                    setState(() {});
                                                  },
                                                      bloc.nutritionMetabolicData
                                                          .dieticianReferralId,
                                                      answer.name,
                                                      answer.id))
                                              .toList(),
                                        ),
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
                                            onPressed:
                                                bloc.addNutritionMetabolic,
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
                                            onPressed: () => {},
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
                              );
                            }
                          }),
                    ),
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
