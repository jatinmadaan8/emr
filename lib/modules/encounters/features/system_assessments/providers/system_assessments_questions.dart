import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class SystemAssessmentsQuestions with ChangeNotifier {
  List<GroupModelForCheckBox> _symptomsCardioCheckBoxValues = [
    GroupModelForCheckBox('Headache/pain', false),
    GroupModelForCheckBox('Motor disturbances', false),
    GroupModelForCheckBox('Seizures', false),
    GroupModelForCheckBox('Numbness', false),
    GroupModelForCheckBox('Tingling', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModelForCheckBox> _symptomsRespiratoryCheckBoxValues = [
    GroupModelForCheckBox('Cough', false),
    GroupModelForCheckBox('Chest Pain', false),
    GroupModelForCheckBox('Dyspnea', false),
    GroupModelForCheckBox('Orthopnea', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModel> _levelOfConsciousnessRadioValues = [
    GroupModel("Alert", 0),
    GroupModel("Stuporous", 1),
    GroupModel("Semicomatose", 2),
    GroupModel("Comatose", 3),
    GroupModel("Non verbal", 4),
  ];

  List<GroupModel> _orientedToRadioValues = [
    GroupModel("Person", 0),
    GroupModel("Place", 1),
    GroupModel("Time", 2),
    GroupModel("Event", 3),
  ];

  List<GroupModelForCheckBox> _problemsCheckBoxValues = [
    GroupModelForCheckBox('Chest pain', false),
    GroupModelForCheckBox('Orthopnea', false),
    GroupModelForCheckBox('Hypertension', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModel> _peripheralPulsesRadioValues = [
    GroupModel("Palpable", 0),
    GroupModel("Non-palpable", 1),
  ];

  List<GroupModel> _rhythmRadioValues = [
    GroupModel("Regular", 0),
    GroupModel("Irregular", 1),
  ];

  List<GroupModel> _qualityRadioValues = [
    GroupModel("Pounding", 0),
    GroupModel("Thready", 1),
    GroupModel("Weak", 2),
    GroupModel("Regular", 3),
  ];

  List<GroupModel> _edemaRadioValues = [
    GroupModel("Pitting", 0),
    GroupModel("Non-pitting", 1),
    GroupModel("None", 2),
  ];

  List<GroupModel> _chestAppearanceRadioValues = [
    GroupModel("Symmetrical", 0),
    GroupModel("Asymmetrical", 1),
  ];

  List<GroupModel> _breathPatternRadioValues = [
    GroupModel("Labored", 0),
    GroupModel("Non-labored", 1),
  ];

  List<GroupModel> _breathSoundRadioValues = [
    GroupModel("Clear all lobes", 0),
    GroupModel("Equal and bilateral", 1),
    GroupModel("Rales", 2),
    GroupModel("Rhonchi", 3),
    GroupModel("Wheezes", 4),
  ];

  List<GroupModel> _oralMucosaRadioValues = [
    GroupModel("Dry", 0),
    GroupModel("Moist", 1),
  ];

  List<GroupModelForCheckBox> _procedureGastroCheckBoxValues = [
    GroupModelForCheckBox('Ostomies', false),
    GroupModelForCheckBox('Gastrostomy', false),
    GroupModelForCheckBox('Jejunostomy', false),
    GroupModelForCheckBox('Nasogastric tube', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModelForCheckBox> _bowelCheckBoxValues = [
    GroupModelForCheckBox('Pain', false),
    GroupModelForCheckBox('Diarrhea', false),
    GroupModelForCheckBox('Hemmorhoids', false),
    GroupModelForCheckBox('Constipation', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModel> _bowelSoundRadioValues = [
    GroupModel("Present", 0),
    GroupModel("Absent", 1),
  ];

  List<GroupModel> _urineColorRadioValues = [
    GroupModel("Clear", 0),
    GroupModel("Dark", 1),
    GroupModel("Hematuria", 2),
    GroupModel("Cloudy", 3),
    GroupModel("Other", 4),
  ];

  List<GroupModelForCheckBox> _procedureGenitourinaryCheckBoxValues = [
    GroupModelForCheckBox('Indewlling urinary catheter', false),
    GroupModelForCheckBox('Suprapublic catheter', false),
    GroupModelForCheckBox('Urostomy', false),
    GroupModelForCheckBox('Dialysis access', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModelForCheckBox> _symptomsBladderCheckBoxValues = [
    GroupModelForCheckBox('Urgency', false),
    GroupModelForCheckBox('Retention', false),
    GroupModelForCheckBox('Incontience', false),
    GroupModelForCheckBox('Hematuria', false),
    GroupModelForCheckBox('Nocturia', false),
    GroupModelForCheckBox('Anuria', false),
    GroupModelForCheckBox('Burning', false),
    GroupModelForCheckBox('Frequency', false),
    GroupModelForCheckBox('Bladder Distention', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
    GroupModelForCheckBox('Dribbling', false),
  ];

  List<GroupModel> _skinColorRadioValues = [
    GroupModel("Normal", 0),
    GroupModel("Pale", 1),
    GroupModel("Flushed", 2),
    GroupModel("Cyanotic", 3),
    GroupModel("Jaundiced", 4),
    GroupModel("Other", 5),
  ];

  List<GroupModel> _yesNoRadioValues = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];

  List<GroupModel> _temperatureRadioValues = [
    GroupModel("Hot", 0),
    GroupModel("Warm", 1),
    GroupModel("Cool", 2),
  ];

  List<GroupModel> _turgorRadioValues = [
    GroupModel("Good", 0),
    GroupModel("Fair", 1),
    GroupModel("Poor", 2),
  ];

  List<GroupModel> _conditionRadioValues = [
    GroupModel("Intact", 0),
    GroupModel("Ulcers", 1),
    GroupModel("Rashes", 2),
    GroupModel("Wounds", 3),
    GroupModel("Lesions", 4),
    GroupModel("Bruises", 5),
    GroupModel("Other", 6),
  ];

  List<GroupModelForCheckBox> _problemsMusculoskeletalCheckBoxValues = [
    GroupModelForCheckBox('Pain', false),
    GroupModelForCheckBox('Joint stiffness', false),
    GroupModelForCheckBox('Swelling', false),
    GroupModelForCheckBox('Prosthesis', false),
    GroupModelForCheckBox('Cramping', false),
    GroupModelForCheckBox('Spasm', false),
    GroupModelForCheckBox('Tremor', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModel> _strengthRadioValues = [
    GroupModel("Strong", 0),
    GroupModel("Weak", 1),
    GroupModel("None", 2),
  ];

  List<GroupModelForCheckBox> _problemsReproductionMaleCheckBoxValues = [
    GroupModelForCheckBox('Penile discharge', false),
    GroupModelForCheckBox('Tenderness', false),
    GroupModelForCheckBox('Pain', false),
    GroupModelForCheckBox('Scrotal mass', false),
    GroupModelForCheckBox('Inguinal mass', false),
    GroupModelForCheckBox('Penile implant', false),
    GroupModelForCheckBox('Breast lumps', false),
    GroupModelForCheckBox('Sexually transmitted disease(s)', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModelForCheckBox> _problemsReproductionFemaleCheckBoxValues = [
    GroupModelForCheckBox('Itching', false),
    GroupModelForCheckBox('Abnormal bleeding', false),
    GroupModelForCheckBox('Discharge', false),
    GroupModelForCheckBox('Breast lumps', false),
    GroupModelForCheckBox('PMS', false),
    GroupModelForCheckBox('Sexually transmitted disease(s)', false),
    GroupModelForCheckBox('Pos-menopausal symptoms', false),
    GroupModelForCheckBox('Pain', false),
    GroupModelForCheckBox('Other', false),
    GroupModelForCheckBox('None', false),
  ];

  List<GroupModelForCheckBox> get problemsReproductionFemaleCheckBoxValues =>
      _problemsReproductionFemaleCheckBoxValues;

  List<GroupModelForCheckBox> get problemsReproductionMaleCheckBoxValues =>
      _problemsReproductionMaleCheckBoxValues;

  List<GroupModelForCheckBox> get problemsMusculoskeletalCheckBoxValues =>
      _problemsMusculoskeletalCheckBoxValues;

  List<GroupModel> get strengthRadioValues => _strengthRadioValues;

  List<GroupModel> get skinColorRadioValues => _skinColorRadioValues;
  List<GroupModel> get yesNoRadioValues => _yesNoRadioValues;
  List<GroupModel> get temperatureRadioValues => _temperatureRadioValues;
  List<GroupModel> get turgorRadioValues => _turgorRadioValues;
  List<GroupModel> get conditionRadioValues => _conditionRadioValues;

  List<GroupModelForCheckBox> get symptomsBladderCheckBoxValues =>
      _symptomsBladderCheckBoxValues;

  List<GroupModelForCheckBox> get procedureGenitourinaryCheckBoxValues =>
      _procedureGenitourinaryCheckBoxValues;

  List<GroupModel> get urineColorRadioValues => _urineColorRadioValues;

  List<GroupModelForCheckBox> get problemsCheckBoxValues =>
      _problemsCheckBoxValues;

  List<GroupModelForCheckBox> get symptomsCardioCheckBoxValues =>
      _symptomsCardioCheckBoxValues;

  List<GroupModelForCheckBox> get symptomsRespiratoryCheckBoxValues =>
      _symptomsRespiratoryCheckBoxValues;

  List<GroupModel> get orientedToRadioValues => _orientedToRadioValues;

  List<GroupModel> get chestAppearanceRadioValues =>
      _chestAppearanceRadioValues;
  List<GroupModel> get breathPatternRadioValues => _breathPatternRadioValues;
  List<GroupModel> get breathSoundRadioValues => _breathSoundRadioValues;

  List<GroupModel> get levelOfConsciousnessRadioValues =>
      _levelOfConsciousnessRadioValues;

  List<GroupModel> get rhythmRadioValues => _rhythmRadioValues;
  List<GroupModel> get qualityRadioValues => _qualityRadioValues;
  List<GroupModel> get edemaRadioValues => _edemaRadioValues;

  List<GroupModel> get peripheralPulsesRadioValues =>
      _peripheralPulsesRadioValues;

  List<GroupModel> get oralMucosaRadioValues => _oralMucosaRadioValues;
  List<GroupModelForCheckBox> get procedureGastroCheckBoxValues =>
      _procedureGastroCheckBoxValues;
  List<GroupModelForCheckBox> get bowelCheckBoxValues => _bowelCheckBoxValues;
  List<GroupModel> get bowelSoundRadioValues => _bowelSoundRadioValues;
}
