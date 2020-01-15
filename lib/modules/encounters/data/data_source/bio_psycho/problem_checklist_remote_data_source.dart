import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';

import '../../../../../core/services/http_service.dart';
import '../../../../../core/error/failure.dart';
import '../../models/bio_psycho/problem_checklist.dart';

abstract class ProblemChecklistRemoteDataSource {
  Future<ProblemChecklist> getProblemChecklist(int id);
  Future<int> addProblemChecklist(ProblemChecklist problemChecklist);
  Future<void> deleteProblemChecklist();
  Future<void> updateProblemChecklist();
  Future<List<Encounters>> getEncounters(int id);
  Future<List<Psychostress>> getPsychosocialStressors();
}

class ProblemChecklistRemoteDataSourceImpl
    implements ProblemChecklistRemoteDataSource {
  final HttpService httpService;

  ProblemChecklistRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<ProblemChecklist> getProblemChecklist(int id) async {
    try {
      return httpService
          .get(path: '/api/ProblemChecklist/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => ProblemChecklist.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<Psychostress>> getPsychosocialStressors() {
    try {
      return httpService
          .get(path: '/api/LookupData/PsychoStressConfig')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<Psychostress>.from(data.map((x) {
                return Psychostress.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addProblemChecklist(ProblemChecklist problemChecklist) async {
    if (problemChecklist.id != null) {
      var result = await httpService
          .put(
              url: '/api/ProblemChecklist/' +
                  problemChecklist.id.toString(),
              encodedJson: jsonEncode(problemChecklist.toMap()))
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        return 1;
      }).first;
    }
    if (problemChecklist.id == null) {
      var result = await httpService
          .post(url: '/api/ProblemChecklist', encodedJson: jsonEncode(problemChecklist.toMap()))
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        return 1;
      }).first;
    }
  }

  @override
  Future<void> deleteProblemChecklist() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateProblemChecklist() {
    // TODO:
    return null;
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
