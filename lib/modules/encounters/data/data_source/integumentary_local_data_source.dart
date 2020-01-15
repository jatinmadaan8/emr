import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/integumentary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class IntegumentaryLocalDataSource {
  Future<IntegumentaryModel> getIntegumentary(int id);
  Future<void> addIntegumentary(IntegumentaryModel integumentary);
  Future<void> deleteIntegumentary();
  Future<void> updateIntegumentary(IntegumentaryModel integumentary);

  Future<List<IntegumentaryLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class IntegumentaryLocalDataSourceImpl implements IntegumentaryLocalDataSource {
  @override
  Future<void> addIntegumentary(IntegumentaryModel integumentary) {
    // TODO: implement addIntegumentary
    return null;
  }

  @override
  Future<void> deleteIntegumentary() {
    // TODO: implement deleteIntegumentary
    return null;
  }

  @override
  Future<List<IntegumentaryLookUpData>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<IntegumentaryModel> getIntegumentary(int id) {
    // TODO: implement getIntegumentary
    return null;
  }

  @override
  Future<void> updateIntegumentary(IntegumentaryModel integumentary) {
    // TODO: implement updateIntegumentary
    return null;
  }
}
