import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/support_recovery.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

abstract class SupportRecoveryRemoteDataSource {
  Future<SupportRecovery> getSupportRecovery(int chiefComplaintId);
  Future<int> addSupportRecovery(SupportRecovery data);
  Future<int> updateSupportRecovery(SupportRecovery data);
  Future<List<Encounters>> getEncounters(int id);
}

class SupportRecoveryRemoteDataSourceImpl
    implements SupportRecoveryRemoteDataSource {
  final HttpService httpService;

  SupportRecoveryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SupportRecovery> getSupportRecovery(int id) async {
    try {
      return httpService
          .get(path: '/api/SupportRecovery/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SupportRecovery.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addSupportRecovery(SupportRecovery data) {
    try {
      var result = httpService
          .post(
              url: 'api/SupportRecovery', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateSupportRecovery(SupportRecovery data) {
    try {
      var result = httpService
          .put(
              url: '/api/SupportRecovery/' + data.id.toString(),
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
