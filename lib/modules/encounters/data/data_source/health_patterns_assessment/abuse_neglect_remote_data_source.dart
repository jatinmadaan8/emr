import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/abuse_neglect.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class AbuseNeglectRemoteDataSource {
  Future<AbuseNeglect> getAbuseNeglect(int id);
  Future<int> addAbuseNeglect(AbuseNeglect data);
  Future<int> updateAbuseNeglect(AbuseNeglect data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricLookupData>> getLookupData(String type);
}

class AbuseNeglectRemoteDataSourceImpl
    implements AbuseNeglectRemoteDataSource {
  final HttpService httpService;

 AbuseNeglectRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<AbuseNeglect> getAbuseNeglect(int id) async {
    try {
      return httpService
          .get(path: '/api/AbuseNeglect/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => AbuseNeglect.fromMap(_))
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
  Future<int> addAbuseNeglect(AbuseNeglect data) {
    try {
      var result = httpService
          .post(
              url: 'api/AbuseNeglect', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateAbuseNeglect(AbuseNeglect data) {
    try {
      var result = httpService
          .put(
              url: '/api/AbuseNeglect/' + data.id.toString(),
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
