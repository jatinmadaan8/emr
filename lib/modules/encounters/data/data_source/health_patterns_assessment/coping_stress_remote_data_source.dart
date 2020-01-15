import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/coping_stress.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class CopingStressRemoteDataSource {
  Future<CopingStress> getCopingStress(int chiefComplaintId);
  Future<int> addCopingStress(CopingStress data);
  Future<int> updateCopingStress(CopingStress data);
  Future<List<GenricQuestions>> getCosQuestions();
  Future<List<Encounters>> getEncounters(int id);
}

class CopingStressRemoteDataSourceImpl implements CopingStressRemoteDataSource {
  final HttpService httpService;

  CopingStressRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<CopingStress> getCopingStress(int id) async {
    try {
      return httpService
          .get(path: '/api/CopingStress/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => CopingStress.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addCopingStress(CopingStress data) {
    try {
      var result = httpService
          .post(url: 'api/CopingStress', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateCopingStress(CopingStress data) {
    try {
      var result = httpService
          .put(
              url: '/api/CopingStress/' + data.id.toString(),
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
  Future<List<GenricQuestions>> getCosQuestions() {
    try {
      return httpService
          .get(path: '/api/LookupData/CosQuestions')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<GenricQuestions>.from(data.map((x) {
                return GenricQuestions.fromMap(x);
              })))
          .first;
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
