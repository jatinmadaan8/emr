import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/hospitalization_history.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class HospitalizationHistoryLocalDataSource {
  Future<HospitalizationHistoryModel> getHospitalizationHistory(int id);
  Future<void> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);
  Future<void> deleteHospitalizationHistory();
  Future<void> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);

  Future<List<Encounters>> getEncounters(int id);
}

class HospitalizationHistoryLocalDataSourceImpl
    implements HospitalizationHistoryLocalDataSource {
  @override
  Future<void> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) {
    // TODO: implement addHospitalizationHistory
    return null;
  }

  @override
  Future<void> deleteHospitalizationHistory() {
    // TODO: implement deleteHospitalizationHistory
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<HospitalizationHistoryModel> getHospitalizationHistory(int id) {
    // TODO: implement getHospitalizationHistory
    return null;
  }

  @override
  Future<void> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) {
    // TODO: implement updateHospitalizationHistory
    return null;
  }
}
