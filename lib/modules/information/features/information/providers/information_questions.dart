import 'package:flutter/material.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/models/group.dart';

class InformationQuestions with ChangeNotifier {
  List<GroupModel> _defaultProviderSelectValues = [
    GroupModel("test, Venkat", 0),
    GroupModel("Test, Venkat", 1),
    GroupModel("doc, Pradusha", 2),
    GroupModel("Doc1, Doc1", 3),
  ];

  List<GroupModel> get defaultProviderSelectValues =>
      _defaultProviderSelectValues;

  List<GroupModel> _genderSelectValues = [
    GroupModel("Male", 0),
    GroupModel("Female", 1),
    GroupModel("Unknown", 2),
  ];

  List<GroupModel> get genderSelectValues => _genderSelectValues;

  List<GroupModel> _prefLanguageSelectValues = [
    GroupModel("Arabic", 0),
    GroupModel("Chinese - Mandarin", 1),
    GroupModel("Chinese - Other", 2),
    GroupModel("English", 3),
    GroupModel("French", 4),
    GroupModel("German", 5),
    GroupModel("Hindi", 6),
    GroupModel("Italian", 7),
    GroupModel("Japnese", 8),
    GroupModel("Korean", 9),
    GroupModel("Portuguese", 10),
    GroupModel("Russian", 11),
    GroupModel("Spanish", 12),
    GroupModel("Declined", 13),
    GroupModel("Unknown", 14),
  ];

  List<GroupModel> get prefLanguageSelectValues => _prefLanguageSelectValues;

  List<GroupModel> _ethnicitySelectValues = [
    GroupModel("Hispanic or Latino", 0),
    GroupModel("Not Hispanic or Latino", 1),
    GroupModel("Declined", 2),
    GroupModel("Unknown", 3),
  ];

  List<GroupModel> get ethnicitySelectValues => _ethnicitySelectValues;

  List<GroupModel> _religionSelectValues = [
    GroupModel("Declined", 0),
    GroupModel("Unknown", 1),
    GroupModel("Catholic", 2),
    GroupModel("Jehovah Witness", 3),
    GroupModel("Jewish", 4),
    GroupModel("Muslim", 5),
    GroupModel("Other", 6),
    GroupModel("Protestant", 7),
    GroupModel("Seventh Day Adventis", 8),
  ];

  List<GroupModel> get religionSelectValues => _religionSelectValues;

  List<GroupModelForCheckBoxInformationTab> _raceSelectValues = [
    GroupModelForCheckBoxInformationTab(0, "White", false),
    GroupModelForCheckBoxInformationTab(
        1, "American Indian or Alaska Native", false),
    GroupModelForCheckBoxInformationTab(2, "Asian", false),
    GroupModelForCheckBoxInformationTab(3, "Black or African American", false),
    GroupModelForCheckBoxInformationTab(
        4, "Native Hawaiian or Other Pacific Islander", false),
    GroupModelForCheckBoxInformationTab(5, "Declined", false),
    GroupModelForCheckBoxInformationTab(6, "Unknown", false),
  ];

  List<GroupModelForCheckBoxInformationTab> get raceSelectValues =>
      _raceSelectValues;

  List<GroupModel> _stateSelectValues = [
    GroupModel("MA", 0),
    GroupModel("NY", 1),
  ];

  List<GroupModel> get stateSelectValues => _stateSelectValues;

  List<GroupModel> _preferredPhonesSelectValues = [
    GroupModel("Cell", 0),
    GroupModel("Home", 1),
    GroupModel("Work", 2),
  ];

  List<GroupModel> get preferredPhonesSelectValues =>
      _preferredPhonesSelectValues;

  List<GroupModelForCheckBoxEnable> _patientFlagsCheckBoxValues = [
    GroupModelForCheckBoxEnable("Medicaid", false),
    GroupModelForCheckBoxEnable("Custom Alert 2", false),
    GroupModelForCheckBoxEnable("Custom Alert 3", false),
    GroupModelForCheckBoxEnable("CCM/RPM", true, disabled: true),
    GroupModelForCheckBoxEnable("MMPGx", true, disabled: true),
  ];

  List<GroupModelForCheckBoxEnable> get patientFlagsCheckBoxValues =>
      _patientFlagsCheckBoxValues;

  List<GroupModelForCheckBoxEnable> _preferredContactByCheckBoxValues = [
    GroupModelForCheckBoxEnable("Email", false),
    GroupModelForCheckBoxEnable("Mail", false),
    GroupModelForCheckBoxEnable("Pickup", false),
    GroupModelForCheckBoxEnable("Phone", false),
    GroupModelForCheckBoxEnable("Fax", false),
    GroupModelForCheckBoxEnable("Patient Portal", false),
  ];

  List<GroupModelForCheckBoxEnable> get preferredContactByCheckBoxValues =>
      _preferredContactByCheckBoxValues;


  List<GroupModel> _publicitySelectValues = [
    GroupModel('No reminder/recall', 0),
    GroupModel('Reminder/recall - any method', 1),
    GroupModel('Reminder/recall - no calls', 2),
    GroupModel('Reminder only - any method', 3),
    GroupModel('Reminder only - no calls', 4),
    GroupModel('Recall only - any method', 5),
    GroupModel('Recall only - no calls', 6),
    GroupModel('Reminder/recall - to provider', 7),
    GroupModel('Reminder to provider', 8),
    GroupModel('Only reminder to provider, no recall', 9),
    GroupModel('Recall to provider', 10),
    GroupModel('Only recall to provider, no reminder', 11),
  ];

  List<GroupModel> get publicitySelectValues => _publicitySelectValues;

  List<GroupModel> _registryStatusSelectValues = [
    GroupModel('Active', 0),
    GroupModel('Inactive', 1),
    GroupModel('Inactive-Lost to follow-up(cancel contract)', 2),
    GroupModel('Inactive-Moved or gone elsewhere(cancel contract)', 3),
    GroupModel('Inactive-Permanently inactive(Do not reactivate or add new entries to the record)', 4),
    GroupModel('Unknown', 5),
  ];

  List<GroupModel> get registryStatusSelectValues => _registryStatusSelectValues;

  List<GroupModel> _shareHealthStatusStatusSelectValues = [
    GroupModel("Yes", 0),
    GroupModel("No", 1),
  ];
  List<GroupModel> get shareHealthStatusStatusSelectValues => _shareHealthStatusStatusSelectValues;

  List<GroupModel> _relationshipSelectValues = [
    GroupModel('Self', 0),
    GroupModel('Spouse', 1),
    GroupModel('Child', 2),
    GroupModel('Other', 3),
    GroupModel('Grandchild', 4),
    GroupModel('Significant Other', 5),
    GroupModel('Mother', 6),
    GroupModel('Father', 7),
  ];

  List<GroupModel> get relationshipSelectValues => _relationshipSelectValues;

  List<GroupModelForCheckBoxEnable> _healthCareCheckBoxValues = [
    GroupModelForCheckBoxEnable("Home Health", false),
    GroupModelForCheckBoxEnable("Nursing Home", false),
    GroupModelForCheckBoxEnable("Hospice", false),
    GroupModelForCheckBoxEnable("Impairments", false),
  ];

  List<GroupModelForCheckBoxEnable> get healthCareCheckBoxValues =>
      _healthCareCheckBoxValues;

  List<GroupModel> _billTypeSelectValues = [
    GroupModel('Bill Insurance Only', 0),
    GroupModel('Bill Patient After Primary Insurance', 1),
    GroupModel('Bill Patient After All Insurance', 2),
    GroupModel('Bill Patient Only', 3),
  ];

  List<GroupModel> get billTypeSelectValues => _billTypeSelectValues;

  List<GroupModel> _referralSourceSelectValues = [
    GroupModel('Co-worker', 0),
    GroupModel('Friend', 1),
    GroupModel('Insurance', 2),
    GroupModel('Newspaper', 3),
    GroupModel('Patient', 4),
    GroupModel('Physician', 5),
    GroupModel('Radio', 6),
    GroupModel('Relative', 7),
  ];

  List<GroupModel> get referralSourceSelectValues => _referralSourceSelectValues;

  List<GroupModel> _relOfGuarantorSelectValues = [
    GroupModel('Self', 0),
    GroupModel('Spouse', 1),
    GroupModel('Other', 2),
    GroupModel('Significant Other', 3),
    GroupModel('Mother', 4),
    GroupModel('Father', 5),
  ];

  List<GroupModel> get relOfGuarantorSelectValues => _relOfGuarantorSelectValues;
  
}

class GroupModelForCheckBoxInformationTab {
  String title;
  bool value;
  int index;
  GroupModelForCheckBoxInformationTab(
    this.index,
    this.title,
    this.value,
  );
}

class GroupModelForCheckBoxEnable {
  String title;
  bool value;
  bool disabled;

  GroupModelForCheckBoxEnable(this.title, this.value, {this.disabled = false});
}
