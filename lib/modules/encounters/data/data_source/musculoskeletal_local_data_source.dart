import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/musculoskeletal.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class MusculoSkeletalLocalDataSource {
  Future<MusculoSkeletalModel> getMusculoSkeletal(int id);
  Future<void> addMusculoSkeletal(MusculoSkeletalModel musculoSkeletal);
  Future<void> deleteMusculoSkeletal();
  Future<void> updateMusculoSkeletal(MusculoSkeletalModel musculoSkeletal);

  Future<List<MusculoSkeletalLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class MusculoSkeletalLocalDataSourceImpl
    implements MusculoSkeletalLocalDataSource {
  @override
  Future<void> addMusculoSkeletal(MusculoSkeletalModel musculoSkeletal) {
    // TODO: implement addMusculoSkeletal
    return null;
  }

  @override
  Future<void> deleteMusculoSkeletal() {
    // TODO: implement deleteMusculoSkeletal
    return null;
  }

  @override
  Future<List<MusculoSkeletalLookUpData>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<MusculoSkeletalModel> getMusculoSkeletal(int id) {
    // TODO: implement getMusculoSkeletal
    return null;
  }

  @override
  Future<void> updateMusculoSkeletal(MusculoSkeletalModel musculoSkeletal) {
    // TODO: implement updateMusculoSkeletal
    return null;
  }
}
