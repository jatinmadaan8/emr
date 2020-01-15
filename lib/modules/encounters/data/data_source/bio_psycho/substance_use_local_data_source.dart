import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/substance_use_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class SubstanceUseLocalDataSource {
  Future<SubstanceUseModel> getSubstanceUse(int chiefComplaintId);
  Future<int> addSubstanceUse(SubstanceUseModel data);
  Future<int> updateSubstanceUse(SubstanceUseModel data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<SubstanceUseSelectModel>> getSelectValues(String name);
}

class SubstanceUseLocalDataSourceImpl implements SubstanceUseLocalDataSource {
  @override
  Future<int> addSubstanceUse(SubstanceUseModel data) {
    // TODO: implement addSubstanceUse
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<List<SubstanceUseSelectModel>> getSelectValues(String name) {
    // TODO: implement getSelectValues
    return null;
  }

  @override
  Future<SubstanceUseModel> getSubstanceUse(int chiefComplaintId) {
    // TODO: implement getSubstanceUse
    return null;
  }

  @override
  Future<int> updateSubstanceUse(SubstanceUseModel data) {
    // TODO: implement updateSubstanceUse
    return null;
  }
}
