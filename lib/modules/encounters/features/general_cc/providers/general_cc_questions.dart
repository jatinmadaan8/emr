import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class GeneralCCQuestions with ChangeNotifier {
  List<GroupModel> _reasonForVisitRadioValues = [
    GroupModel(
      "Patient annual/periodic visit",
      0,
    ),
    GroupModel(
      "Patient problem visit",
      1,
    ),
  ];

  List<GroupModel> _yesNo = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];

  List<GroupModel> _controlledNotControlledRadioValues = [
    GroupModel("Controlled", 0),
    GroupModel("Uncontrolled", 1),
  ];

  List<GroupModel> _acuteOrChronicRadioValues = [
    GroupModel("Acute", 0),
    GroupModel("Chronic", 1),
  ];

  List<GroupModel> _qualityRadioValues = [
    GroupModel("Sharp", 0),
    GroupModel("Burining", 1),
    GroupModel("Pressure", 2),
    GroupModel("Dull", 3),
    GroupModel("Shooting", 4),
    GroupModel("Aching/Throbbing", 5),
    GroupModel("Radiation", 6),
    GroupModel("Others", 7),
  ];

  List<GroupModel> _painManagementReferralRadioValues = [
    GroupModel("Has Provider", 0),
    GroupModel("Referred", 1),
    GroupModel("Refused", 2),
    GroupModel("Pain", 3),
    GroupModel("Siva", 4),
  ];

//  ---------------------------------------------------------------

  List<GroupModel> _informantSelectValues = [
    GroupModel("Client", 0),
    GroupModel("Family Member", 1),
    GroupModel("Friend", 2),
    GroupModel("Other", 3),
  ];

  List<GroupModel> _methodOfArrivalSelectValues = [
    GroupModel("Ambulatory", 0),
    GroupModel("Gurney", 1),
    GroupModel("Wheelchair", 2),
  ];

  List<GroupModel> _durationSelectValues = [
    GroupModel("< 1 Week", 0),
    GroupModel("1-2 Weeks", 1),
    GroupModel("3-4 Weeks", 2),
    GroupModel("1-2 Months", 3),
    GroupModel("3-6 Months", 4),
    GroupModel("6-12 Months", 5),
    GroupModel("> 1 Year", 6),
  ];

  List<GroupModel> _locationSelectValues = [
    GroupModel("Abdomin(Lower)", 0),
    GroupModel("Abdomin(Upper)", 1),
    GroupModel("Ankle(Left)", 2),
    GroupModel("Ankle(Right)", 3),
    GroupModel("Arm(Left)", 4),
    GroupModel("Arm(Right)", 5),
    GroupModel("Chest", 6),
    GroupModel("Foot(Left)", 7),
    GroupModel("Foot(Right)", 8),
    GroupModel("Hand(Left)", 9),
    GroupModel("Hand(Right)", 10),
    GroupModel("Head", 11),
  ];

  List<GroupModel> get reasonForVisitRadioValues {
    return _reasonForVisitRadioValues;
  }

  List<GroupModel> get informantSelectValues {
    return _informantSelectValues;
  }

  List<GroupModel> get methodOfArrivalSelectValues {
    return _methodOfArrivalSelectValues;
  }

  List<GroupModel> get yesNo {
    return _yesNo;
  }

  List<GroupModel> get controlledNotControlledRadioValues {
    return _controlledNotControlledRadioValues;
  }

  List<GroupModel> get acuteOrChronicRadioValues {
    return _acuteOrChronicRadioValues;
  }

  List<GroupModel> get qualityRadioValues {
    return _qualityRadioValues;
  }

  List<GroupModel> get painManagementReferralRadioValues {
    return _painManagementReferralRadioValues;
  }

  List<GroupModel> get locationSelectValues {
    return _locationSelectValues;
  }

  List<GroupModel> get durationSelectValues {
    return _durationSelectValues;
  }
}
