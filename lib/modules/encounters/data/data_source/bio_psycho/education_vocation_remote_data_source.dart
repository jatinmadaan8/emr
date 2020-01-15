import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/education_vocation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class EducationVocationRemoteDataSource {
  Future<EducationVocation> getEducationVocation(int chiefComplaintId);
  Future<int> addEducationVocation(EducationVocation data);
  Future<int> updateEducationVocation(EducationVocation data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricDropDown>> getGenricDropDown(String name);
}

class EducationVocationRemoteDataSourceImpl
    implements EducationVocationRemoteDataSource {
  final HttpService httpService;

  EducationVocationRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<EducationVocation> getEducationVocation(int id) async {
    try {
      return httpService
          .get(path: '/api/EducationVocation/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => EducationVocation.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addEducationVocation(EducationVocation data) {
    try {
      httpService
          .post(
              url: 'api/EducationVocation',
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
  Future<int> updateEducationVocation(EducationVocation data) {
    try {
      var result = httpService
          .put(
              url: '/api/EducationVocation/' + data.id.toString(),
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

  @override
  Future<List<GenricDropDown>> getGenricDropDown(String name) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + name)
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
}
