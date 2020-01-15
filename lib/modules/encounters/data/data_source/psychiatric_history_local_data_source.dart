import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/psychiatric_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class PsychiatricHistoryLocalDataSource {
  Future<PsychiatricHistoryModel> getPsychiatricHistory(int id);
  Future<void> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);
  Future<void> deletePsychiatricHistory();
  Future<void> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);

  Future<List<NeuroDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class PsychiatricHistoryLocalDataSourceImpl
    implements PsychiatricHistoryLocalDataSource {
  @override
  Future<void> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) {
    // TODO: implement addPsychiatricHistory
    return null;
  }

  @override
  Future<void> deletePsychiatricHistory() {
    // TODO: implement deletePsychiatricHistory
    return null;
  }

  @override
  Future<List<NeuroDropDown>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<PsychiatricHistoryModel> getPsychiatricHistory(int id) {
    // TODO: implement getPsychiatricHistory
    return null;
  }

  @override
  Future<void> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) {
    // TODO: implement updatePsychiatricHistory
    return null;
  }
}
