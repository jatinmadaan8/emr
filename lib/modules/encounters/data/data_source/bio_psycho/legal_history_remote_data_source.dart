import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/legal_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class LegalHistoryRemoteDataSource {
  Future<LegalHistory> getLegalHistory(int chiefComplaintId);
  Future<int> addLegalHistory(LegalHistory data);
  Future<int> updateLegalHistory(LegalHistory data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricDropDown>> getGenricDropDown(String name);
}

class LegalHistoryRemoteDataSourceImpl implements LegalHistoryRemoteDataSource {
  final HttpService httpService;

  LegalHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<LegalHistory> getLegalHistory(int id) async {
    try {
      return httpService
          .get(path: '/api/LegalHistory/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => LegalHistory.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addLegalHistory(LegalHistory data) {
    try {
      httpService
          .post(url: 'api/LegalHistory', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateLegalHistory(LegalHistory data) {
    try {
      httpService
          .put(
              url: '/api/LegalHistory/' + data.id.toString(),
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
