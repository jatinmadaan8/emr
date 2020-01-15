import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/abuse_neglect.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/sleep_rest.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class SleepRestRemoteDataSource {
  Future<SleepRest> getSleepRest(int id);
  Future<int> addSleepRest(SleepRest data);
  Future<int> updateSleepRest(SleepRest data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricLookupData>> getLookupData(String type);
}

class SleepRestRemoteDataSourceImpl
    implements SleepRestRemoteDataSource {
  final HttpService httpService;

 SleepRestRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SleepRest> getSleepRest(int id) async {
    try {
      return httpService
          .get(path: '/api/SleepRest/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SleepRest.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<GenricLookupData>> getLookupData(String type) async {
    try {
      return httpService
          .get(path: '/api/LookupData/$type')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
           .map((data) => List<GenricLookupData>.from(data.map((x) {
                return GenricLookupData.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addSleepRest(SleepRest data) {
    try {
      var result = httpService
          .post(
              url: 'api/SleepRest', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateSleepRest(SleepRest data) {
    try {
      var result = httpService
          .put(
              url: '/api/SleepRest/' + data.id.toString(),
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
}
