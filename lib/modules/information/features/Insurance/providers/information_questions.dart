import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';

class InformationQuestions with ChangeNotifier {

  List<GroupModel> _policySelectValues = [
    GroupModel('Select', 0),
  ];

  List<GroupModel> get policySelectValues => _policySelectValues;

  List<GroupModel> _levelSelectValues = [
    GroupModel('Select', 0),
  ];

  List<GroupModel> get levelSelectValues => _levelSelectValues;

  List<GroupModel> _planTypeSelectValues = [
    GroupModel('Select', 0),
  ];

  List<GroupModel> get planTypeSelectValues => _planTypeSelectValues;

  List<GroupModel> _medicSecondarySelectValues = [
    GroupModel('Select', 0),
  ];

  List<GroupModel> get medicSecondarySelectValues => _medicSecondarySelectValues;

}