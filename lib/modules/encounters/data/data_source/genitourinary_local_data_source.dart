import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/genitourinary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class GenitourinaryLocalDataSource {
  Future<GenitourinaryModel> getGenitourinary(int id);
  Future<void> addGenitourinary(GenitourinaryModel genitourinary);
  Future<void> deleteGenitourinary();
  Future<void> updateGenitourinary(GenitourinaryModel genitourinary);

  Future<List<NeuroDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class GenitourinaryLocalDataSourceImpl implements GenitourinaryLocalDataSource {
  @override
  Future<void> addGenitourinary(GenitourinaryModel genitourinary) {
    // TODO: implement addGenitourinary
    return null;
  }

  @override
  Future<void> deleteGenitourinary() {
    // TODO: implement deleteGenitourinary
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
  Future<GenitourinaryModel> getGenitourinary(int id) {
    // TODO: implement getGenitourinary
    return null;
  }

  @override
  Future<void> updateGenitourinary(GenitourinaryModel genitourinary) {
    // TODO: implement updateGenitourinary
    return null;
  }
}
