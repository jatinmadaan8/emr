import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/reproduction_male_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/models/checkbox_data_model.dart';
import 'package:provider/provider.dart';

import '../../bio_psycho/models/group.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/checkbox_button.dart';
import '../../widgets/common_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu.dart';

import '../../widgets/sub_menu.dart';
import '../providers/system_assessments_questions.dart';

class ReproductionMaleScreen extends StatefulWidget {
  static const routeName = '/reproductionMale';

  @override
  _ReproductionMaleScreenState createState() => _ReproductionMaleScreenState();
}

class _ReproductionMaleScreenState extends State<ReproductionMaleScreen> {
  var _formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = TextStyle(
    fontSize: 18,
    color: Color(0XFF737373),
  );
  final TextStyle _optionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0XFF737373),
  );

  TextEditingController _describeController;

  final bloc = sl<ReproductionMaleBloc>();

  @override
  void initState() {
    _describeController = TextEditingController();

    bloc.initialize();

    super.initState();
  }

  bool _problemsLoaded = false, _updated = false;

  List<CheckBoxDataModel> _problemsReproductionMaleCheckBoxValues = [];

  Widget _problemsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Problems'),
        StreamBuilder<List<ReproductionMaleLookUpData>>(
            stream: bloc.reproMaleProblems,
            builder: (context,
                AsyncSnapshot<List<ReproductionMaleLookUpData>> snapshot) {
              if (snapshot.hasData && !_problemsLoaded) {
                _problemsReproductionMaleCheckBoxValues =
                    snapshot.data.map((d) {
                  return CheckBoxDataModel(d.id, d.name, false);
                }).toList();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _problemsLoaded = true;
                  });
                });
              }
              return Wrap(
                children: _problemsReproductionMaleCheckBoxValues
                    .map(
                      (CheckBoxDataModel checkBoxVal) => CheckboxButtonCommon(
                        (val) => setState(() => checkBoxVal.value = val),
                        checkBoxVal.value,
                        checkBoxVal.title,
                      ),
                    )
                    .toList(),
              );
            }),
      ],
    );
  }

  var _reproductionMale = new ReproductionMaleModel();

  void _updateReproductionMale(var data) {
    setState(() {
      _reproductionMale = data as ReproductionMaleModel;

      if (_reproductionMale.id != null) {
        _reproductionMale.reproducationmaleProblems.forEach((s) {
          _problemsReproductionMaleCheckBoxValues
              .singleWhere((c) => c.id == s.problemId)
              .value = true;
        });

        _describeController.text = _reproductionMale.comments;
      }

      _updated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidthPercent = deviceSize.width / 100;
    final deviceHeightPercent = deviceSize.height - 180;

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          MainMenu(5),
          Row(
            children: <Widget>[
              Container(
                width: deviceWidthPercent * 20,
                height: deviceHeightPercent,
                child: SubMenu(8, 5),
              ),
              Container(
                width: deviceWidthPercent * 80,
                height: deviceHeightPercent,
                child: StreamBuilder<ReproductionMaleModel>(
                    stream: bloc.reproductionMaleObservable,
                    builder: (context,
                        AsyncSnapshot<ReproductionMaleModel> snapshot) {
                      if (snapshot.hasData && !_updated) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateReproductionMale(snapshot.data);
                        });
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(16),
                          children: <Widget>[
                            CommonText("Any problems ?", false),
                            SizedBox(height: 12),
                            _problemsWidget(),
                            SizedBox(height: 8),
                            TextFormField(
                              style: _optionTextStyle,
                              controller: _describeController,
                              onChanged: (txt) => setState(
                                  () => _reproductionMale.comments = txt),
                              decoration: InputDecoration(
                                labelText: 'Describe',
                                contentPadding:
                                    EdgeInsets.only(top: 8, bottom: 4),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      List<ReproducationmaleProblems> _temp =
                                          [];
                                      _problemsReproductionMaleCheckBoxValues
                                          .forEach((s) {
                                        if (s.value)
                                          _temp.add(ReproducationmaleProblems(
                                              problemId: s.id));
                                      });

                                      _reproductionMale
                                          .reproducationmaleProblems = _temp;

                                      bloc.onSavePressed(_reproductionMale);
                                    },
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
                                    onPressed: () => print('Pressed Save'),
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
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
