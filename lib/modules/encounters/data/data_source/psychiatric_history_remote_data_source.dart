import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/psychiatric_history.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class PsychiatricHistoryRemoteDataSource {
  Future<PsychiatricHistoryModel> getPsychiatricHistory(int id);
  Future<void> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);
  Future<void> deletePsychiatricHistory();
  Future<void> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);

  Future<List<Disease>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class PsychiatricHistoryRemoteDataSourceImpl
    implements PsychiatricHistoryRemoteDataSource {
  final HttpService httpService;

  PsychiatricHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<PsychiatricHistoryModel> getPsychiatricHistory(int id) async {
    try {
      return httpService
          .get(path: '/api/PsychiatricHistory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => PsychiatricHistoryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) async {
    print("Add Neuro SEnsory");
    print(jsonEncode(psychiatricHistory.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/PsychiatricHistory',
        encodedJson: jsonEncode(
          psychiatricHistory.toAddJson(),
        ),
      )
          .handleError(
        (err) {
          throw Failure(code: err.code, message: err.message);
        },
      ).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deletePsychiatricHistory() {
    // TODO:
    return null;
  }

  @override
  Future<void> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) async {
    try {
      print(jsonEncode(psychiatricHistory.toUpdateJson()));
      await httpService
          .put(
        url: '/api/PsychiatricHistory/${psychiatricHistory.id}',
        encodedJson: jsonEncode(
          psychiatricHistory.toUpdateJson(),
        ),
      )
          .handleError(
        (err) {
          throw Failure(code: err.code, message: err.message);
        },
      ).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<Disease>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<Disease>.from(
              data.map((x) {
                return Disease.fromJson(x);
              }),
            ),
          )
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
