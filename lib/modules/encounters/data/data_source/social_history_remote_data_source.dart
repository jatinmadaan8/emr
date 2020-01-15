import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/social_history.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class SocialHistoryRemoteDataSource {
  Future<SocialHistoryModel> getSocialHistory(int id);
  Future<void> addSocialHistory(SocialHistoryModel socialHistory);
  Future<void> deleteSocialHistory();
  Future<void> updateSocialHistory(SocialHistoryModel socialHistory);

  Future<List<MaritalStatus>> getMaritalStatus();
  Future<List<SexualActivity>> getSmokingStatus();
  Future<List<SexualActivity>> getSexualActivity();

  Future<List<Encounters>> getEncounters(int id);
}

class SocialHistoryRemoteDataSourceImpl
    implements SocialHistoryRemoteDataSource {
  final HttpService httpService;

  SocialHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SocialHistoryModel> getSocialHistory(int id) async {
    try {
      return httpService
          .get(path: '/api/SocialHistory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SocialHistoryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addSocialHistory(SocialHistoryModel socialHistory) async {
    print("Add Neuro SEnsory");
    print(jsonEncode(socialHistory.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/SocialHistory',
        encodedJson: jsonEncode(
          socialHistory.toAddJson(),
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
  Future<void> deleteSocialHistory() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateSocialHistory(SocialHistoryModel socialHistory) async {
    try {
      print(jsonEncode(socialHistory.toUpdateJson()));
      await httpService
          .put(
        url: '/api/SocialHistory/${socialHistory.id}',
        encodedJson: jsonEncode(
          socialHistory.toUpdateJson(),
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

  @override
  Future<List<MaritalStatus>> getMaritalStatus() {
    try {
      return httpService
          .get(path: '/api/LookupData/MaritalStatus')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<MaritalStatus>.from(
              data.map((x) {
                return MaritalStatus.fromJson(x);
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
  Future<List<SexualActivity>> getSmokingStatus() {
    try {
      return httpService
          .get(path: '/api/LookupData/SmokingStatus')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<SexualActivity>.from(
              data.map((x) {
                return SexualActivity.fromJson(x);
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
  Future<List<SexualActivity>> getSexualActivity() {
    try {
      return httpService
          .get(path: '/api/LookupData/SexualActivity')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<SexualActivity>.from(
              data.map((x) {
                return SexualActivity.fromJson(x);
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
}
