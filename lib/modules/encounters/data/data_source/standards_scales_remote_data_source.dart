import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/soa/soa_note.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/standards_scales/standards_scales.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';

abstract class StandardsAndScalesRemoteDataSource {
  Future<List<StandardsAndScales>> getStandardsAndScales();
  Future<int> addStandardsAndScales(AddStandardsAndScale data);
  Future<int> updateStandardsAndScales(StandardsAndScales data);
  Future<List<StandardsAndScalesForm>> getStandardsAndScalesForm(int id);
}

class StandardsAndScalesRemoteDataSourceImpl
    implements StandardsAndScalesRemoteDataSource {
  final HttpService httpService;

  StandardsAndScalesRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<StandardsAndScales>> getStandardsAndScales() async {
    try {
      return httpService
          .get(path: '/api/StandardsAndScales')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<StandardsAndScales>.from(data.map((x) {
                return StandardsAndScales.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addStandardsAndScales(AddStandardsAndScale data) {
    try {
      var result = httpService
          .post(
              url: 'api/StandardsAndScales/addStandardsAndScale',
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
  Future<int> updateStandardsAndScales(StandardsAndScales data) {
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
  Future<List<StandardsAndScalesForm>> getStandardsAndScalesForm(int id) {
    try {
      return httpService
          .get(path: '/api/StandardsAndScales/ByEncounterId/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<StandardsAndScalesForm>.from(data.map((x) {
                return StandardsAndScalesForm.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
