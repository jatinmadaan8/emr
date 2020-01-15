import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class HealthPatternAssessmentQuestions with ChangeNotifier {
  List<GroupModel> _yesNo = [
    GroupModel("Yes", 1),
    GroupModel("No", 2),
  ];

  List<GroupModelBool> _yesNobool = [
    GroupModelBool("Yes", true),
    GroupModelBool("No", false),
  ];

  List<GroupModel> _mobilityStatusRadioValues = [
    GroupModel("Ambulatory", 0),
    GroupModel("Transfer with Assist", 1),
    GroupModel("Wheelchair bound", 2),
    GroupModel("Ambulatory with Assist", 3),
  ];
  List<GroupModel> _assistiveDevicesRadioValues = [
    GroupModel("None", 0),
    GroupModel("Crutches", 1),
    GroupModel("Walker", 2),
    GroupModel("W/C", 3),
    GroupModel("Other", 4),
  ];

  List<GroupModel> _limitationsRadioValues = [
    GroupModel("None", 0),
    GroupModel("Weakness", 1),
    GroupModel("Fatigue", 2),
    GroupModel("Other", 3),
  ];

  List<GroupModel> _adlsRadioValues = [
    GroupModel("Independent", 0),
    GroupModel("Feeding assist", 1),
    GroupModel("Toileting assist", 2),
    GroupModel("Grooming assist", 3),
    GroupModel("Dressing assist", 4),
  ];

  List<GroupModel> _communicationRadioValues = [
    GroupModel("Clear", 0),
    GroupModel("Comprehends", 1),
    GroupModel("Difficulty", 2),
    GroupModel("Alphasia", 3),
    GroupModel("Confused", 4),
  ];

  List<GroupModel> _primaryLanguageSpokenRadioValues = [
    GroupModel("English", 0),
    GroupModel("Other", 1),
  ];

  List<GroupModel> _hearingRadioValues = [
    GroupModel("No Issues", 0),
    GroupModel("Impaired", 1),
    GroupModel("Corrected", 2),
    GroupModel("Tinnitus", 3),
    GroupModel("Discharge", 4),
    GroupModel("Other", 5),
  ];

  List<GroupModel> _visionRadioValues = [
    GroupModel("No Issues", 0),
    GroupModel("Impaired", 1),
    GroupModel("Corrected", 2),
    GroupModel("Blurring", 3),
    GroupModel("Diplopia", 4),
    GroupModel("Cataracts", 5),
    GroupModel("Glaucoma", 5),
    GroupModel("Others", 5),
  ];

  List<GroupModel> _nurseObservationRadioValues = [
    GroupModel("No abuse/neglect observed", 0),
    GroupModel("Abuse/neglect observed", 1),
  ];

  List<GroupModel> _nurseFollowUpActionRadioValues = [
    GroupModel("None, no abuse/neglect", 0),
    GroupModel("None, previously documented/addressed", 1),
    GroupModel("Notified clinician", 2),
    GroupModel("Other", 3),
  ];

  List<GroupModel> _dieticianReferralRadioValues = [
    GroupModel("No risk identified", 0),
    GroupModel("Scheduled", 1),
    GroupModel("Referred", 2),
    GroupModel("Refused", 3),
  ];

  // ----------------------------------------------------------------

  List<GroupModelForCheckBox> _problemCheckBoxValues = [
    GroupModelForCheckBox("Falling Asleep", false),
    GroupModelForCheckBox("Staying Asleep", false),
    GroupModelForCheckBox("Feeling rested after sleep", false),
    GroupModelForCheckBox("Other", false),
    GroupModelForCheckBox("None", false),
  ];

  List<GroupModel> get yesNo {
    return _yesNo;
  }

  List<GroupModelBool> get yesNobool {
    return _yesNobool;
  }

  List<GroupModel> get mobilityStatusRadioValues {
    return _mobilityStatusRadioValues;
  }

  List<GroupModel> get assistiveDevicesRadioValues {
    return _assistiveDevicesRadioValues;
  }

  List<GroupModel> get limitationsRadioValues {
    return _limitationsRadioValues;
  }

  List<GroupModel> get adlsRadioValues {
    return _adlsRadioValues;
  }

  List<GroupModel> get communicationRadioValues {
    return _communicationRadioValues;
  }

  List<GroupModel> get primaryLanguageSpokenRadioValues {
    return _primaryLanguageSpokenRadioValues;
  }

  List<GroupModel> get hearingRadioValues {
    return _hearingRadioValues;
  }

  List<GroupModel> get visionRadioValues {
    return _visionRadioValues;
  }

  List<GroupModel> get nurseObservationRadioValues {
    return _nurseObservationRadioValues;
  }

  List<GroupModel> get nurseFollowUpActionRadioValues {
    return _nurseFollowUpActionRadioValues;
  }

  List<GroupModel> get dieticianReferralRadioValues =>
      _dieticianReferralRadioValues;

  List<GroupModelForCheckBox> get problemCheckBoxValues {
    return _problemCheckBoxValues;
  }
}
