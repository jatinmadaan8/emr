import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/musculoskeletal.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class MusculoSkeletalRemoteDataSource {
  Future<MusculoSkeletalModel> getMusculoSkeletal(int id);
  Future<void> addMusculoSkeletal(MusculoSkeletalModel musculoSkeletal);
  Future<void> deleteMusculoSkeletal();
  Future<void> updateMusculoSkeletal(MusculoSkeletalModel musculoSkeletal);

  Future<List<MusculoSkeletalLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class MusculoSkeletalRemoteDataSourceImpl
    implements MusculoSkeletalRemoteDataSource {
  final HttpService httpService;

  MusculoSkeletalRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<MusculoSkeletalModel> getMusculoSkeletal(int id) async {
    try {
      return httpService
          .get(path: '/api/MusculoSkeletal/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => MusculoSkeletalModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addMusculoSkeletal(MusculoSkeletalModel musculoSkeletal) async {
    print("Add musculoSkeletal");
    print(jsonEncode(musculoSkeletal.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/MusculoSkeletal',
        encodedJson: jsonEncode(
          musculoSkeletal.toAddJson(),
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
  Future<void> deleteMusculoSkeletal() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateMusculoSkeletal(
      MusculoSkeletalModel musculoSkeletal) async {
    try {
      print(jsonEncode(musculoSkeletal.toUpdateJson()));
      await httpService
          .put(
        url: '/api/MusculoSkeletal/${musculoSkeletal.id}',
        encodedJson: jsonEncode(
          musculoSkeletal.toUpdateJson(),
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
  Future<List<MusculoSkeletalLookUpData>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<MusculoSkeletalLookUpData>.from(
              data.map((x) {
                return MusculoSkeletalLookUpData.fromJson(x);
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
