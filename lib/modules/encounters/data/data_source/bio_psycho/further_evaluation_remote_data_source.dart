import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/further_evaluation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class FurtherEvaluationRemoteDataSource {
  Future<List<FurtherEvaluation>> getFurtherEvaluation(int encounterId);
  Future<int> addFurtherEvaluation(
      List<FurtherEvaluation> data, int encounterId);
  Future<int> updateFurtherEvaluation(
      List<FurtherEvaluation> data, int encounterId);
  Future<List<GenricDropDown>> getEvaluationTypes();
}

class FurtherEvaluationRemoteDataSourceImpl
    implements FurtherEvaluationRemoteDataSource {
  final HttpService httpService;

  FurtherEvaluationRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<FurtherEvaluation>> getFurtherEvaluation(int encounterId) async {
    try {
      return httpService
          .get(path: '/api/encouters/$encounterId/FurtherEvaluations')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<FurtherEvaluation>.from(data.map((x) {
                return FurtherEvaluation.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addFurtherEvaluation(
      List<FurtherEvaluation> data, int encounterId) {
    try {
      var reqData = data.map((v) => v.toMap()).toList();
      var result = httpService
          .post(
              url: '/api/encouters/$encounterId/FurtherEvaluations/',
              encodedJson: jsonEncode(reqData))
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
  Future<int> updateFurtherEvaluation(
      List<FurtherEvaluation> data, int encounterId) {
    try {
      var reqData = data.map((v) => v.toMap()).toList();

      var result = httpService
          .put(
              url: '/api/encouters/$encounterId/FurtherEvaluations/',
              encodedJson: jsonEncode(reqData))
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
  Future<List<GenricDropDown>> getEvaluationTypes() {
    try {
      return httpService
          .get(path: '/api/LookupData/EvaluationTypes')
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
