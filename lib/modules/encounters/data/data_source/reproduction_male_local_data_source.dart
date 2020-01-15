import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class ReproductionMaleLocalDataSource {
  Future<ReproductionMaleModel> getReproductionMale(int id);
  Future<void> addReproductionMale(ReproductionMaleModel reproductionMaleModel);
  Future<void> deleteReproductionMale();
  Future<void> updateReproductionMale(ReproductionMaleModel reproductionMale);

  Future<List<ReproductionMaleLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class ReproductionMaleLocalDataSourceImpl
    implements ReproductionMaleLocalDataSource {
  @override
  Future<void> addReproductionMale(
      ReproductionMaleModel reproductionMaleModel) {
    // TODO: implement addReproductionMale
    return null;
  }

  @override
  Future<void> deleteReproductionMale() {
    // TODO: implement deleteReproductionMale
    return null;
  }

  @override
  Future<List<ReproductionMaleLookUpData>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<ReproductionMaleModel> getReproductionMale(int id) {
    // TODO: implement getReproductionMale
    return null;
  }

  @override
  Future<void> updateReproductionMale(ReproductionMaleModel reproductionMale) {
    // TODO: implement updateReproductionMale
    return null;
  }
}
