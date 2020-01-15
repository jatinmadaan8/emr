import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/pain_assessment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';

abstract class GeneralCCRemoteDataSource {
  Future<ChiefComplaint> getChiefComplaint(int chiefComplaintId);
  Future<PainAssessment> getPainAssessment(int id);
  Future<List<GenricDropDown>> getDropDown(String dropdownName);
  Future<int> addChiefComplaint(ChiefComplaint data);
  Future<int> updateChiefComplaint(ChiefComplaint data);
  Future<List<Encounters>> getEncounters(int id);
  Future<int> addPainAssessment(PainAssessment data);
  Future<int> updatePainAssessment(PainAssessment data);
}

class GeneralCCRemoteDataSourceImpl implements GeneralCCRemoteDataSource {
  final HttpService httpService;

  GeneralCCRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<ChiefComplaint> getChiefComplaint(int chiefComplaintId) async {
    try {
      return httpService
          .get(path: '/api/Chiefcomplaint/$chiefComplaintId')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => ChiefComplaint.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addChiefComplaint(ChiefComplaint data) {
    try {
      var result = httpService
          .post(
              url: 'api/Chiefcomplaint', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateChiefComplaint(ChiefComplaint data) {
    try {
      var result = httpService
          .put(
              url: '/api/Chiefcomplaint/' + data.id.toString(),
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
  Future<int> addPainAssessment(PainAssessment data) async {
    try {
      var result = await httpService
          .post(
              url: '/api/PainAssessmentHistory',
              encodedJson: jsonEncode(data.toJson()))
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
  Future<PainAssessment> getPainAssessment(int id) async {
    try {
      return httpService
          .get(path: '/api/PainAssessmentHistory/$id')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        var s = PainAssessment.fromJson(data);
        return s;
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

// GeneralCCDropDown
  @override
  Future<List<GenricDropDown>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<GenricDropDown>.from(data.map((x) {
                return GenricDropDown.fromMap(x);
              })))
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

  @override
  Future<int> updatePainAssessment(PainAssessment data) async {
    try {
      var result = await httpService
          .put(
              url: '/api/PainAssessmentHistory/' + data.id.toString(),
              encodedJson: jsonEncode(data.toJson()))
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
}
