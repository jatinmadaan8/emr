import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/respiratory.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';

abstract class RespiratoryRemoteDataSource {
  Future<RespiratoryModel> getRespiratory(int id);
  Future<void> addRespiratory(RespiratoryModel respiratoryModel);
  Future<void> deleteRespiratory();
  Future<void> updateRespiratory(RespiratoryModel respiratory);

  Future<List<RespiratoryDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class RespiratoryRemoteDataSourceImpl implements RespiratoryRemoteDataSource {
  final HttpService httpService;

  RespiratoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<RespiratoryModel> getRespiratory(int id) async {
    try {
      return httpService
          .get(path: '/api/Respiratory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => RespiratoryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  @override
  Future<void> addRespiratory(RespiratoryModel respiratoryModel) async {
    print("Add Respiratory " + jsonEncode(respiratoryModel.toAddJson()));
    try {
      await httpService
          .post(
            url: '/api/Respiratory',
            encodedJson: jsonEncode(
              respiratoryModel.toAddJson(),
            ),
          )
          .handleError(
            (err) => throw Failure(code: err.code, message: err.message),
          )
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteRespiratory() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateRespiratory(RespiratoryModel respiratoryModel) async {
    print(jsonEncode(respiratoryModel.toUpdateJson()));

    try {
      await httpService
          .put(
        url: '/api/Respiratory/${respiratoryModel.id}',
        encodedJson: jsonEncode(
          respiratoryModel.toUpdateJson(),
        ),
      )
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
    return null;
  }

  Future<List<RespiratoryDropDown>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<RespiratoryDropDown>.from(
              data.map((x) {
                return RespiratoryDropDown.fromJson(x);
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
