import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounter.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/remote/patients_list/get_patients_list_request.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/remote/patients_list/get_patients_list_response.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';

abstract class PatientsRemoteDataSource {
  Future<List<Patient>> getPatientsList(
      {@required GetPatientsListRequest request});
  Future<void> addPatient();

  Future<List<Encounter>> getEncounterList(int patientId);
}

class PatientsRemoteDataSourceImpl implements PatientsRemoteDataSource {
  final HttpService httpService;

  PatientsRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<Patient>> getPatientsList(
      {@required GetPatientsListRequest request}) async {
    try {
      return httpService
          .post(url: '/api/Patient', encodedJson: jsonEncode(request.toMap()))
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => GetPatientsListResponse.fromMap(_).items)
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addPatient() {
    // TODO: implement addPatient
    return null;
  }

  @override
  Future<List<Encounter>> getEncounterList(int patientId) {
    try {
      return httpService
          .get(path: '/api/Encounters/ByPatient/$patientId')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        return List<Encounter>.from(data.map((x) {
          return Encounter.fromMap(x);
        }));
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
