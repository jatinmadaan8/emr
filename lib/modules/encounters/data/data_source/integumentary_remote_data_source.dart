import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/integumentary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class IntegumentaryRemoteDataSource {
  Future<IntegumentaryModel> getIntegumentary(int id);
  Future<void> addIntegumentary(IntegumentaryModel integumentary);
  Future<void> deleteIntegumentary();
  Future<void> updateIntegumentary(IntegumentaryModel integumentary);

  Future<List<IntegumentaryLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class IntegumentaryRemoteDataSourceImpl
    implements IntegumentaryRemoteDataSource {
  final HttpService httpService;

  IntegumentaryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<IntegumentaryModel> getIntegumentary(int id) async {
    try {
      return httpService
          .get(path: '/api/Integumentary/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => IntegumentaryModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addIntegumentary(IntegumentaryModel integumentary) async {
    print("Add integumentary");
    print(jsonEncode(integumentary.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/Integumentary',
        encodedJson: jsonEncode(
          integumentary.toAddJson(),
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
  Future<void> deleteIntegumentary() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateIntegumentary(IntegumentaryModel integumentary) async {
    try {
      print(jsonEncode(integumentary.toUpdateJson()));
      await httpService
          .put(
        url: '/api/Integumentary/${integumentary.id}',
        encodedJson: jsonEncode(
          integumentary.toUpdateJson(),
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
  Future<List<IntegumentaryLookUpData>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<IntegumentaryLookUpData>.from(
              data.map((x) {
                return IntegumentaryLookUpData.fromJson(x);
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
