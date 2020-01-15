import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/substance_use_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class SubstanceUseRemoteDataSource {
  Future<SubstanceUseModel> getSubstanceUse(int chiefComplaintId);
  Future<int> addSubstanceUse(SubstanceUseModel data);
  Future<int> updateSubstanceUse(SubstanceUseModel data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<SubstanceUseSelectModel>> getSelectValues(String name);
}

class SubstanceUseRemoteDataSourceImpl implements SubstanceUseRemoteDataSource {
  final HttpService httpService;

  SubstanceUseRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SubstanceUseModel> getSubstanceUse(int id) async {
    try {
      return httpService
          .get(path: '/api/SubstanceUse/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SubstanceUseModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addSubstanceUse(SubstanceUseModel data) async {
    print(jsonEncode(data.toAddJson()));
    try {
      await httpService
          .post(
              url: 'api/SubstanceUse',
              encodedJson: jsonEncode(data.toAddJson()))
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => {})
          .first;
      return null;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> updateSubstanceUse(SubstanceUseModel data) async {
    try {
      var result = await httpService
          .put(
              url: '/api/SubstanceUse/' + data.id.toString(),
              encodedJson: jsonEncode(data.toUpdateJson()))
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => {})
          .first;
      return null;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    try {
      return httpService
          .get(path: '/api/Encounters/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<Encounters>.from(data.map((x) {
                return Encounters.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<SubstanceUseSelectModel>> getSelectValues(String name) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + name)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<SubstanceUseSelectModel>.from(data.map((x) {
                return SubstanceUseSelectModel.fromJson(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
