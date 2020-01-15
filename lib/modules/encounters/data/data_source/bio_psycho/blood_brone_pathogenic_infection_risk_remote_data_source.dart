import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/blood_brone_pathogenic_infection_risk.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

abstract class BloodBronePathogenicInfectionRiskRemoteDataSource {
  Future<BloodBronePathogenicInfectionRisk> getBloodBrone(int chiefComplaintId);
  Future<int> addBloodBrone(BloodBronePathogenicInfectionRisk data);
  Future<int> updateBloodBrone(BloodBronePathogenicInfectionRisk data);
  Future<List<Encounters>> getEncounters(int id);
}

class BloodBronePathogenicInfectionRiskRemoteDataSourceImpl
    implements BloodBronePathogenicInfectionRiskRemoteDataSource {
  final HttpService httpService;

  BloodBronePathogenicInfectionRiskRemoteDataSourceImpl(
      {@required this.httpService});

  @override
  Future<BloodBronePathogenicInfectionRisk> getBloodBrone(int id) async {
    try {
      return httpService
          .get(path: '/api/BloodPathogenicInfectionrisk/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => BloodBronePathogenicInfectionRisk.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addBloodBrone(BloodBronePathogenicInfectionRisk data) {
    try {
      var result = httpService
          .post(
              url: 'api/BloodPathogenicInfectionrisk',
              encodedJson: jsonEncode(data.toMap()))
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => {})
          .first;
      return null;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> updateBloodBrone(BloodBronePathogenicInfectionRisk data) {
    try {
      var result = httpService
          .put(
              url: '/api/BloodPathogenicInfectionrisk/' + data.id.toString(),
              encodedJson: jsonEncode(data.toMap()))
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => {})
          .first;
      return null;
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
