import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/http_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/nutrition_metabolic.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class NutritionMetabolicRemoteDataSource {
  Future<NutritionMetabolic> getNutritionMetabolic(int id);
  Future<int> addNutritionMetabolic(NutritionMetabolic data);
  Future<int> updateNutritionMetabolic(NutritionMetabolic data);
  Future<List<Encounters>> getEncounters(int id);
  Future<List<GenricLookupData>> getLookupData(String type);
  Future<List<GenricQuestions>> getNomQuestions();
}

class NutritionMetabolicRemoteDataSourceImpl
    implements NutritionMetabolicRemoteDataSource {
  final HttpService httpService;

  NutritionMetabolicRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<NutritionMetabolic> getNutritionMetabolic(int id) async {
    try {
      return httpService
          .get(path: '/api/NutritionalMetabolic/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => NutritionMetabolic.fromMap(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<GenricLookupData>> getLookupData(String type) async {
    try {
      return httpService
          .get(path: '/api/LookupData/$type')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<GenricLookupData>.from(data.map((x) {
                return GenricLookupData.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<GenricQuestions>> getNomQuestions() async {
    try {
      return httpService
          .get(path: '/api/LookupData/NomQuestions')
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
  Future<int> addNutritionMetabolic(NutritionMetabolic data) {
    try {
      var result = httpService
          .post(
              url: 'api/NutritionalMetabolic',
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
  Future<int> updateNutritionMetabolic(NutritionMetabolic data) {
    try {
      var result = httpService
          .put(
              url: '/api/NutritionalMetabolic/${data.id}',
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
