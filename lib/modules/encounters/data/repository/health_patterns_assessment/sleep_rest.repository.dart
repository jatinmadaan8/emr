import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/sleep_rest_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/sleep_rest_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/sleep_rest.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class SleepRestRepository {
  Future<Either<Failure, SleepRest>> getSleepRest(int id);
  Future<int> addSleepRest(SleepRest data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricLookupData>>> getLookupData(String type);
}

class SleepRestRepositoryImpl implements SleepRestRepository {
  final SleepRestRemoteDataSource sleepRestRemoteDataSource;
  final SleepRestLocalDataSource sleepRestLocalDataSource;
  final NetworkInfo networkInfo;

  SleepRestRepositoryImpl({
    @required this.sleepRestRemoteDataSource,
    @required this.sleepRestLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addSleepRest(SleepRest data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await sleepRestRemoteDataSource
              .updateSleepRest(data);
        } else {
          return await sleepRestRemoteDataSource.addSleepRest(data);
        }
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, SleepRest>> getSleepRest(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await sleepRestRemoteDataSource.getSleepRest(id);
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
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await sleepRestRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, List<GenricLookupData>>> getLookupData(String type) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await sleepRestRemoteDataSource.getLookupData(type);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
