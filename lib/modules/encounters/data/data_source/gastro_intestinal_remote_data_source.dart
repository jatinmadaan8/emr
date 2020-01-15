import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/gastro_intestinal.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class GastroIntestinalRemoteDataSource {
  Future<GastroIntestinalModel> getGastroIntestinal(int id);
  Future<void> deleteGastroIntestinal();
  Future<void> updateGastroIntestinal(GastroIntestinalModel gastroIntestinal);
  Future<void> addGastroIntestinal(GastroIntestinalModel gastroIntestinal);

  Future<List<GastroIntestinalDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class GastroIntestinalRemoteDataSourceImpl
    implements GastroIntestinalRemoteDataSource {
  final HttpService httpService;

  GastroIntestinalRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<GastroIntestinalModel> getGastroIntestinal(int id) async {
    try {
      return httpService
          .get(path: '/api/Gastrointestinal/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => GastroIntestinalModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addGastroIntestinal(
      GastroIntestinalModel gastroIntestinalModel) async {
    print("Add Gastro: " + jsonEncode(gastroIntestinalModel.toAddJson()));
    try {
      await httpService
          .post(
              url: '/api/GastroIntestinal',
              encodedJson: jsonEncode(
                gastroIntestinalModel.toAddJson(),
              ))
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteGastroIntestinal() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateGastroIntestinal(
      GastroIntestinalModel gastroIntestinalModel) async {
    print("Update Gastro: " + jsonEncode(gastroIntestinalModel.toUpdateJson()));
    try {
      await httpService
          .put(
              url: '/api/GastroIntestinal/${gastroIntestinalModel.id}',
              encodedJson: jsonEncode(
                gastroIntestinalModel.toUpdateJson(),
              ))
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<GastroIntestinalDropDown>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<GastroIntestinalDropDown>.from(
              data.map((x) {
                return GastroIntestinalDropDown.fromJson(x);
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
