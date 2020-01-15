import 'package:flutter/material.dart';

import '../models/group.dart';

class Questions with ChangeNotifier {
  List<GroupModel> _familyandEnvironment = [
    GroupModel(
      "1-4",
      1,
    ),
    GroupModel(
      "5-8",
      2,
    ),
    GroupModel(
      "9-10",
      3,
    ),
    GroupModel(
      "10-20",
      4,
    ),
    GroupModel(
      "20+",
      5,
    ),
  ];

  List<GroupModel> _noYes = [
    GroupModel(
      "No",
      1,
    ),
    GroupModel(
      "Yes",
      2,
    )
  ];

  List<GroupModel> _noYesNa = [
    GroupModel(
      "No",
      1,
    ),
    GroupModel(
      "Yes",
      2,
    ),
    GroupModel(
      "NA",
      3,
    )
  ];

  List<GroupModelBool> _noYesNabool = [
    GroupModelBool(
      "No",
      false,
    ),
    GroupModelBool(
      "Yes",
      true,
    ),
    GroupModelBool(
      "NA",
      null,
    )
  ];

  List<GroupModelBool> _noYesbool = [
    GroupModelBool("No", false),
    GroupModelBool("Yes", true)
  ];

  List<GroupModelBool> _childNeglect = [
    GroupModelBool("Child Abuse", true),
    GroupModelBool("Child Neglect", false)
  ];

  List<GroupModel> _goodFairPoor = [
    GroupModel(
      "Good",
      1,
    ),
    GroupModel(
      "Fair",
      2,
    ),
    GroupModel(
      "Poor",
      3,
    )
  ];
  List<GroupModel> _goodFairPoor2 = [
    GroupModel(
      "Excellent",
      1,
    ),
    GroupModel(
      "Good",
      1,
    ),
    GroupModel(
      "Fair",
      2,
    ),
    GroupModel(
      "Poor",
      3,
    )
  ];

  List<GroupModel> _happySadAngryWithdraw = [
    GroupModel(
      "Happy",
      1,
    ),
    GroupModel(
      "Sad",
      2,
    ),
    GroupModel(
      "Angry",
      3,
    ),
    GroupModel(
      "Withdrawn",
      4,
    )
  ];

  List<GroupModel> _disciplineOptions = [
    GroupModel(
      "Overly strict",
      1,
    ),
    GroupModel(
      "Strict",
      2,
    ),
    GroupModel(
      "Fair",
      3,
    ),
    GroupModel(
      "Lenient",
      4,
    ),
    GroupModel(
      "Nonexistent",
      5,
    )
  ];

  List<GroupModel> _outlook = [
    GroupModel(
      "Positive",
      1,
    ),
    GroupModel(
      "Netural",
      2,
    ),
    GroupModel(
      "Indiffierent",
      3,
    ),
    GroupModel(
      "Other",
      4,
    ),
    GroupModel(
      "Negative",
      5,
    )
  ];

  List<GroupModel> _outcome = [
    GroupModel(
      "Convicted",
      1,
    ),
    GroupModel(
      "Not Guilty",
      2,
    ),
    GroupModel(
      "Other",
      3,
    )
  ];

  List<GroupModelForCheckBox> _checkboxhelplist = [
    GroupModelForCheckBox('Reading', false),
    GroupModelForCheckBox('Writing', false),
    GroupModelForCheckBox('TDD Device', false),
    GroupModelForCheckBox('Sign Language', false),
  ];

  List<GroupModelForCheckBox> _checkboxhelplist2 = [
    GroupModelForCheckBox('Language Interpreter', false),
    GroupModelForCheckBox('Assistive Listening Device', false),
  ];

  List<GroupModelForCheckBox> _checkboxCurrentInvolvementList = [
    GroupModelForCheckBox('Divorce proceedings', false),
    GroupModelForCheckBox('Child Custody proceedings', false),
    GroupModelForCheckBox('Protective or Restraining Orders', false),
  ];

  List<GroupModelForCheckBox> _checkboxCurrentInvolvementList2 = [
    GroupModelForCheckBox('None of the Above', false),
  ];

  List<GroupModelForEvaluationCheckBox> _checkboxFurtherEvaluationList = [
    GroupModelForEvaluationCheckBox('Vocational(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('HOPE(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('Psychiatric(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox(
        'AoD Assessment(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('Educational/GED', false, false),
    GroupModelForEvaluationCheckBox('Nutritional(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('ACT(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox(
        'Health Assessment(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('Psychological(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox(
        'Diagnostic Assessment(Access Ohio)', false, false),
    GroupModelForEvaluationCheckBox('Other', false, false),
  ];

  List<GroupModelForEvaluationCheckBox>
      _checkboxProblemCheckPsychosocialStressorsList = [
    GroupModelForEvaluationCheckBox('Unemployment', false, false),
    GroupModelForEvaluationCheckBox('Homelessness', false, false),
    GroupModelForEvaluationCheckBox('Financial Strain', false, false),
    GroupModelForEvaluationCheckBox('Chronic Health Condition', false, false),
    GroupModelForEvaluationCheckBox(
        'Change in Family Dynamic(Divorce)', false, false),
    GroupModelForEvaluationCheckBox(
        'Life Transition (Example: Leaving home)', false, false),
    GroupModelForEvaluationCheckBox('Other', false, false)
  ];

  List<GroupModel> get familyandEnvironment {
    return familyandEnvironment;
  }

  List<GroupModel> get noYes {
    return _noYes;
  }

  List<GroupModelBool> get noYesbool {
    return _noYesbool;
  }

  List<GroupModelBool> get childNeglect {
    return _childNeglect;
  }

  List<GroupModel> get happySadAngryWithdraw {
    return _happySadAngryWithdraw;
  }

  List<GroupModel> get goodFairPoor {
    return _goodFairPoor;
  }

  List<GroupModel> get goodFairPoor2 {
    return _goodFairPoor2;
  }

  List<GroupModel> get noYesNa {
    return _noYesNa;
  }

  List<GroupModelBool> get noYesNabool {
    return _noYesNabool;
  }

  List<GroupModel> get disciplineOptions {
    return _disciplineOptions;
  }

  List<GroupModel> get outlook {
    return _outlook;
  }

  List<GroupModel> get outcome {
    return _outcome;
  }

  List<GroupModelForCheckBox> get checkboxhelplist {
    return _checkboxhelplist;
  }

  List<GroupModelForCheckBox> get checkboxhelplist2 {
    return _checkboxhelplist2;
  }

  List<GroupModelForCheckBox> get checkboxCurrentInvolvementList {
    return _checkboxCurrentInvolvementList;
  }

  List<GroupModelForCheckBox> get checkboxCurrentInvolvementList2 {
    return _checkboxCurrentInvolvementList2;
  }

  List<GroupModelForEvaluationCheckBox> get checkboxFurtherEvaluationList {
    return _checkboxFurtherEvaluationList;
  }

  List<GroupModelForEvaluationCheckBox>
      get checkboxProblemCheckPsychosocialStressorsList {
    return _checkboxProblemCheckPsychosocialStressorsList;
  }

  List<GroupModel> _healthStatusRadioValue = [
    GroupModel("Excellent(0)", 0),
    GroupModel("Very Good(8)", 1),
    GroupModel("Good(15)", 2),
    GroupModel("Fair(22)", 3),
    GroupModel("Poor(30)", 4),
  ];

  List<GroupModel> get healthStatusRadioValue {
    return _healthStatusRadioValue;
  }

  List<GroupModel> _notSliModConExtrRadioValue = [
    GroupModel("Not at all(0)", 0),
    GroupModel("Slightly(8)", 1),
    GroupModel("Moderately(15)", 2),
    GroupModel("Considerably(22)", 3),
    GroupModel("Extremely(30)", 4),
  ];

  List<GroupModel> get notSliModConExtrRadioValue {
    return _notSliModConExtrRadioValue;
  }
}
