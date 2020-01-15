import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/family_environment.local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/family_environment.remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/family_environment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class FamilyEnvironmentRepository {
  Future<Either<Failure, FamilyEnvironment>> getFamilyEnviroment(int id);
  Future<int> addFamilyEnviroment(FamilyEnvironment data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricDropDown>>> getGenricDropDown(String name);
}

class FamilyEnvironmentRepositoryImpl implements FamilyEnvironmentRepository {
  final FamilyEnvironmentRemoteDataSource familyEnvironmentRemoteDataSource;
  final FamilyEnvironmentLocalDataSource familyEnvironmentLocalDataSource;
  final NetworkInfo networkInfo;

  FamilyEnvironmentRepositoryImpl({
    @required this.familyEnvironmentRemoteDataSource,
    @required this.familyEnvironmentLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addFamilyEnviroment(FamilyEnvironment data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id == null) {
          return await familyEnvironmentRemoteDataSource
              .addFamilyEnviroment(data);
        } else {
          return await familyEnvironmentRemoteDataSource
              .updateFamilyEnviroment(data);
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
  Future<Either<Failure, FamilyEnvironment>> getFamilyEnviroment(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await familyEnvironmentRemoteDataSource.getFamilyEnviroment(id);
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
        final result =
            await familyEnvironmentRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, List<GenricDropDown>>> getGenricDropDown(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await familyEnvironmentRemoteDataSource.getGenricDropDown(name);
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
