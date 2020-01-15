import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';
import '../models/social_medical_psych_hx/surgery_history.dart';

abstract class SurgeryHistoryRemoteDataSource {
  Future<SurgeryHistoryModel> getSurgeryHistory(int id);
  Future<void> addSurgeryHistory(SurgeryHistoryModel surgeryHistory);
  Future<void> updateSurgeryHistory(SurgeryHistoryModel surgeryHistory);
  Future<List<SurgeryTypesLookupModel>> getSurgeryTypes();
  Future<List<Encounters>> getEncounters(int id);
}

class SurgeryHistoryRemoteDataSourceImpl
    implements SurgeryHistoryRemoteDataSource {
  final HttpService httpService;

  SurgeryHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SurgeryHistoryModel> getSurgeryHistory(int id) async {
    try {
      return httpService
          .get(path: '/api/SurgeryHistory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SurgeryHistoryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<SurgeryTypesLookupModel>> getSurgeryTypes() async {
    try {
      return httpService
          .get(path: '/api/LookupData/SurgeryTypes')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        return List<SurgeryTypesLookupModel>.from(data.map((x) {
          return SurgeryTypesLookupModel.fromJson(x);
        }));
      }).first;
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
  Future<void> addSurgeryHistory(SurgeryHistoryModel surgeryHistory) async {
    print("Add SurgeryHistory");
    print(jsonEncode(surgeryHistory.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/SurgeryHistory',
        encodedJson: jsonEncode(
          surgeryHistory.toAddJson(),
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
  Future<void> updateSurgeryHistory(SurgeryHistoryModel surgeryHistory) async {
    try {
      print(jsonEncode(surgeryHistory.toUpdateJson()));
      await httpService
          .put(
        url: '/api/SurgeryHistory/${surgeryHistory.id}',
        encodedJson: jsonEncode(
          surgeryHistory.toUpdateJson(),
        ),
      )
          .handleError(
        (err) {
          print("\n\n\nHEr");
          print(err);
          throw Failure(code: err.code, message: err.message);
        },
      ).first;
    } catch (e) {
      print("\n\n\nE");
      print(e);
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
