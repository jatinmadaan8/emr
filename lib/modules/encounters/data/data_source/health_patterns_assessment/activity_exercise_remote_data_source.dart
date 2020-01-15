
import '../../../../../core/services/http_service.dart';
import '../../../../../core/error/failure.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'dart:convert';

abstract class ActivityNExerciseRemoteDataSource {
  Future<List<ActivityNExerciseMobilityStatusModel>> getMobilityStatus();
  Future<List<ActivityNExerciseAssistiveDevicesModel>> getAssistiveDevices();
  Future<List<ActivityNExerciseLimitationsModel>> getLimitation();
  Future<List<ActivityNExerciseADLsModel>> getADLs();

  Future<List<Encounters>> getEncounters(int id);
  Future<ActivitiesNExercise> getActivitiesAndExercise(int activityId);

  //For Post and Put calls
  Future<int> addActivitiesNExercise(ActivitiesNExercise ae);
  Future<int> updateActivitiesNExercise(ActivitiesNExercise ae);

}


class ActivityNExcerciseRemoteDataSourceImpl implements ActivityNExerciseRemoteDataSource {

  final HttpService httpService;

  ActivityNExcerciseRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<ActivityNExerciseMobilityStatusModel>> getMobilityStatus() async {
    try {
      return httpService
          .get(path: '/api/LookupData/ANEMobilityStatus')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<ActivityNExerciseMobilityStatusModel>.from(data.map((x) {
        return ActivityNExerciseMobilityStatusModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<ActivityNExerciseAssistiveDevicesModel>> getAssistiveDevices() async {
    try {
      return httpService
          .get(path: '/api/LookupData/ANEAssistiveDevices')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<ActivityNExerciseAssistiveDevicesModel>.from(data.map((x) {
        return ActivityNExerciseAssistiveDevicesModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }

    }

  @override
  Future<List<ActivityNExerciseADLsModel>> getADLs() async {
    try {
      return httpService
          .get(path: '/api/LookupData/ANEAdls')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<ActivityNExerciseADLsModel>.from(data.map((x) {
        return ActivityNExerciseADLsModel.fromMap(x);
      })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }

  }

  @override
  Future<List<ActivityNExerciseLimitationsModel>> getLimitation() async {
    try {
      return httpService
          .get(path: '/api/LookupData/ANELimitations')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) => List<ActivityNExerciseLimitationsModel>.from(data.map((x) {
        return ActivityNExerciseLimitationsModel.fromJSON(x);
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
  Future<ActivitiesNExercise> getActivitiesAndExercise(int id) async {
    try {
      return httpService
          .get(path: '/api/ActivityExercise/$id')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      })
          .map((_) => ActivitiesNExercise.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  //For adding and updating new or existing record

  @override
  Future<int> addActivitiesNExercise(ActivitiesNExercise ae) {
    try {
      print(ae.toMap().toString());
      var result = httpService
          .post(url: '/api/ActivityExercise/', encodedJson: jsonEncode(ae.toMap()))
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
  Future<int> updateActivitiesNExercise(ActivitiesNExercise ae) {
    try {
      print(ae.toMap().toString());
      var result = httpService
          .put(
          url: '/api/ActivityExercise/' + ae.id.toString(),
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