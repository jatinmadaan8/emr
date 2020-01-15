import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/coping_stress_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/coping_stress_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/coping_stress.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class CopingStressRepository {
  Future<Either<Failure, CopingStress>> getCopingStress(int id);
  Future<int> addCopingStress(CopingStress data);
  Future<Either<Failure, List<GenricQuestions>>> getCosQuestions();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class CopingStressRepositoryImpl implements CopingStressRepository {
  final CopingStressRemoteDataSource copingStressRemoteDataSource;
  final CopingStressLocalDataSource copingStressLocalDataSource;
  final NetworkInfo networkInfo;

  CopingStressRepositoryImpl({
    @required this.copingStressRemoteDataSource,
    @required this.copingStressLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addCopingStress(CopingStress data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await copingStressRemoteDataSource.updateCopingStress(data);
        } else {
          return await copingStressRemoteDataSource.addCopingStress(data);
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
  Future<Either<Failure, CopingStress>> getCopingStress(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await copingStressRemoteDataSource.getCopingStress(id);
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
  Future<Either<Failure, List<GenricQuestions>>> getCosQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await copingStressRemoteDataSource.getCosQuestions();
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
        final result = await copingStressRemoteDataSource.getEncounters(id);
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
