import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/standards_scales/standards_scales.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/standards_and_scales/bloc/standards_and_scales_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/app_drawer.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/custom_app_bar.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/widgets/main_menu.dart';

import 'package:survey_js_core/survey_js_core.dart';

class StandardsAndScalesScreen extends StatefulWidget {
  static const routeName = '/standardsAndScales';

  @override
  _StandardsAndScalesScreenState createState() =>
      _StandardsAndScalesScreenState();
}

class _StandardsAndScalesScreenState extends State<StandardsAndScalesScreen> {
  int _selectedForm = null;

  final bloc = sl<StandardsAndScalesBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  var jsonData = {
    "pages": [
      {
        "name": "page1",
        "elements": [
          {
            "type": "matrix",
            "name": "littleinterestorpleasureindoingthings",
            "title": "PATIENT HEALTH QUESTIONNAIRE (PHQ-9)",
            "columns": [
              {"value": "notatall", "text": "Not At All - 0"},
              {"value": "severaldays", "text": "Several Days - 1"},
              {"value": "morethanhalfdays", "text": "More than half days - 2"},
              {"value": "nearlyeveryday", "text": "Nearly Every Day - 3"}
            ],
            "rows": [
              {
                "value": "littleinterest",
                "text": "1. Little interest or pleasure in doing things?"
              },
              {
                "value": "feelingdown",
                "text": "2. Feeling down, depressed, or hopeless?"
              },
              {
                "value": "troublefallingstayingasleep",
                "text":
                    "3. Trouble falling or staying asleep, or sleeping too much?"
              },
              {
                "value": "feelingtired ",
                "text": "4. Feeling tired or having little energy?"
              },
              {
                "value": "Poorappetite",
                "text": "5. Poor appetite or overeating?"
              },
              {
                "value": "feelingbad",
                "text":
                    "6.  Feeling bad about yourself or that you are a failure or have let yourself or your family down?"
              },
              {
                "value": "troubleconcentrating",
                "text":
                    "7. Trouble concentrating on things, such as reading the newspaper or watching television?"
              },
              {
                "value": "speakingsoslowly",
                "text":
                    "8. Moving or speaking so slowly that other people could have noticed. Or the opposite being so figety or restless that you have been moving around a lot more than usual?"
              },
              {
                "value": "thoughts ",
                "text":
                    "9. Thoughts that you would be better off dead, or of hurting yourself ?"
              }
            ]
          }
        ]
      }
    ]
  };
  SurveyJsonParser surveyJsonParser = SurveyJsonParser();

  dynamic response;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;
    var d = surveyJsonParser.parseSurveyJson(jsonData);

    return Scaffold(
        appBar: CustomAppBar(true),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MainMenu(9),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: <Widget>[
                  Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      width: deviceWidthPercent * 32,
                      height: deviceHeightPercent,
                      child: Column(
                        children: <Widget>[
                          StreamBuilder<List<StandardsAndScales>>(
                              stream: bloc.standardsAndScales,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text('Loading-Data');
                                }
                                return DropdownButton<int>(
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  items: snapshot.data.map(
                                      (StandardsAndScales standardsAndScales) {
                                    return new DropdownMenuItem<int>(
                                      child:
                                          new Text(standardsAndScales.formName),
                                      value: standardsAndScales.id,
                                    );
                                  }).toList(),
                                  onChanged: (int newValue) {
                                    setState(() {
                                      bloc.selectedForm = newValue;
                                      bloc.onSelectForm(newValue);
                                    });
                                  },
                                  value: bloc.selectedForm,
                                );
                              }),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: deviceWidthPercent * 13,
                                  child: Text(
                                    'Form Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: deviceWidthPercent * 13,
                                  child: Text(
                                    'Actions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]),
                          Container(
                            width: deviceWidthPercent * 30,
                            // height: 500,
                            child: StreamBuilder(
                              stream: bloc.standardsAndScalesForm,
                              builder: (context,
                                  AsyncSnapshot<List<StandardsAndScalesForm>>
                                      snapshot) {
                                child:
                                if (snapshot.connectionState ==
                                        ConnectionState.active &&
                                    !bloc.isLoading) {
                                  if (snapshot.hasError) {
                                    return Center(
                                        child: Text(snapshot.error.toString()));
                                  }
                                  if (snapshot.hasData) {
                                    List<StandardsAndScalesForm>
                                        standardsAndScalesForm = snapshot.data;
                                    if (snapshot.data.length > 0) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              standardsAndScalesForm.length,
                                          itemBuilder: (context, index) => Row(
                                                children: <Widget>[
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        Container(
                                                          width:
                                                              deviceWidthPercent *
                                                                  20,
                                                          child: Text(
                                                            standardsAndScalesForm[
                                                                    index]
                                                                .formName,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              deviceWidthPercent *
                                                                  10,
                                                          child: Row(
                                                            children: <Widget>[
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .remove_red_eye),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .delete),
                                                                onPressed:
                                                                    () {},
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ])
                                                ],
                                              ));
                                    } else {
                                      return Container(
                                        padding: EdgeInsets.all(20),
                                        child: Center(
                                            child: Text(
                                          'No-Data',
                                        )),
                                      );
                                    }
                                  }
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ],
                      )),
                  Container(
                      width: deviceWidthPercent * 60,
                      height: deviceHeightPercent,
                      child: null
                      //  new CoreForm(
                      //   form: form_send_email,
                      //   onChanged: (dynamic response) {
                      //     this.response = response;
                      //   },
                      // ),
                      ),
                ]),
              ),
            ],
          ),
        ));
  }
}
