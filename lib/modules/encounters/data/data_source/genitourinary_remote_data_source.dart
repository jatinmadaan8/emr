import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/genitourinary.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class GenitourinaryRemoteDataSource {
  Future<GenitourinaryModel> getGenitourinary(int id);
  Future<void> addGenitourinary(GenitourinaryModel genitourinary);
  Future<void> deleteGenitourinary();
  Future<void> updateGenitourinary(GenitourinaryModel genitourinary);

  Future<List<GenitourinaryLookUpModel>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class GenitourinaryRemoteDataSourceImpl
    implements GenitourinaryRemoteDataSource {
  final HttpService httpService;

  GenitourinaryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<GenitourinaryModel> getGenitourinary(int id) async {
    try {
      return httpService
          .get(path: '/api/Genitourinary/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => GenitourinaryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addGenitourinary(GenitourinaryModel genitourinary) async {
    print("Add Genitourinary SEnsory");
    print(jsonEncode(genitourinary.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/Genitourinary',
        encodedJson: jsonEncode(
          genitourinary.toAddJson(),
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
  Future<void> deleteGenitourinary() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateGenitourinary(GenitourinaryModel genitourinary) async {
    try {
      print(jsonEncode(genitourinary.toUpdateJson()));
      await httpService
          .put(
        url: '/api/Genitourinary/${genitourinary.id}',
        encodedJson: jsonEncode(
          genitourinary.toUpdateJson(),
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
  Future<List<GenitourinaryLookUpModel>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<GenitourinaryLookUpModel>.from(
              data.map((x) {
                return GenitourinaryLookUpModel.fromJson(x);
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
