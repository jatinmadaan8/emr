import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info_impl.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/blood_brone_pathogenic_infection_risk_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/blood_brone_pathogenic_infection_risk_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/cultural_religious_background_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/cultural_religious_background_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/family_environment.local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/family_environment.remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/further_evaluation_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/further_evaluation_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/legal_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/legal_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/problem_checklist_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/problem_checklist_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/substance_use_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/substance_use_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/support_recovery_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/support_recovery_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/cardio_vascular_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/cardio_vascular_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/gastro_intestinal_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/gastro_intestinal_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/general_cc.local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/general_cc.remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/genitourinary_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/genitourinary_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/abuse_neglect_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/abuse_neglect_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/coping_stress_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/coping_stress_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/nutrition_metabolic_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/nutrition_metabolic_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/self_perception_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/self_perception_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/sleep_rest_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/sleep_rest_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/values_beliefs_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/values_beliefs_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/hospitalization_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/hospitalization_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/integumentary_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/integumentary_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/musculoskeletal_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/musculoskeletal_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/psychiatric_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/psychiatric_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_female_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_female_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_male_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_male_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/respiratory_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/respiratory_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/soa_note_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/soa_note_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/social_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/social_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/standards_scales_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/standards_scales_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/surgery_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/surgery_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/tuberculosis_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/tuberculosis_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/blood_brone_pathogenic_Infection_risk_bloc_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/cultural_religious_background_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/education_vocation_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/family_environment_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/further_evaluation_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/legal_history_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/problem_checklist.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/substance_use_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/support_recovery_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/genitourinary.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/abuse_neglect.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/coping_stress.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/nutrition_metabolic.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/self_perception_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/sleep_rest.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/values_beliefs_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/cardio_vascular.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/gastro_intestinal.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/general_cc.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/hospitalization_history.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/integumentary.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/musculoskeletal.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/neuro_sensory.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/psychiatric_history.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/reproduction_female.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/reproduction_male.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/respiratory.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/soa_note_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/social_history.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/standards_scales_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/surgery_history.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/tuberculosis_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/blood_brone_pathogenic_Infection_risk_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/cultural_religious_background_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/education_vocation_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/family_environment_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/further_evaluation_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/legal_history_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/problem_checklist_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/substance_use_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/blocs/support_recovery_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/general_cc/block/chief_complaint.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/general_cc/block/pain_assessment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/abuse_neglect_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/coping_stress_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/nutrition_metabolic_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/self_perception_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/sleep_rest_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/values_beliefs_bloc.dart';

import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/activity_n_exercise_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/soa/block/soa_note_block.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/hospitalization_history_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/psychiatric_history_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/social_history_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/social_medical_psych_hx/block/surgery_history_block.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/standards_and_scales/bloc/standards_and_scales_bloc.dart';

import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/cardio_vascular_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/gastro_intestinal_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/genitourinary_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/integumentary_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/musculoskeletal_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/neuro_sensory_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/reproduction_female_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/reproduction_male_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/system_assessments/blocs/respiratory_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/tuberculosis/bloc/tuberculosis_block.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/insurance_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/insurance_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/patient_information_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/patient_information_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/insurance.repository.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/other_information.repository.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/patient_information.repository.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/Insurance/bloc/patient_guarantor_info_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/other_information/blocs/other_information_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/information/features/information/blocs/patient_information_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/patients_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/patients_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/repository/patient_repository.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/repository/patient_repository_impl.dart';
import 'package:practiceinsights_emr_provider/modules/patients/features/patient_list/blocs/patient_list_bloc.dart';

import '../../modules/encounters/data/repository/medical_history.repository.dart';
import '../../modules/encounters/data/data_source/medical_history_local_data_source.dart';
import '../../modules/encounters/data/data_source/medical_history_remote_data_source.dart';
import '../../modules/encounters/features/social_medical_psych_hx/block/medical_history_block.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/avn_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/activity_exercise_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/activity_exercise_local_data_source.dart';

import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/cognitive_perceptual_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/cognitive_perceptual_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/cognitive_perceptual_repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/health_pattern_assessment/blocs/Cognitive_perceptual_bloc.dart';

final sl = GetIt.instance;

void initDI() {
  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  sl.registerLazySingleton(() => HttpService());

  //Modules

  //Patients

  // Patients List
  _initPatientsListDependency();

  //Problem checklist
  _initProblemChecklistDependency();

  //FamilyEnvironment
  _initFamilyEnvironmentDependency();

  //FamilyEnvironment
  _initEducationVocationDependency();

  //FamilyEnvironment
  _initFurtherEvaluationDependency();

  //CulturalReligiousBackground
  _initCulturalReligiousBackgroundDependency();

  //CulturalReligiousBackground
  _initBloodBronePathogenicInfectionRiskDependency();

  //LegalHistory
  _initLegalHistoryDependency();

  //SupportRecovery
  _initSupportRecoveryDependency();

  //MedicalHistory
  _initMedicalHistoryDependency();

//GeneralCC
  _initGeneralCCDependency();

  // Neuro Sensory
  _initNeuroSensoryDependency();

  // CardioVascular
  _initCardioVascularDependency();

  // respiratory
  _initRespiratoryDependency();

  // gastrointestinal
  _initGastroIntestinalDependency();

  //SOA Note
  _initSOANoteDependency();

  //Tuberculosis
  _initTuberculosisDependency();

  //Health Patterns Assessment > ValuesBeliefs
  _initValuesBeliefsependency();

  _initSelfPerceptionependency();

  _initCopingStresssependency();

  // Genitourinary
  _initGenitourinaryDependency();

  // Integumentary
  _initIntegumentaryDependency();

  // MusculoSkeletal
  _initMusculoSkeletalDependency();

  // Abuse Neglect
  _initAbuseNeglectDependency();

  //Sleep Rest
  _initSleepRestDependency();

  // Nutrition Metabolic
  _initNutritionMetabolicDependency();

  // Reproduction Male
  _initReproductionMaleDependency();

// Reproduction Female
  _initReproductionFemaleDependency();

  // Patient Information
  _initPatientInformationDependency();

  // Other Information
  _initOtherInformationDependency();

  // Substance Use
  _initSubstanceUseDependency();

  // Psychiatric History
  _initPsychiatricHistoryDependency();

  // Hospitalization History
  _initHospitalizationHistoryDependency();

  // Social History
  _iniSocialHistoryDependency();
  // Standards And Scales
  _initStandardsAndScalesDependency();

  // Surgery History
  _iniSurgeryHistoryDependency();

  // Guarantor Information
  _initInsuranceDependency();
}

void _initPatientsListDependency() {
  //Bloc
  sl.registerFactory(
    () => PatientListBloc(
      patientsListRepo: sl(),
    ),
  );

  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(
      patientsRemoteDataSource: sl(),
      patientsLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PatientsRemoteDataSource>(
    () => PatientsRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<PatientsLocalDataSource>(
    () => PatientsLocalDataSourceImpl(),
  );
}

void _initProblemChecklistDependency() {
  sl.registerFactory(() => ProblemChecklistBloc(
        problemChecklistRepo: sl(),
      ));

  sl.registerLazySingleton<ProblemChecklistRepository>(
    () => ProblemChecklistRepositoryImpl(
      problemChecklistRemoteDataSource: sl(),
      problemChecklistLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ProblemChecklistRemoteDataSource>(
    () => ProblemChecklistRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<ProblemChecklistLocalDataSource>(
    () => ProblemChecklistLocalDataSourceImpl(),
  );
}

void _initFamilyEnvironmentDependency() {
  sl.registerFactory(() => FamilyEnvironmentBloc(
        familyEnvironmentRepo: sl(),
      ));

  sl.registerLazySingleton<FamilyEnvironmentRepository>(
    () => FamilyEnvironmentRepositoryImpl(
      familyEnvironmentRemoteDataSource: sl(),
      familyEnvironmentLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<FamilyEnvironmentRemoteDataSource>(
    () => FamilyEnvironmentRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<FamilyEnvironmentLocalDataSource>(
    () => FamilyEnvironmentLocalDataSourceImpl(),
  );
}

void _initFurtherEvaluationDependency() {
  sl.registerFactory(() => FurtherEvaluationBloc(
        furtherEvaluationRepo: sl(),
      ));

  sl.registerLazySingleton<FurtherEvaluationRepository>(
    () => FurtherEvaluationRepositoryImpl(
      furtherEvaluationRemoteDataSource: sl(),
      furtherEvaluationLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<FurtherEvaluationRemoteDataSource>(
    () => FurtherEvaluationRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<FurtherEvaluationLocalDataSource>(
    () => FurtherEvaluationLocalDataSourceImpl(),
  );
}

void _initEducationVocationDependency() {
  sl.registerFactory(() => EducationVocationBloc(
        educationVocationRepo: sl(),
      ));

  sl.registerLazySingleton<EducationVocationRepository>(
    () => EducationVocationRepositoryImpl(
      educationVocationRemoteDataSource: sl(),
      educationVocationLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<EducationVocationRemoteDataSource>(
    () => EducationVocationRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<EducationVocationLocalDataSource>(
    () => EducationVocationLocalDataSourceImpl(),
  );
}

void _initCulturalReligiousBackgroundDependency() {
  sl.registerFactory(() => CulturalReligiousBackgroundBloc(
        culturalReligiousBackgroundRepo: sl(),
      ));

  sl.registerLazySingleton<CulturalReligiousBackgroundRepository>(
    () => CulturalReligiousBackgroundRepositoryImpl(
      culturalReligiousBackgroundDataSource: sl(),
      culturalReligiousBackgroundLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CulturalReligiousBackgroundRemoteDataSource>(
    () => CulturalReligiousBackgroundRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<CulturalReligiousBackgroundLocalDataSource>(
    () => CulturalReligiousBackgroundLocalDataSourceImpl(),
  );
}

void _initBloodBronePathogenicInfectionRiskDependency() {
  sl.registerFactory(() => BloodBronePathogenicInfectionRiskBloc(
        bloodBronePathogenicInfectionRiskRepo: sl(),
      ));

  sl.registerLazySingleton<BloodBronePathogenicInfectionRiskRepository>(
    () => BloodBronePathogenicInfectionRiskRepositoryImpl(
      bloodBronePathogenicInfectionRiskRemoteDataSource: sl(),
      bloodBronePathogenicInfectionRiskLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<BloodBronePathogenicInfectionRiskRemoteDataSource>(
    () => BloodBronePathogenicInfectionRiskRemoteDataSourceImpl(
        httpService: sl()),
  );

  sl.registerLazySingleton<BloodBronePathogenicInfectionRiskLocalDataSource>(
    () => BloodBronePathogenicInfectionRiskLocalDataSourceImpl(),
  );
}

void _initSupportRecoveryDependency() {
  sl.registerFactory(() => SupportRecoveryBloc(
        supportRecoveryRepo: sl(),
      ));

  sl.registerLazySingleton<SupportRecoveryRepository>(
    () => SupportRecoveryRepositoryImpl(
      supportRecoveryRemoteDataSource: sl(),
      supportRecoveryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SupportRecoveryRemoteDataSource>(
    () => SupportRecoveryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SupportRecoveryLocalDataSource>(
    () => SupportRecoveryLocalDataSourceImpl(),
  );
}

void _initLegalHistoryDependency() {
  sl.registerFactory(() => LegalHistoryBloc(
        legalHistoryRepo: sl(),
      ));

  sl.registerLazySingleton<LegalHistoryRepository>(
    () => LegalHistoryRepositoryImpl(
      legalHistoryRemoteDataSource: sl(),
      legalHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<LegalHistoryRemoteDataSource>(
    () => LegalHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<LegalHistoryLocalDataSource>(
    () => LegalHistoryLocalDataSourceImpl(),
  );
}

void _initMedicalHistoryDependency() {
  sl.registerFactory(() => MedicalHistoryBloc(
        medicalHistoryRepo: sl(),
      ));

  sl.registerLazySingleton<MedicalHistoryRepository>(
    () => MedicalHistoryRepositoryImpl(
      medicalHistoryRemoteDataSource: sl(),
      medicalHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<MedicalHistoryRemoteDataSource>(
    () => MedicalHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<MedicalHistoryLocalDataSource>(
    () => MedicalHistoryLocalDataSourceImpl(),
  );
}

void _initGeneralCCDependency() {
  //Bloc
  sl.registerFactory(
    () => ChiefComplaintBloc(
      generalCCRepo: sl(),
    ),
  );
  sl.registerFactory(
    () => ActivityNExerciseBloc(
      activityNExerciseRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => CognitivePerceptualBloc(
      cogniitivePeceptualRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => PainAssessmentBloc(
      generalCCRepo: sl(),
    ),
  );

  sl.registerLazySingleton<GeneralCCRepository>(
    () => GeneralCCRepositoryImpl(
      generalCCRemoteDataSource: sl(),
      generalCCLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ActivityNExerciseRepository>(
    () => ActivityNExerciseRepositoryImpl(
      activityExerciseLocalDataSource: sl(),
      activityExerciseRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CogniitivePeceptualRepository>(
    () => CogniitivePeceptualRepositoryImpl(
      cognitivePerceptualRemoteDataSource: sl(),
      cognitivePerceptualLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GeneralCCRemoteDataSource>(
    () => GeneralCCRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<GeneralCCLocalDataSource>(
    () => GeneralCCLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ActivityNExerciseRemoteDataSource>(
    () => ActivityNExcerciseRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<ActivityNExerciseLocalDataSource>(
    () => ActivityNExerciseLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<CognitivePerceptualRemoteDataSource>(
    () => CognitivePerceptualRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<CognitivePerceptualLocalDataSource>(
    () => CognitivePerceptualLocalDataSourceImpl(),
  );
}

void _initNeuroSensoryDependency() {
  sl.registerFactory(() => NeuroSensoryBloc(
        neuroSensoryRepository: sl(),
      ));

  sl.registerLazySingleton<NeuroSensoryRepository>(
    () => NeuroSensoryRepositoryImpl(
      neuroSensoryRemoteDataSource: sl(),
      neuroSensoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<NeuroSensoryRemoteDataSource>(
    () => NeuroSensoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<NeuroSensoryLocalDataSource>(
    () => NeuroSensoryLocalDataSourceImpl(),
  );
}

void _initCardioVascularDependency() {
  sl.registerFactory(() => CardioVascularBloc(
        cardioVascularRepository: sl(),
      ));

  sl.registerLazySingleton<CardioVascularRepository>(
    () => CardioVascularRepositoryImpl(
      cardioVascularRemoteDataSource: sl(),
      cardioVascularLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CardioVascularRemoteDataSource>(
    () => CardioVascularRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<CardioVascularLocalDataSource>(
    () => CardioVascularLocalDataSourceImpl(),
  );
}

void _initRespiratoryDependency() {
  sl.registerFactory(() => RespiratoryBloc(
        respiratoryRepository: sl(),
      ));

  sl.registerLazySingleton<RespiratoryRepository>(
    () => RespiratoryRepositoryImpl(
      respiratoryRemoteDataSource: sl(),
      respiratoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<RespiratoryRemoteDataSource>(
    () => RespiratoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<RespiratoryLocalDataSource>(
    () => RespiratoryLocalDataSourceImpl(),
  );
}

void _initGastroIntestinalDependency() {
  sl.registerFactory(() => GastroIntestinalBloc(
        gastroIntestinalRepository: sl(),
      ));

  sl.registerLazySingleton<GastroIntestinalRepository>(
    () => GastroIntestinalRepositoryImpl(
      gastroIntestinalRemoteDataSource: sl(),
      gastroIntestinalLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GastroIntestinalRemoteDataSource>(
    () => GastroIntestinalRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<GastroIntestinalLocalDataSource>(
    () => GastroIntestinalLocalDataSourceImpl(),
  );
}

void _initSOANoteDependency() {
  sl.registerFactory(
    () => SoaNoteBloc(
      soaNoteRepo: sl(),
    ),
  );

  sl.registerLazySingleton<SoaNoteRepository>(
    () => SoaNoteRepositoryImpl(
      soaNoteRemoteDataSource: sl(),
      soaNoteLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SoaNoteRemoteDataSource>(
    () => SoaNoteRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SoaNoteLocalDataSource>(
    () => SoaNoteLocalDataSourceImpl(),
  );
}

void _initTuberculosisDependency() {
  sl.registerFactory(
    () => TuberculosisBloc(
      tuberculosisRepo: sl(),
    ),
  );

  sl.registerLazySingleton<TuberculosisRepository>(
    () => TuberculosisRepositoryImpl(
      tuberculosisRemoteDataSource: sl(),
      tuberculosisLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<TuberculosisRemoteDataSource>(
    () => TuberculosisRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<TuberculosisLocalDataSource>(
    () => TuberculosisLocalDataSourceImpl(),
  );
}

void _initValuesBeliefsependency() {
  sl.registerFactory(
    () => ValuesBeliefsBloc(
      valuesBeliefsRepo: sl(),
    ),
  );

  sl.registerLazySingleton<ValuesBeliefsRepository>(
    () => ValuesBeliefsRepositoryImpl(
      valuesBeliefsRemoteDataSource: sl(),
      valuesBeliefsLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ValuesBeliefsRemoteDataSource>(
    () => ValuesBeliefsRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<ValuesBeliefsLocalDataSource>(
    () => ValuesBeliefsLocalDataSourceImpl(),
  );
}

void _initSelfPerceptionependency() {
  sl.registerFactory(
    () => SelfPerceptionBloc(
      selfPerceptionRepo: sl(),
    ),
  );

  sl.registerLazySingleton<SelfPerceptionRepository>(
    () => SelfPerceptionRepositoryImpl(
      selfPerceptionRemoteDataSource: sl(),
      selfPerceptionLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SelfPerceptionRemoteDataSource>(
    () => SelfPerceptionRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SelfPerceptionLocalDataSource>(
    () => SelfPerceptionLocalDataSourceImpl(),
  );
}

void _initCopingStresssependency() {
  sl.registerFactory(
    () => CopingStressBloc(
      copingStressRepo: sl(),
    ),
  );

  sl.registerLazySingleton<CopingStressRepository>(
    () => CopingStressRepositoryImpl(
      copingStressRemoteDataSource: sl(),
      copingStressLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<CopingStressRemoteDataSource>(
    () => CopingStressRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<CopingStressLocalDataSource>(
    () => CopingStressLocalDataSourceImpl(),
  );
}

void _initGenitourinaryDependency() {
  sl.registerFactory(() => GenitourinaryBloc(
        genitourinaryRepository: sl(),
      ));

  sl.registerLazySingleton<GenitourinaryRepository>(
    () => GenitourinaryRepositoryImpl(
      genitourinaryRemoteDataSource: sl(),
      genitourinaryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<GenitourinaryRemoteDataSource>(
    () => GenitourinaryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<GenitourinaryLocalDataSource>(
    () => GenitourinaryLocalDataSourceImpl(),
  );
}

void _initIntegumentaryDependency() {
  sl.registerFactory(() => IntegumentaryBloc(
        integumentaryRepository: sl(),
      ));

  sl.registerLazySingleton<IntegumentaryRepository>(
    () => IntegumentaryRepositoryImpl(
      integumentaryRemoteDataSource: sl(),
      integumentaryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<IntegumentaryRemoteDataSource>(
    () => IntegumentaryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<IntegumentaryLocalDataSource>(
    () => IntegumentaryLocalDataSourceImpl(),
  );
}

void _initMusculoSkeletalDependency() {
  sl.registerFactory(() => MusculoSkeletalBloc(
        musculoSkeletalRepository: sl(),
      ));

  sl.registerLazySingleton<MusculoSkeletalRepository>(
    () => MusculoSkeletalRepositoryImpl(
      musculoSkeletalRemoteDataSource: sl(),
      musculoSkeletalLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<MusculoSkeletalRemoteDataSource>(
    () => MusculoSkeletalRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<MusculoSkeletalLocalDataSource>(
    () => MusculoSkeletalLocalDataSourceImpl(),
  );
}

void _initAbuseNeglectDependency() {
  sl.registerFactory(() => AbuseNeglectBloc(
        abuseNeglectRepo: sl(),
      ));

  sl.registerLazySingleton<AbuseNeglectRepository>(
    () => AbuseNeglectRepositoryImpl(
      abuseNeglectRemoteDataSource: sl(),
      abuseNeglectLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<AbuseNeglectRemoteDataSource>(
    () => AbuseNeglectRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<AbuseNeglectLocalDataSource>(
    () => AbuseNeglectLocalDataSourceImpl(),
  );
}

void _initSleepRestDependency() {
  sl.registerFactory(() => SleepRestBloc(
        sleepRestRepo: sl(),
      ));

  sl.registerLazySingleton<SleepRestRepository>(
    () => SleepRestRepositoryImpl(
      sleepRestRemoteDataSource: sl(),
      sleepRestLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SleepRestRemoteDataSource>(
    () => SleepRestRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SleepRestLocalDataSource>(
    () => SleepRestLocalDataSourceImpl(),
  );
}

void _initNutritionMetabolicDependency() {
  sl.registerFactory(() => NutritionMetabolicBloc(
        nutritionMetabolicRepo: sl(),
      ));

  sl.registerLazySingleton<NutritionMetabolicRepository>(
    () => NutritionMetabolicRepositoryImpl(
      nutritionMetabolicRemoteDataSource: sl(),
      nutritionMetabolicLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<NutritionMetabolicRemoteDataSource>(
    () => NutritionMetabolicRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<NutritionMetabolicLocalDataSource>(
    () => NutritionMetabolicLocalDataSourceImpl(),
  );
}

void _initReproductionMaleDependency() {
  sl.registerFactory(() => ReproductionMaleBloc(
        reproductionMaleRepository: sl(),
      ));

  sl.registerLazySingleton<ReproductionMaleRepository>(
    () => ReproductionMaleRepositoryImpl(
      reproductionMaleRemoteDataSource: sl(),
      reproductionMaleLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ReproductionMaleRemoteDataSource>(
    () => ReproductionMaleRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<ReproductionMaleLocalDataSource>(
    () => ReproductionMaleLocalDataSourceImpl(),
  );
}

void _initReproductionFemaleDependency() {
  sl.registerFactory(() => ReproductionFemaleBloc(
        reproductionFemaleRepository: sl(),
      ));

  sl.registerLazySingleton<ReproductionFemaleRepository>(
    () => ReproductionFemaleRepositoryImpl(
      reproductionFemaleRemoteDataSource: sl(),
      reproductionFemaleLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ReproductionFemaleRemoteDataSource>(
    () => ReproductionFemaleRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<ReproductionFemaleLocalDataSource>(
    () => ReproductionFemaleLocalDataSourceImpl(),
  );
}

void _initPatientInformationDependency() {
  sl.registerFactory(() => PatientInformationBloc(
        patientInformationRepository: sl(),
      ));

  sl.registerLazySingleton<PatientInformationRepository>(
    () => PatientInformationRepositoryImpl(
      patientInformationRemoteDataSource: sl(),
      patientInformationLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PatientInformationRemoteDataSource>(
    () => PatientInformationRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<PatientInformationLocalDataSource>(
    () => PatientInformationLocalDataSourceImpl(),
  );
}

void _initOtherInformationDependency() {
  sl.registerFactory(() => OtherInformationBloc(
        otherInformationRepository: sl(),
      ));

  sl.registerLazySingleton<OtherInformationRepository>(
    () => OtherInformationRepositoryImpl(
      otherInformationRemoteDataSource: sl(),
      otherInformationLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<OtherInformationRemoteDataSource>(
    () => OtherInformationRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<OtherInformationLocalDataSource>(
    () => OtherInformationLocalDataSourceImpl(),
  );
}

void _initSubstanceUseDependency() {
  sl.registerFactory(() => SubstanceUseBloc(
        substanceUseRepository: sl(),
      ));

  sl.registerLazySingleton<SubstanceUseRepository>(
    () => SubstanceUseRepositoryImpl(
      substanceUseRemoteDataSource: sl(),
      substanceUseLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SubstanceUseRemoteDataSource>(
    () => SubstanceUseRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SubstanceUseLocalDataSource>(
    () => SubstanceUseLocalDataSourceImpl(),
  );
}

void _initStandardsAndScalesDependency() {
  sl.registerFactory(() => StandardsAndScalesBloc(
        standardsAndScalesRepo: sl(),
      ));

  sl.registerLazySingleton<StandardsAndScalesRepository>(
    () => StandardsAndScalesRepositoryImpl(
      standardsAndScalesRemoteDataSource: sl(),
      standardsAndScalesLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<StandardsAndScalesRemoteDataSource>(
    () => StandardsAndScalesRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<StandardsAndScalesLocalDataSource>(
    () => StandardsAndScalesLocalDataSourceImpl(),
  );
}

void _initPsychiatricHistoryDependency() {
  sl.registerFactory(() => PsychiatricHistoryBloc(
        psychiatricHistoryRepository: sl(),
      ));

  sl.registerLazySingleton<PsychiatricHistoryRepository>(
    () => PsychiatricHistoryRepositoryImpl(
      psychiatricHistoryRemoteDataSource: sl(),
      psychiatricHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PsychiatricHistoryRemoteDataSource>(
    () => PsychiatricHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<PsychiatricHistoryLocalDataSource>(
    () => PsychiatricHistoryLocalDataSourceImpl(),
  );
}

void _initHospitalizationHistoryDependency() {
  sl.registerFactory(() => HospitalizationHistoryBloc(
        hospitalizationHistoryRepository: sl(),
      ));

  sl.registerLazySingleton<HospitalizationHistoryRepository>(
    () => HospitalizationHistoryRepositoryImpl(
      hospitalizationHistoryRemoteDataSource: sl(),
      hospitalizationHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<HospitalizationHistoryRemoteDataSource>(
    () => HospitalizationHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<HospitalizationHistoryLocalDataSource>(
    () => HospitalizationHistoryLocalDataSourceImpl(),
  );
}

void _iniSocialHistoryDependency() {
  sl.registerFactory(() => SocialHistoryBloc(
        socialHistoryRepository: sl(),
      ));

  sl.registerLazySingleton<SocialHistoryRepository>(
    () => SocialHistoryRepositoryImpl(
      socialHistoryRemoteDataSource: sl(),
      socialHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SocialHistoryRemoteDataSource>(
    () => SocialHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SocialHistoryLocalDataSource>(
    () => SocialHistoryLocalDataSourceImpl(),
  );
}

void _iniSurgeryHistoryDependency() {
  sl.registerFactory(() => SurgeryHistoryBloc(
        surgeryHistoryRepo: sl(),
      ));

  sl.registerLazySingleton<SurgeryHistoryRepository>(
    () => SurgeryHistoryRepositoryImpl(
      surgeryHistoryRemoteDataSource: sl(),
      surgeryHistoryLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<SurgeryHistoryRemoteDataSource>(
    () => SurgeryHistoryRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<SurgeryHistoryLocalDataSource>(
    () => SurgeryHistoryLocalDataSourceImpl(),
  );
}

void _initInsuranceDependency() {
  sl.registerFactory(() => InsuranceBloc(
        insuranceRepository: sl(),
      ));

  sl.registerLazySingleton<InsuranceRepository>(
    () => InsuranceRepositoryImpl(
      insuranceRemoteDataSource: sl(),
      insuranceLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<InsuranceRemoteDataSource>(
    () => InsuranceRemoteDataSourceImpl(httpService: sl()),
  );

  sl.registerLazySingleton<InsuranceLocalDataSource>(
    () => InsuranceLocalDataSourceImpl(),
  );
}
