import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/family_environment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class FamilyEnvironmentRemoteDataSource {
  Future<FamilyEnvironment> getFamilyEnviroment(int chiefComplaintId);
  Future<int> addFamilyEnviroment(FamilyEnvironment data);
  Future<int> updateFamilyEnviroment(FamilyEnvironment data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricDropDown>> getGenricDropDown(String name);
}

class FamilyEnvironmentRemoteDataSourceImpl
    implements FamilyEnvironmentRemoteDataSource {
  final HttpService httpService;

  FamilyEnvironmentRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<FamilyEnvironment> getFamilyEnviroment(int id) async {
    try {
      return httpService
          .get(path: '/api/FamilyEnvironment/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => FamilyEnvironment.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addFamilyEnviroment(FamilyEnvironment data) {
    try {
      var result = httpService
          .post(
              url: 'api/FamilyEnvironment',
              encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateFamilyEnviroment(FamilyEnvironment data) {
    try {
      var result = httpService
          .put(
              url: '/api/FamilyEnvironment/' + data.id.toString(),
              encodedJson: jsonEncode(data.toMap()))
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
  Future<List<GenricDropDown>> getGenricDropDown(String name) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + name)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<GenricDropDown>.from(data.map((x) {
                return GenricDropDown.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
