import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_female.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class ReproductionFemaleLocalDataSource {
  Future<ReproductionFemaleModel> getReproductionFemale(int id);
  Future<void> addReproductionFemale(
      ReproductionFemaleModel reproductionFemaleModel);
  Future<void> deleteReproductionFemale();
  Future<void> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemale);

  Future<List<ReproductionFemaleLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class ReproductionFemaleLocalDataSourceImpl
    implements ReproductionFemaleLocalDataSource {
  @override
  Future<void> addReproductionFemale(
      ReproductionFemaleModel reproductionFemaleModel) {
    // TODO: implement addReproductionFemale
    return null;
  }

  @override
  Future<void> deleteReproductionFemale() {
    // TODO: implement deleteReproductionFemale
    return null;
  }

  @override
  Future<List<ReproductionFemaleLookUpData>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<ReproductionFemaleModel> getReproductionFemale(int id) {
    // TODO: implement getReproductionFemale
    return null;
  }

  @override
  Future<void> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemale) {
    // TODO: implement updateReproductionFemale
    return null;
  }
}
