import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/self_perception.dart';

abstract class SelfPerceptionRemoteDataSource {
  Future<SelfPerception> getSelfPerception(int chiefComplaintId);
  Future<int> addSelfPerception(SelfPerception data);
  Future<int> updateSelfPerception(SelfPerception data);
  Future<List<Encounters>> getEncounters(int id);
}

class SelfPerceptionRemoteDataSourceImpl
    implements SelfPerceptionRemoteDataSource {
  final HttpService httpService;

  SelfPerceptionRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SelfPerception> getSelfPerception(int id) async {
    try {
      return httpService
          .get(path: '/api/Selfperception/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SelfPerception.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addSelfPerception(SelfPerception data) {
    try {
      var result = httpService
          .post(
              url: 'api/Selfperception', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateSelfPerception(SelfPerception data) {
    try {
      var result = httpService
          .put(
              url: '/api/Selfperception/' + data.id.toString(),
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
