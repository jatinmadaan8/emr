import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practiceinsights_emr_provider/app/routes.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/providers/system_assessments_questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/vitals/providers/vitals_questions.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/providers/information_questions.dart';
import 'package:practiceinsights_emr_provider/modules/login/ui/ui/login_page.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/screens/patient_list.dart';
import 'package:provider/provider.dart';

import '../modules/encounters/features/bio_psycho/providers/questions.dart';
import '../modules/encounters/features/general_cc/providers/general_cc_questions.dart';
import '../modules/encounters/features/health_pattern_assessment/providers/health_pattern_assessment_questions.dart';
import '../modules/encounters/features/social_medical_psych_hx/providers/social_medical_psych_questions.dart';
import '../modules/encounters/features/tuberculosis/provider/tuberculosis_questions.dart';

class App extends StatelessWidget {
  static Map<int, Color> color = {
    50: Color.fromRGBO(4, 138, 191, .1),
    100: Color.fromRGBO(4, 138, 191, .2),
    200: Color.fromRGBO(4, 138, 191, .3),
    300: Color.fromRGBO(4, 138, 191, .4),
    400: Color.fromRGBO(4, 138, 191, .5),
    500: Color.fromRGBO(4, 138, 191, .6),
    600: Color.fromRGBO(4, 138, 191, .7),
    700: Color.fromRGBO(4, 138, 191, .8),
    800: Color.fromRGBO(4, 138, 191, .9),
    900: Color.fromRGBO(4, 138, 191, 1),
  };

  MaterialColor colorCustom =
      MaterialColor(Color.fromRGBO(4, 138, 191, 1).hashCode, color);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Questions(),
          ),
          ChangeNotifierProvider.value(
            value: TuberculosisQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: HealthPatternAssessmentQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: GeneralCCQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: SocialMedicalPsychQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: SystemAssessmentsQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: VitalsQuestions(),
          ),
          ChangeNotifierProvider.value(
            value: InformationQuestions(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: colorCustom,
            textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: Colors.grey[600],
                ),
          ),
          home: LoginPage(), //PatientsScreen(),
          //  initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
