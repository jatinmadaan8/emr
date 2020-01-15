import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class ReproductionMaleRemoteDataSource {
  Future<ReproductionMaleModel> getReproductionMale(int id);
  Future<void> addReproductionMale(ReproductionMaleModel reproductionMaleModel);
  Future<void> deleteReproductionMale();
  Future<void> updateReproductionMale(ReproductionMaleModel reproductionMale);

  Future<List<ReproductionMaleLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class ReproductionMaleRemoteDataSourceImpl
    implements ReproductionMaleRemoteDataSource {
  final HttpService httpService;

  ReproductionMaleRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<ReproductionMaleModel> getReproductionMale(int id) async {
    try {
      return httpService
          .get(path: '/api/ReproductionMale/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => ReproductionMaleModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  @override
  Future<void> addReproductionMale(
      ReproductionMaleModel ReproductionMaleModel) async {
    print("Add ReproductionMale " +
        jsonEncode(ReproductionMaleModel.toAddJson()));
    try {
      await httpService
          .post(
            url: '/api/ReproductionMale',
            encodedJson: jsonEncode(
              ReproductionMaleModel.toAddJson(),
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
  Future<void> deleteReproductionMale() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateReproductionMale(
      ReproductionMaleModel reproductionMaleModel) async {
    print(jsonEncode(reproductionMaleModel.toUpdateJson()));

    try {
      await httpService
          .put(
        url: '/api/ReproductionMale/${reproductionMaleModel.id}',
        encodedJson: jsonEncode(
          reproductionMaleModel.toUpdateJson(),
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

  Future<List<ReproductionMaleLookUpData>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<ReproductionMaleLookUpData>.from(
              data.map((x) {
                return ReproductionMaleLookUpData.fromJson(x);
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
