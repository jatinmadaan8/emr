


import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';
import '../../../../../core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/activity_exercise_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/activity_exercise_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

//part of activity_exercise;

abstract class ActivityNExerciseRepository {
  Future<Either<Failure, List<ActivityNExerciseMobilityStatusModel>>> getMobilityStatus();
  Future<Either<Failure, List<ActivityNExerciseAssistiveDevicesModel>>> getAssistiveDevices();
  Future<Either<Failure, List<ActivityNExerciseLimitationsModel>>> getLimitations();
  Future<Either<Failure, List<ActivityNExerciseADLsModel>>> getADLs();

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, ActivitiesNExercise>> getActivitiesAndExercise(int id);
  Future<int> addNewActivitiesNExercise(ActivitiesNExercise ae);
  Future<int> updateExistingActivitiesNExercise(ActivitiesNExercise ae);
}


class ActivityNExerciseRepositoryImpl implements ActivityNExerciseRepository {
  final ActivityNExerciseRemoteDataSource activityExerciseRemoteDataSource;
  final ActivityNExerciseLocalDataSource activityExerciseLocalDataSource;
  final NetworkInfo networkInfo;

  ActivityNExerciseRepositoryImpl({
    @required this.activityExerciseRemoteDataSource,
    @required this.activityExerciseLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure,
      List<ActivityNExerciseMobilityStatusModel>>> getMobilityStatus() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource
            .getMobilityStatus();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure,
      List<
          ActivityNExerciseAssistiveDevicesModel>>> getAssistiveDevices() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource
            .getAssistiveDevices();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure, List<ActivityNExerciseADLsModel>>> getADLs() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource.getADLs();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure,
      List<ActivityNExerciseLimitationsModel>>> getLimitations() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource.getLimitation();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }


  @override
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource.getEncounters(id);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, ActivitiesNExercise>> getActivitiesAndExercise(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await activityExerciseRemoteDataSource.getActivitiesAndExercise(id);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<int> addNewActivitiesNExercise(ActivitiesNExercise ae) async {
    if (await networkInfo.isConnected) {
      try {

        return await activityExerciseRemoteDataSource.addActivitiesNExercise(ae);

      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }


  @override
  Future<int> updateExistingActivitiesNExercise(ActivitiesNExercise ae) async {
    if (await networkInfo.isConnected) {
      try {
        return await activityExerciseRemoteDataSource.updateActivitiesNExercise(ae);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}