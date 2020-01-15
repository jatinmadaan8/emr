import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/soa/screens/soa_note.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/billing_address.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/insurance/guarantor_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/insurance/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/emergency_contact_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/health_care.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/identification.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/immunization_registry.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/information.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/screens/legal.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/patient_flags.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/patient_portal.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/phones.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/photo_section.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/preferred_contact_by.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/screens/residental_address.dart';

import '../bio_psycho/models/menuitem.dart';
import '../bio_psycho/screens/cultural_religious_background.dart';
import '../bio_psycho/screens/substance_use.dart';
import '../bio_psycho/screens/blood_brone_pathogenic_Infection_risk.dart';
import '../bio_psycho/screens/problem_check_list.dart';
import '../bio_psycho/screens/family_and_environment.dart';
import '../bio_psycho/screens/education_vocation.dart';
import '../bio_psycho/screens/legal_history.dart';
import '../bio_psycho/screens/support_recovery.dart';
import '../bio_psycho/screens/further_evaluation_needed.dart';

import '../general_cc/screens/chief_complaint.dart';
import '../general_cc/screens/paint_assessment.dart';
import '../health_pattern_assessment/screens/abuse_neglect.dart';
import '../health_pattern_assessment/screens/activity_exercise.dart';
import '../health_pattern_assessment/screens/coping_stress.dart';
import '../health_pattern_assessment/screens/nutritional_metabolic.dart';
import '../health_pattern_assessment/screens/perceptual.dart';
import '../health_pattern_assessment/screens/self_perception.dart';
import '../health_pattern_assessment/screens/sleep_rest.dart';
import '../health_pattern_assessment/screens/values_beliefs.dart';
import '../tuberculosis/screen/tuberculosis_widget.dart';

import '../social_medical_psych_hx/screens/psychiatric_history.dart';
import '../social_medical_psych_hx/screens/hospitalization_history.dart';
import '../social_medical_psych_hx/screens/social_history.dart';
import '../social_medical_psych_hx/screens/medical_history.dart';
import '../../../../modules/encounters/features/social_medical_psych_hx/screens/surgery_history.dart';

import '../../../../modules/encounters/features/system_assessments/screens/cardio_vascular.dart';
import '../../../../modules/encounters/features/system_assessments/screens/gastrointestinal_elimination.dart';
import '../../../../modules/encounters/features/system_assessments/screens/genitourinary.dart';
import '../../../../modules/encounters/features/system_assessments/screens/integumentary.dart';
import '../../../../modules/encounters/features/system_assessments/screens/musculoskeletal.dart';
import '../../../../modules/encounters/features/system_assessments/screens/neuro_sensory.dart';
import '../../../../modules/encounters/features/system_assessments/screens/reproduction_female.dart';
import '../../../../modules/encounters/features/system_assessments/screens/reproduction_male.dart';
import '../../../../modules/encounters/features/system_assessments/screens/respiratory.dart';

import '../../../../modules/encounters/features/vitals/screens/vitals.dart';

class SubMenu extends StatelessWidget {
  final int index;
  final int mainMenuIndex;
  final bool demographics;
  List<MenuItem> _menuItems = [];
  String title = '';
  SubMenu(@required this.index, @required this.mainMenuIndex,
      {this.demographics = false});

  @override
  Widget build(BuildContext context) {
    setMenu(mainMenuIndex);

    _menuItems[index - 1].selected = true;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
        ..._menuItems.map((menu) {
          return Container(
            height: 40,
            decoration: BoxDecoration(
              color: menu.selected
                  ? Color.fromRGBO(246, 246, 246, 1)
                  : Color.fromRGBO(255, 255, 255, 1),
            ),
            child: FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      menu.name,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                  )
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(menu.route);
              },
            ),
          );
        }).toList()
      ],
    );
  }

  setMenu(val) {
    if (demographics) {
      switch (val) {
        case 1:
          {
            title = "Information";
            _menuItems = [
              new MenuItem(
                  'Identification', IdentificationWidget.routeName, false),
              new MenuItem('Information', InformationWidget.routeName, false),
              new MenuItem('Photo', PhotoSectionWidget.routeName, false),
              new MenuItem('Residental Address',
                  ResidentialAddressWidget.routeName, false),
              new MenuItem(
                  'Billing Address', BillingAddressWidget.routeName, false),
              new MenuItem('Phones', PhonesWidget.routeName, false),
              new MenuItem(
                  'Patient Flags', PatientFlagsWidget.routeName, false),
              new MenuItem('Preferred Contact By',
                  PreferredContactByWidget.routeName, false),
              new MenuItem(
                  'Patient Portal', PatientPortalWidget.routeName, false),
            ];
            return;
          }
        case 2:
          {
            title = "Insurance";
            _menuItems = [
              new MenuItem('Patient Information',
                  PatientInformationWidget.routeName, false),
              new MenuItem('Guarantor Information',
                  GuarantorInformationWidget.routeName, false),
            ];
            return;
          }
        case 3:
          {
            title = "Other Information";
            _menuItems = [
              new MenuItem('Legal', LegalWidget.routeName, false),
              new MenuItem('Immunization Registry',
                  ImmunizationRegistryWidget.routeName, false),
              new MenuItem('Emergency Contact Information',
                  EmergencyContactInformationWidget.routeName, false),
              new MenuItem('Health Care', HealthCareWidget.routeName, false),
            ];
            return;
          }
        case 4:
          {
            title = "Care Team";
            _menuItems = [];
            return;
          }
        default:
          {
            _menuItems = [
              new MenuItem(
                  'Identification', IdentificationWidget.routeName, false),
            ];
            return;
          }
      }
    } else {
      switch (val) {
        case 1:
          {
            title = 'Bio Psycho Form';
            _menuItems = [
              new MenuItem('Problem Check List',
                  ProblemCheckListScreen.routeName, false),
              new MenuItem('Family and Environment',
                  FamilyandEnvironmentScreen.routeName, false),
              new MenuItem('Cultural and Religious Background',
                  CulturalReligiousBackgroundScreen.routeName, false),
              new MenuItem('Blood borne Pathogenic infection Risk',
                  BloodBronePathogenicInfectionRiskScreen.routeName, false),
              new MenuItem(
                  'Substance Use', SubstanceUseScreen.routeName, false),
              new MenuItem('Education/Vocation',
                  EducationVocationScreen.routeName, false),
              new MenuItem(
                  'Legal History', LegalHistoryScreen.routeName, false),
              new MenuItem(
                  'Support Recovery', SupportRecoveryScreen.routeName, false),
              new MenuItem('Further Evaluation Needed',
                  FurtherEvaluationNeededScreen.routeName, false),
            ];
            return;
          }
        case 2:
          {
            title = 'General/CC';
            _menuItems = [
              new MenuItem(
                  'Chief Complaint', ChiefComplaintWidget.routeName, false),
              new MenuItem(
                  'Pain Assessment', PainAssessmentWidget.routeName, false),
            ];
            return;
          }
        case 3:
          {
            title = 'Tuberculosis';
            _menuItems = [
              new MenuItem(
                  'Tuberculosis Screen', TuberculosisScreen.routeName, false),
            ];
            return;
          }
        case 4:
          {
            title = 'Vitals';
            _menuItems = [
              new MenuItem('Vitals', VitalsScreen.routeName, false),
            ];
            return;
          }
        case 5:
          {
            title = 'Systems Assessment';
            _menuItems = [
              new MenuItem(
                  'Neuro Sensory', NeuroSensoryScreen.routeName, false),
              new MenuItem(
                  'Cardio Vascular', CardioVascularScreen.routeName, false),
              new MenuItem('Respiratory', RespiratoryScreen.routeName, false),
              new MenuItem('Gastrointestinal/Elimination',
                  GastrointestinalEliminationScreen.routeName, false),
              new MenuItem(
                  'Genitourinary', GenitourinaryScreen.routeName, false),
              new MenuItem(
                  'Integumentary', IntegumentaryScreen.routeName, false),
              new MenuItem(
                  'Musculoskeletal', MusculoskeletalScreen.routeName, false),
              new MenuItem('Reproduction - Male',
                  ReproductionMaleScreen.routeName, false),
              new MenuItem('Reproduction - Female',
                  ReproductionFemaleScreen.routeName, false),
            ];
            return;
          }
        case 6:
          {
            title = 'Social/Medical/Psych Hx';
            _menuItems = [
              new MenuItem(
                  'Medical History', MedicalHistoryScreen.routeName, false),
              new MenuItem(
                  'Surgery History', SurgeryHistoryScreen.routeName, false),
              new MenuItem('Psychiatric History',
                  PsychiatricHistoryScreen.routeName, false),
              new MenuItem('Hospitalization History',
                  HospitalizationHistoryScreen.routeName, false),
              new MenuItem(
                  'Social History', SocialHistoryScreen.routeName, false),
            ];
            return;
          }
        case 8:
          {
            title = 'Health Patterns Assessment';
            _menuItems = [
              new MenuItem(
                  'Values & Beliefs', ValuesBeliefsWidget.routeName, false),
              new MenuItem('Activity & Exercise',
                  ActivityExerciseWidget.routeName, false),
              new MenuItem(
                  'Cognitive/Perceptual', PerceptualWidget.routeName, false),
              new MenuItem(
                  'Coping/Stress', CopingStressWidget.routeName, false),
              new MenuItem(
                  'Abuse/Neglect', AbuseNeglectWidget.routeName, false),
              new MenuItem(
                  'Self Perception', SelfPerceptionWidget.routeName, false),
              new MenuItem('Sleep/Rest', SleepRestWidget.routeName, false),
              new MenuItem('Nutrition/Metabolic',
                  NutritionalMetabolicWidget.routeName, false),
            ];
            return;
          }
        case 12:
          {
            title = 'SOA';
            _menuItems = [
              new MenuItem('SOA note', SOANoteScreen.routeName, false),
            ];
            return;
          }
        default:
          {
            _menuItems = [
              new MenuItem(
                  'Problem Check List', ProblemCheckListScreen.routeName, false)
            ];
            return;
          }
      }
    }
  }
}
