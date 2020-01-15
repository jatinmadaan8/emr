import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/cultural_religious_rackground.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class CulturalReligiousBackgroundRemoteDataSource {
  Future<CulturalReligiousBackground> getCulturalReligiousBackground(
      int chiefComplaintId);
  Future<int> addCulturalReligiousBackground(CulturalReligiousBackground data);
  Future<int> updateCulturalReligiousBackground(
      CulturalReligiousBackground data);
  Future<List<GenricQuestions>> getNvTbQuestions();
  Future<List<Encounters>> getEncounters(int id);
  Future<List<Language>> getLanguage();
}

class CulturalReligiousBackgroundRemoteDataSourceImpl
    implements CulturalReligiousBackgroundRemoteDataSource {
  final HttpService httpService;

  CulturalReligiousBackgroundRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<CulturalReligiousBackground> getCulturalReligiousBackground(
      int id) async {
    try {
      return httpService
          .get(path: '/api/Culturalandreligious/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => CulturalReligiousBackground.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> addCulturalReligiousBackground(CulturalReligiousBackground data) {
    try {
      var result = httpService
          .post(
              url: 'api/Culturalandreligious',
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
  Future<int> updateCulturalReligiousBackground(
      CulturalReligiousBackground data) {
    try {
      var result = httpService
          .put(
              url: '/api/Culturalandreligious/' + data.id.toString(),
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
  Future<List<GenricQuestions>> getNvTbQuestions() {
    try {
      return httpService
          .get(path: '/api/LookupData/CulturalandreligiousOutlook')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<GenricQuestions>.from(data.map((x) {
                return GenricQuestions.fromMap(x);
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
  Future<List<Language>> getLanguage() {
    try {
      return httpService
          .get(path: '/api/LookupData/Language')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<Language>.from(data.map((x) {
                return Language.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
