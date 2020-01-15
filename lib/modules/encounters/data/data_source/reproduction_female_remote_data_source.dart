import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_female.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class ReproductionFemaleRemoteDataSource {
  Future<ReproductionFemaleModel> getReproductionFemale(int id);
  Future<void> addReproductionFemale(
      ReproductionFemaleModel reproductionFemaleModel);
  Future<void> deleteReproductionFemale();
  Future<void> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemale);

  Future<List<ReproductionFemaleLookUpData>> getDropDown(String value);
  Future<List<ReproductionFemaleLookUpDataDescription>> getDropDownDescription(
      String value);
  Future<List<Encounters>> getEncounters(int id);
}

class ReproductionFemaleRemoteDataSourceImpl
    implements ReproductionFemaleRemoteDataSource {
  final HttpService httpService;

  ReproductionFemaleRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<ReproductionFemaleModel> getReproductionFemale(int id) async {
    try {
      return httpService
          .get(path: '/api/ReproductionFemale/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => ReproductionFemaleModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  @override
  Future<void> addReproductionFemale(
      ReproductionFemaleModel reproductionFemaleModel) async {
    print("Add ReproductionFemale " +
        jsonEncode(reproductionFemaleModel.toAddJson()));
    try {
      await httpService
          .post(
            url: '/api/ReproductionFemale',
            encodedJson: jsonEncode(
              reproductionFemaleModel.toAddJson(),
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
  Future<void> deleteReproductionFemale() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemaleModel) async {
    print(jsonEncode(reproductionFemaleModel.toUpdateJson()));

    try {
      await httpService
          .put(
        url: '/api/ReproductionFemale/${reproductionFemaleModel.id}',
        encodedJson: jsonEncode(
          reproductionFemaleModel.toUpdateJson(),
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

  @override
  Future<List<ReproductionFemaleLookUpData>> getDropDown(String value) async {
    try {
      return await httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<ReproductionFemaleLookUpData>.from(
              data.map((x) {
                return ReproductionFemaleLookUpData.fromJson(x);
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
  Future<List<ReproductionFemaleLookUpDataDescription>> getDropDownDescription(
      String value) async {
    try {
      return await httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<ReproductionFemaleLookUpDataDescription>.from(
              data.map((x) {
                return ReproductionFemaleLookUpDataDescription.fromJson(x);
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
