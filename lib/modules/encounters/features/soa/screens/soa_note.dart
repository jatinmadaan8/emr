import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/soa/block/soa_note_block.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';

class SOANoteScreen extends StatefulWidget {
  static const routeName = '/soaNote';

  @override
  _SOANoteScreenState createState() => _SOANoteScreenState();
}

class _SOANoteScreenState extends State<SOANoteScreen> {
  var _formKey = GlobalKey<FormState>();

  final bloc = sl<SoaNoteBloc>();

  bool update = false;

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
//    TODO fontFamily: 'Roboto'
  );

  TextEditingController _serviceController = TextEditingController();
  TextEditingController _objectiveController = TextEditingController();
  TextEditingController _assessmentController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(12),
            Row(
              children: <Widget>[
                Container(
                  width: deviceWidthPercent * 20,
                  height: deviceHeightPercent,
                  child: SubMenu(1, 12),
                ),
                Container(
                  width: deviceWidthPercent * 80,
                  height: deviceHeightPercent,
                  child: StreamBuilder<Object>(
                      stream: bloc.soaNote,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !update) {
                          _serviceController.text = bloc.soaNoteData.subjective;
                          _objectiveController.text =
                              bloc.soaNoteData.objective;
                          _assessmentController.text =
                              bloc.soaNoteData.assessment;
                          _notesController.text =
                              bloc.soaNoteData.notesForPlanning;
                          update = true;
                        }

                        return Form(
                          key: _formKey,
                          child: ListView(
                            padding: EdgeInsets.all(16),
                            children: <Widget>[
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: '1. Service:',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: _serviceController,
                                onChanged: (val) =>
                                    bloc.soaNoteData.subjective = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: '2. Objective:',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: _objectiveController,
                                onChanged: (val) =>
                                    bloc.soaNoteData.objective = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: '3. Assessment:',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: _assessmentController,
                                onChanged: (val) =>
                                    bloc.soaNoteData.assessment = val,
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                style: _optionTextStyle,
                                decoration: InputDecoration(
                                  labelText: '4. Notes for planning:',
                                  contentPadding:
                                      EdgeInsets.only(top: 8, bottom: 4),
                                ),
                                controller: _notesController,
                                onChanged: (val) =>
                                    bloc.soaNoteData.notesForPlanning = val,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: bloc.addSoaNote,
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
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
