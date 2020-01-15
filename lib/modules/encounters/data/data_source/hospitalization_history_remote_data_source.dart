import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/hospitalization_history.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class HospitalizationHistoryRemoteDataSource {
  Future<HospitalizationHistoryModel> getHospitalizationHistory(int id);
  Future<void> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);
  Future<void> deleteHospitalizationHistory();
  Future<void> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);

  Future<List<Encounters>> getEncounters(int id);
}

class HospitalizationHistoryRemoteDataSourceImpl
    implements HospitalizationHistoryRemoteDataSource {
  final HttpService httpService;

  HospitalizationHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<HospitalizationHistoryModel> getHospitalizationHistory(int id) async {
    try {
      return httpService
          .get(path: '/api/HospitalizationHistory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => HospitalizationHistoryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) async {
    print(jsonEncode(hospitalizationHistory.toJson()));
    try {
      await httpService
          .post(
        url: '/api/HospitalizationHistory',
        encodedJson: jsonEncode(
          hospitalizationHistory.toJson(),
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
  Future<void> deleteHospitalizationHistory() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) async {
    try {
      print(jsonEncode(hospitalizationHistory.toJson()));
      await httpService
          .put(
        url: '/api/HospitalizationHistory/${hospitalizationHistory.id}',
        encodedJson: jsonEncode(
          hospitalizationHistory.toJson(),
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
