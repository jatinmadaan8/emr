import 'package:flutter/material.dart';

import '../../bio_psycho/models/group.dart';

class TuberculosisQuestions with ChangeNotifier {
  List<GroupModel> _yesNo = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];

  List<GroupModel> get yesNo {
    return _yesNo;
  }
}
