import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class NeuroSensoryRemoteDataSource {
  Future<NeuroSensory> getNeuroSensory(int id);
  Future<void> addNeuroSensory(NeuroSensory neuroSensory);
  Future<void> deleteNeuroSensory();
  Future<void> updateNeuroSensory(NeuroSensory neuroSensory);

  Future<List<NeuroDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class NeuroSensoryRemoteDataSourceImpl implements NeuroSensoryRemoteDataSource {
  final HttpService httpService;

  NeuroSensoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<NeuroSensory> getNeuroSensory(int id) async {
    try {
      return httpService
          .get(path: '/api/NeuroSensory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => NeuroSensory.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addNeuroSensory(NeuroSensory neuroSensory) async {
    print("Add Neuro SEnsory");
    print(jsonEncode(neuroSensory.toAddJson()));
    try {
      await httpService
          .post(
        url: '/api/NeuroSensory',
        encodedJson: jsonEncode(
          neuroSensory.toAddJson(),
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
  Future<void> deleteNeuroSensory() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateNeuroSensory(NeuroSensory neuroSensory) async {
    try {
      print(jsonEncode(neuroSensory.toUpdateJson()));
      await httpService
          .put(
        url: '/api/NeuroSensory/${neuroSensory.id}',
        encodedJson: jsonEncode(
          neuroSensory.toUpdateJson(),
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
  Future<List<NeuroDropDown>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<NeuroDropDown>.from(
              data.map((x) {
                return NeuroDropDown.fromMap(x);
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
