
import '../../../../../core/services/http_service.dart';
import '../../../../../core/error/failure.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/cognitive_perceptual_model.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'dart:convert';

abstract class CognitivePerceptualRemoteDataSource {
  Future<List<CogitivePeceptualCommonModel>> getCommunications();
  Future<List<CogitivePeceptualCommonModel>> getLanguageSpoken();
  Future<List<CogitivePeceptualCommonModel>> getHearings();
  Future<List<CogitivePeceptualCommonModel>> getVision();

  Future<List<Encounters>> getEncounters(int id);
  Future<CognitivePerceptual> getCognitivePerceptual(int activityId);

  //For Post and Put calls
  Future<int> addCognitivePerceptual(CognitivePerceptual ae);
  Future<int> updateCognitivePerceptual(CognitivePerceptual ae);

}


class CognitivePerceptualRemoteDataSourceImpl implements CognitivePerceptualRemoteDataSource {

  final HttpService httpService;

  CognitivePerceptualRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<CogitivePeceptualCommonModel>> getCommunications() async {
    try {
      return httpService
          .get(path: '/api/LookupData/COrPCommunication')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<CogitivePeceptualCommonModel>.from(data.map((x) {
        return CogitivePeceptualCommonModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<CogitivePeceptualCommonModel>> getLanguageSpoken() async {
    try {
      return httpService
          .get(path: '/api/LookupData/COrPLanguageSpoken')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<CogitivePeceptualCommonModel>.from(data.map((x) {
        return CogitivePeceptualCommonModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }

  }

  @override
  Future<List<CogitivePeceptualCommonModel>> getHearings() async {
    try {
      return httpService
          .get(path: '/api/LookupData/COrPHearing')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<CogitivePeceptualCommonModel>.from(data.map((x) {
        return CogitivePeceptualCommonModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }

  }

  @override
  Future<List<CogitivePeceptualCommonModel>> getVision() async {
    try {
      return httpService
          .get(path: '/api/LookupData/COrPVision')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<CogitivePeceptualCommonModel>.from(data.map((x) {
        return CogitivePeceptualCommonModel.fromMap(x);
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
  Future<CognitivePerceptual> getCognitivePerceptual(int id) async {
    try {
      return httpService
          .get(path: '/api/CognitivePerceptual/$id')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      })
          .map((_) => CognitivePerceptual.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  //For adding and updating new or existing record

  @override
  Future<int> addCognitivePerceptual(CognitivePerceptual ae) {
    try {
      print(ae.toMap().toString());
      var result = httpService
          .post(url: '/api/CognitivePerceptual/', encodedJson: jsonEncode(ae.toMap()))
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
  Future<int> updateCognitivePerceptual(CognitivePerceptual ae) {
    try {
      print(ae.toMap().toString());
      var result = httpService
          .put(
          url: '/api/CognitivePerceptual/' + ae.id.toString(),
          encodedJson: jsonEncode(ae.toMap()))
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