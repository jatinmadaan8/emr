import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/billing_address.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/insurance/guarantor_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/insurance/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/emergency_contact_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/health_care.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/identification.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/standards_and_scales/screen/standards_and_scales.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/immunization_registry.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/legal.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/patient_flags.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/patient_portal.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/phones.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/photo_section.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/preferred_contact_by.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/residental_address.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/screens/patient_list.dart';

import '../modules/encounters/features/bio_psycho/screens/cultural_religious_background.dart';
import '../modules/encounters/features/bio_psycho/screens/substance_use.dart';
import '../modules/encounters/features/bio_psycho/screens/blood_brone_pathogenic_Infection_risk.dart';
import '../modules/encounters/features/bio_psycho/screens/problem_check_list.dart';
import '../modules/encounters/features/bio_psycho/screens/family_and_environment.dart';
import '../modules/encounters/features/bio_psycho/screens/education_vocation.dart';
import '../modules/encounters/features/bio_psycho/screens/legal_history.dart';
import '../modules/encounters/features/bio_psycho/screens/further_evaluation_needed.dart';

import '../modules/encounters/features/general_cc/screens/chief_complaint.dart';
import '../modules/encounters/features/general_cc/screens/paint_assessment.dart';

import '../modules/encounters/features/bio_psycho/screens/support_recovery.dart';

import '../modules/encounters/features/tuberculosis/screen/tuberculosis_widget.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/values_beliefs.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/abuse_neglect.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/activity_exercise.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/coping_stress.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/nutritional_metabolic.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/perceptual.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/self_perception.dart';
import '../modules/encounters/features/health_pattern_assessment/screens/sleep_rest.dart';
import '../modules/encounters/features/social_medical_psych_hx/screens/medical_history.dart';
import '../modules/encounters/features/social_medical_psych_hx/screens/hospitalization_history.dart';
import '../modules/encounters/features/social_medical_psych_hx/screens/psychiatric_history.dart';
import '../modules/encounters/features/social_medical_psych_hx/screens/social_history.dart';
import '../modules/encounters/features/social_medical_psych_hx/screens/surgery_history.dart';

import '../modules/encounters/features/vitals/screens/vitals.dart';
import '../modules/encounters/features/soa/screens/soa_note.dart';
import '../modules/encounters/features/system_assessments/screens/neuro_sensory.dart';

import '../modules/encounters/features/system_assessments/screens/cardio_vascular.dart';
import '../modules/encounters/features/system_assessments/screens/gastrointestinal_elimination.dart';
import '../modules/encounters/features/system_assessments/screens/genitourinary.dart';
import '../modules/encounters/features/system_assessments/screens/integumentary.dart';
import '../modules/encounters/features/system_assessments/screens/musculoskeletal.dart';
import '../modules/encounters/features/system_assessments/screens/reproduction_female.dart';
import '../modules/encounters/features/system_assessments/screens/reproduction_male.dart';
import '../modules/encounters/features/system_assessments/screens/respiratory.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PatientsScreen.routeName:
        return MaterialPageRoute(builder: (_) => PatientsScreen());

      case ProblemCheckListScreen.routeName:
        return MaterialPageRoute(builder: (_) => ProblemCheckListScreen());

      case FamilyandEnvironmentScreen.routeName:
        return MaterialPageRoute(builder: (_) => FamilyandEnvironmentScreen());

      case CulturalReligiousBackgroundScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => CulturalReligiousBackgroundScreen());

      case BloodBronePathogenicInfectionRiskScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BloodBronePathogenicInfectionRiskScreen());

      case SubstanceUseScreen.routeName:
        return MaterialPageRoute(builder: (_) => SubstanceUseScreen());

      case EducationVocationScreen.routeName:
        return MaterialPageRoute(builder: (_) => EducationVocationScreen());

      case LegalHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => LegalHistoryScreen());

      case SupportRecoveryScreen.routeName:
        return MaterialPageRoute(builder: (_) => SupportRecoveryScreen());

      case FurtherEvaluationNeededScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => FurtherEvaluationNeededScreen());

      case ChiefComplaintWidget.routeName:
        return MaterialPageRoute(builder: (_) => ChiefComplaintWidget());

      case PainAssessmentWidget.routeName:
        return MaterialPageRoute(builder: (_) => PainAssessmentWidget());

      case TuberculosisScreen.routeName:
        return MaterialPageRoute(builder: (_) => TuberculosisScreen());

      case NutritionalMetabolicWidget.routeName:
        return MaterialPageRoute(builder: (_) => NutritionalMetabolicWidget());

      case ValuesBeliefsWidget.routeName:
        return MaterialPageRoute(builder: (_) => ValuesBeliefsWidget());

      case ActivityExerciseWidget.routeName:
        return MaterialPageRoute(builder: (_) => ActivityExerciseWidget());

      case PerceptualWidget.routeName:
        return MaterialPageRoute(builder: (_) => PerceptualWidget());

      case CopingStressWidget.routeName:
        return MaterialPageRoute(builder: (_) => CopingStressWidget());

      case AbuseNeglectWidget.routeName:
        return MaterialPageRoute(builder: (_) => AbuseNeglectWidget());

      case SelfPerceptionWidget.routeName:
        return MaterialPageRoute(builder: (_) => SelfPerceptionWidget());

      case SleepRestWidget.routeName:
        return MaterialPageRoute(builder: (_) => SleepRestWidget());

      case MedicalHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => MedicalHistoryScreen());

      case SurgeryHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => SurgeryHistoryScreen());

      case PsychiatricHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => PsychiatricHistoryScreen());

      case HospitalizationHistoryScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => HospitalizationHistoryScreen());

      case SocialHistoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => SocialHistoryScreen());

      case VitalsScreen.routeName:
        return MaterialPageRoute(builder: (_) => VitalsScreen());

      case NeuroSensoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => NeuroSensoryScreen());

      case CardioVascularScreen.routeName:
        return MaterialPageRoute(builder: (_) => CardioVascularScreen());

      case RespiratoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => RespiratoryScreen());

      case GastrointestinalEliminationScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => GastrointestinalEliminationScreen());

      case GenitourinaryScreen.routeName:
        return MaterialPageRoute(builder: (_) => GenitourinaryScreen());

      case IntegumentaryScreen.routeName:
        return MaterialPageRoute(builder: (_) => IntegumentaryScreen());

      case NeuroSensoryScreen.routeName:
        return MaterialPageRoute(builder: (_) => NeuroSensoryScreen());

      case MusculoskeletalScreen.routeName:
        return MaterialPageRoute(builder: (_) => MusculoskeletalScreen());

      case ReproductionMaleScreen.routeName:
        return MaterialPageRoute(builder: (_) => ReproductionMaleScreen());

      case ReproductionFemaleScreen.routeName:
        return MaterialPageRoute(builder: (_) => ReproductionFemaleScreen());

      case SOANoteScreen.routeName:
        return MaterialPageRoute(builder: (_) => SOANoteScreen());

      case IdentificationWidget.routeName:
        return MaterialPageRoute(builder: (_) => IdentificationWidget());

      case InformationWidget.routeName:
        return MaterialPageRoute(builder: (_) => InformationWidget());

      case PhotoSectionWidget.routeName:
        return MaterialPageRoute(builder: (_) => PhotoSectionWidget());

      case ResidentialAddressWidget.routeName:
        return MaterialPageRoute(builder: (_) => ResidentialAddressWidget());

      case BillingAddressWidget.routeName:
        return MaterialPageRoute(builder: (_) => BillingAddressWidget());

      case PhonesWidget.routeName:
        return MaterialPageRoute(builder: (_) => PhonesWidget());

      case PatientFlagsWidget.routeName:
        return MaterialPageRoute(builder: (_) => PatientFlagsWidget());

      case PreferredContactByWidget.routeName:
        return MaterialPageRoute(builder: (_) => PreferredContactByWidget());

      case PatientPortalWidget.routeName:
        return MaterialPageRoute(builder: (_) => PatientPortalWidget());

      case StandardsAndScalesScreen.routeName:
        return MaterialPageRoute(builder: (_) => StandardsAndScalesScreen());

      case LegalWidget.routeName:
        return MaterialPageRoute(builder: (_) => LegalWidget());

      case ImmunizationRegistryWidget.routeName:
        return MaterialPageRoute(builder: (_) => ImmunizationRegistryWidget());

      case EmergencyContactInformationWidget.routeName:
        return MaterialPageRoute(
            builder: (_) => EmergencyContactInformationWidget());

      case HealthCareWidget.routeName:
        return MaterialPageRoute(builder: (_) => HealthCareWidget());

      case PatientInformationWidget.routeName:
        return MaterialPageRoute(builder: (_) => PatientInformationWidget());

      case GuarantorInformationWidget.routeName:
        return MaterialPageRoute(builder: (_) => GuarantorInformationWidget());

      // case Routes.PATIENTS_DETAILS:
      //   if (args is Patient) {
      //     return MaterialPageRoute(builder: (_) => PatientsListPage());
      //   } else {
      //     //return error route
      //     return null;
      //   }
    }
  }
}

class PatientsListPage {}

class Routes {
  static const String ROOT = '/';
  static const String PATIENTS_LIST = '/patients_list';
  static const String PATIENTS_DETAILS = '/patients_details';
}
