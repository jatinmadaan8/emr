import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/tuberculosis/tuberculosis.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';

abstract class TuberculosisRemoteDataSource {
  Future<Tuberculosis> getTuberculosis(int chiefComplaintId);
  Future<int> addTuberculosis(Tuberculosis data);
  Future<int> updateTuberculosis(Tuberculosis data);
  Future<List<GenricQuestions>> getNvTbQuestions();
  Future<List<Encounters>> getEncounters(int id);
}

class TuberculosisRemoteDataSourceImpl implements TuberculosisRemoteDataSource {
  final HttpService httpService;

  TuberculosisRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<Tuberculosis> getTuberculosis(int id) async {
    try {
      return httpService
          .get(path: '/api/Tuberculosis/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => Tuberculosis.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addTuberculosis(Tuberculosis data) {
    try {
      var result = httpService
          .post(url: 'api/Tuberculosis', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateTuberculosis(Tuberculosis data) {
    try {
      var result = httpService
          .put(
              url: '/api/Tuberculosis/' + data.id.toString(),
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
  Future<List<GenricQuestions>> getNvTbQuestions() {
    try {
      return httpService
          .get(path: '/api/LookupData/NvTbQuestions')
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
