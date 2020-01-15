import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/self_perception_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/self_perception_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/self_perception.dart';

abstract class SelfPerceptionRepository {
  Future<Either<Failure, SelfPerception>> getSelfPerception(int id);
  Future<int> addSelfPerception(SelfPerception data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class SelfPerceptionRepositoryImpl implements SelfPerceptionRepository {
  final SelfPerceptionRemoteDataSource selfPerceptionRemoteDataSource;
  final SelfPerceptionLocalDataSource selfPerceptionLocalDataSource;
  final NetworkInfo networkInfo;

  SelfPerceptionRepositoryImpl({
    @required this.selfPerceptionRemoteDataSource,
    @required this.selfPerceptionLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addSelfPerception(SelfPerception data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await selfPerceptionRemoteDataSource
              .updateSelfPerception(data);
        } else {
          return await selfPerceptionRemoteDataSource.addSelfPerception(data);
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
  Future<Either<Failure, SelfPerception>> getSelfPerception(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await selfPerceptionRemoteDataSource.getSelfPerception(id);
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
        final result = await selfPerceptionRemoteDataSource.getEncounters(id);
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
