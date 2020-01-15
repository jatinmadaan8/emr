import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class SocialMedicalPsychQuestions with ChangeNotifier {
  List<GroupModelForCheckBox> _existingPsychiatricDiagnosesList = [
    GroupModelForCheckBox('Anxiety', false),
    GroupModelForCheckBox('Bipolar', false),
    GroupModelForCheckBox('Depression', false),
    GroupModelForCheckBox('Eating', false),
  ];

  List<GroupModel> _noYes = [
    GroupModel("No", 0),
    GroupModel("Yes", 1),
  ];

  List<GroupModel> _coitusAge = [
    GroupModel("< 18<", 0),
    GroupModel("18 and Over", 1),
  ];

  List<GroupModel> _sexualPartners = [
    GroupModel("< 3 or Less<", 0),
    GroupModel("4 or more", 1),
  ];

  List<GroupModel> _sexualActivity = [
    GroupModel("Inactive", 0),
    GroupModel("Never", 1),
    GroupModel("Males", 2),
    GroupModel("Females", 3),
    GroupModel("Both", 4),
  ];

  List<GroupModel> _maritalStatus = [
    GroupModel("Married", 0),
    GroupModel("Divorced", 1),
    GroupModel("Single", 2),
    GroupModel("Widow", 3),
    GroupModel("Unknown", 4),
  ];

  List<GroupModel> _smokingStatus = [
    GroupModel("Current Everyday Smoker", 0),
    GroupModel("Current Some day Smoker", 1),
    GroupModel("Former Smoker", 2),
    GroupModel("Never Smoker", 3),
    GroupModel("Smoker, Status Unknown", 4),
    GroupModel("Heavy tobacco smoker", 5),
    GroupModel("Light tobacco smoker", 6),
    GroupModel("Unknown if ever smoked", 7),
  ];

  List<GroupModelForCheckBox> _abuseList = [
    GroupModelForCheckBox('Substance Abuse', false),
    GroupModelForCheckBox('Seatbelt use', false),
    GroupModelForCheckBox('Physical/Sexual Abuse', false),
  ];

  List<GroupModelForEvaluationCheckBox> _checkboxExistingMedicalDiagnoses = [
    GroupModelForEvaluationCheckBox('Diabetes', false, false),
    GroupModelForEvaluationCheckBox('Obesity', false, false),
    GroupModelForEvaluationCheckBox('Hypertension', false, false),
    GroupModelForEvaluationCheckBox('COPD', false, false),
    GroupModelForEvaluationCheckBox('CHF', false, false),
    GroupModelForEvaluationCheckBox("Alzheimer's", false, false),
    GroupModelForEvaluationCheckBox('Cancer', false, false),
  ];

  List<GroupModelForEvaluationCheckBox> _checkboxExistingMedicalDiagnoses2 = [
    GroupModelForEvaluationCheckBox('Arthritis', false, false),
    GroupModelForEvaluationCheckBox('Hyperlipidemia', false, false),
    GroupModelForEvaluationCheckBox('Asthma', false, false),
    GroupModelForEvaluationCheckBox('Other', false, false),
    GroupModelForEvaluationCheckBox('Epilepsy', false, false),
    GroupModelForEvaluationCheckBox('Chronic Renal Disease', false, false),
    GroupModelForEvaluationCheckBox('HIV/AIDs', false, false),
  ];

  List<GroupModelForEvaluationCheckBox> _checkboxExistingMedicalDiagnoses3 = [
    GroupModelForEvaluationCheckBox('Hepatitis (B or C)', false, false),
    GroupModelForEvaluationCheckBox('A-Fib', false, false),
    GroupModelForEvaluationCheckBox('Autism', false, false),
    GroupModelForEvaluationCheckBox('Osteoporosis', false, false),
    GroupModelForEvaluationCheckBox('Stroke', false, false),
    GroupModelForEvaluationCheckBox('Ischemic Heart Disease', false, false),
    GroupModelForEvaluationCheckBox('Other', false, false),
  ];

  List<GroupModelForCheckBox> get existingPsychiatricDiagnosesList {
    return _existingPsychiatricDiagnosesList;
  }

  List<GroupModelForCheckBox> get abuseList {
    return _abuseList;
  }

  List<GroupModel> get noYes {
    return _noYes;
  }

  List<GroupModel> get coitusAge {
    return _coitusAge;
  }

  List<GroupModel> get sexualPartners {
    return _sexualPartners;
  }

  List<GroupModel> get sexualActivity {
    return _sexualActivity;
  }

  List<GroupModel> get maritalStatus {
    return _maritalStatus;
  }

  List<GroupModel> get smokingstatus {
    return _smokingStatus;
  }

  List<GroupModelForEvaluationCheckBox> get checkboxExistingMedicalDiagnoses {
    return _checkboxExistingMedicalDiagnoses;
  }

  List<GroupModelForEvaluationCheckBox> get checkboxExistingMedicalDiagnoses2 {
    return _checkboxExistingMedicalDiagnoses2;
  }

  List<GroupModelForEvaluationCheckBox> get checkboxExistingMedicalDiagnoses3 {
    return _checkboxExistingMedicalDiagnoses3;
  }
}
