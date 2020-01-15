import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class VitalsQuestions with ChangeNotifier {
  List<GroupModel> _locationApicalRadioValues = [
    GroupModel("Apical", 0),
    GroupModel("Radical", 1),
  ];

  List<GroupModel> _locationArmRadioValues = [
    GroupModel("Left arm", 0),
    GroupModel("Right arm", 1),
  ];

  List<GroupModel> _qualityRadioValues = [
    GroupModel("Strong", 0),
    GroupModel("Regular", 1),
    GroupModel("Weak", 2),
    GroupModel("Irregular", 3),
  ];

  List<GroupModel> _oralAxRadioValues = [
    GroupModel("Oral", 0),
    GroupModel("Axillary", 1),
    GroupModel("Tympanic", 2),
  ];

  List<GroupModel> _positionRadioValues = [
    GroupModel("Standing", 0),
    GroupModel("Sitting", 1),
    GroupModel("Lying", 2),
  ];

  List<GroupModel> get locationApicalRadioValues {
    return _locationApicalRadioValues;
  }

  List<GroupModel> get locationArmRadioValues {
    return _locationArmRadioValues;
  }

  List<GroupModel> get qualityRadioValues {
    return _qualityRadioValues;
  }

  List<GroupModel> get oralAxRadioValues {
    return _oralAxRadioValues;
  }

  List<GroupModel> get positionRadioValues {
    return _positionRadioValues;
  }
}
