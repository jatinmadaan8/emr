import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/values_blefs.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class ValuesBeliefsRemoteDataSource {
  Future<ValuesBeliefs> getValuesBeliefs(int chiefComplaintId);
  Future<int> addValuesBeliefs(ValuesBeliefs data);
  Future<int> updateValuesBeliefs(ValuesBeliefs data);
  Future<List<GenricQuestions>> getVobQuestions();
  Future<List<Encounters>> getEncounters(int id);
}

class ValuesBeliefsRemoteDataSourceImpl
    implements ValuesBeliefsRemoteDataSource {
  final HttpService httpService;

  ValuesBeliefsRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<ValuesBeliefs> getValuesBeliefs(int id) async {
    try {
      return httpService
          .get(path: '/api/ValuesBeliefs/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => ValuesBeliefs.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addValuesBeliefs(ValuesBeliefs data) {
    try {
      var result = httpService
          .post(url: 'api/ValuesBeliefs', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateValuesBeliefs(ValuesBeliefs data) {
    try {
      var result = httpService
          .put(
              url: '/api/ValuesBeliefs/' + data.id.toString(),
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
  Future<List<GenricQuestions>> getVobQuestions() {
    try {
      return httpService
          .get(path: '/api/LookupData/VobQuestions')
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
