import 'package:flutter/material.dart';

class GroupModel {
  final String text;
  final int index;
  GroupModel(@required this.text, @required this.index);
}

class GroupModelBool {
  final String text;
  final bool index;
  GroupModelBool(@required this.text, @required this.index);
}

class GroupModelForCheckBox {
  String title;
  bool value;
  GroupModelForCheckBox(@required this.title, @required this.value);
}

class GroupModelForEvaluationCheckBox {
  String title;
  bool value;
  bool value2;
  GroupModelForEvaluationCheckBox(
      @required this.title, @required this.value, @required this.value2);
}

class GroupModelCheckBoxWithString {
  String title;
  bool value;
  String desc;
  GroupModelCheckBoxWithString(
      @required this.title, @required this.value, @required this.desc);
}
