import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class InsuranceLocalDataSource {
  Future<InsuranceModel> getInsurance(int id);
  Future<void> addInsurance(InsuranceModel InsuranceModel);
  Future<void> deleteInsurance();
  Future<void> updateInsurance(InsuranceModel Insurance);

  Future<List<Encounters>> getEncounters(int id);
}

class InsuranceLocalDataSourceImpl
    implements InsuranceLocalDataSource {
  @override
  Future<void> addInsurance(
      InsuranceModel InsuranceModel) {
    // TODO: implement addInsurance
    return null;
  }

  @override
  Future<void> deleteInsurance() {
    // TODO: implement deleteInsurance
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<InsuranceModel> getInsurance(int id) {
    // TODO: implement getInsurance
    return null;
  }

  @override
  Future<void> updateInsurance(InsuranceModel Insurance) {
    // TODO: implement updateInsurance
    return null;
  }
}
