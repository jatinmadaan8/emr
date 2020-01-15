import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/app/di/injection_container.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/blood_brone_pathogenic_infection_risk.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/blood_brone_pathogenic_Infection_risk_bloc.dart';

import 'package:provider/provider.dart';

import '../providers/questions.dart';
import '../../widgets/radio_button.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/common_text.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/main_menu.dart';
import '../../widgets/sub_menu.dart';
import '../../widgets/next_prev_button.dart';
import 'cultural_religious_background.dart';
import 'substance_use.dart';

class BloodBronePathogenicInfectionRiskScreen extends StatefulWidget {
  BloodBronePathogenicInfectionRiskScreen({Key key}) : super(key: key);
  static const routeName = '/bloodBronePathogenicInfectionRisk';
  @override
  _BloodBronePathogenicInfectionRiskScreenState createState() =>
      _BloodBronePathogenicInfectionRiskScreenState();
}

class _BloodBronePathogenicInfectionRiskScreenState
    extends State<BloodBronePathogenicInfectionRiskScreen> {
  final _form = GlobalKey<FormState>();
  int _infection = -1;
  void _saveForm() {}

  void _infectionFun(val) {
    setState(() => bloc.culturalReligiousBackgroundData.isStdVulnerable = val);
  }

  void _skipClick() {
    _pushReplacementNamed(SubstanceUseScreen.routeName);
  }

  void _previousClick() {
    _pushReplacementNamed(CulturalReligiousBackgroundScreen.routeName);
  }

  void _nextClick() async {
    bloc.addBloodBronePathogenicInfectionRisk();
    _pushReplacementNamed(SubstanceUseScreen.routeName);
  }

  void _pushReplacementNamed(String name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  final bloc = sl<BloodBronePathogenicInfectionRiskBloc>();

  @override
  void initState() {
    bloc.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = deviceSize.width;
    final blockSizeHorizontal = deviceWidth / 100;
    final deviceHeightPercent = deviceSize.height - 200;

    final _questions = Provider.of<Questions>(context);

    return Scaffold(
      appBar: CustomAppBar(true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MainMenu(1),
            Row(
              children: <Widget>[
                Container(
                  width: (blockSizeHorizontal * 20),
                  height: deviceHeightPercent,
                  child: SubMenu(4, 1),
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
                            child: ListView(
                              children: <Widget>[
                                CommonText(
                                  "1. Are you at risk for HIV?HEPC infection due to unsafe/unprotected sexual practices, blood transfusions IV drug use and/or work-related exposure?",
                                  false,
                                ),
                                StreamBuilder<
                                        BloodBronePathogenicInfectionRisk>(
                                    stream: bloc.culturalReligiousBackground,
                                    builder: (context, snapshot) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: _questions.noYesbool
                                            .map((answer) => RadioButtonCommon(
                                                _infectionFun,
                                                bloc.culturalReligiousBackgroundData
                                                    .isStdVulnerable,
                                                answer.text,
                                                answer.index))
                                            .toList(),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ],
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
