import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/soa/soa_note.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';

abstract class SoaNoteRemoteDataSource {
  Future<SoaNote> getSoaNote(int chiefComplaintId);
  Future<int> addSoaNote(SoaNote data);
  Future<int> updateSoaNote(SoaNote data);
  Future<List<Encounters>> getEncounters(int id);
}

class SoaNoteRemoteDataSourceImpl implements SoaNoteRemoteDataSource {
  final HttpService httpService;

  SoaNoteRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<SoaNote> getSoaNote(int id) async {
    try {
      return httpService
          .get(path: '/api/EncounterSOA/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => SoaNote.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addSoaNote(SoaNote data) {
    try {
      var result = httpService
          .post(url: 'api/EncounterSOA', encodedJson: jsonEncode(data.toMap()))
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
  Future<int> updateSoaNote(SoaNote data) {
    try {
      var result = httpService
          .put(
              url: '/api/EncounterSOA/' + data.id.toString(),
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
