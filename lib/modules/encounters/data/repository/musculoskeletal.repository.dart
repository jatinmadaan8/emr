import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/musculoskeletal_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/musculoskeletal_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/musculoskeletal.dart';

abstract class MusculoSkeletalRepository {
  Future<Either<Failure, MusculoSkeletalModel>> getMusculoSkeletal(int id);
  Future<Either<Failure, bool>> updateMusculoSkeletal(
      MusculoSkeletalModel musculoSkeletal);
  Future<Either<Failure, bool>> addMusculoSkeletal(
      MusculoSkeletalModel musculoSkeletal);

  Future<Either<Failure, List<MusculoSkeletalLookUpData>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class MusculoSkeletalRepositoryImpl implements MusculoSkeletalRepository {
  final MusculoSkeletalRemoteDataSource musculoSkeletalRemoteDataSource;
  final MusculoSkeletalLocalDataSource musculoSkeletalLocalDataSource;
  final NetworkInfo networkInfo;

  MusculoSkeletalRepositoryImpl({
    @required this.musculoSkeletalRemoteDataSource,
    @required this.musculoSkeletalLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, MusculoSkeletalModel>> getMusculoSkeletal(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await musculoSkeletalRemoteDataSource.getMusculoSkeletal(id);
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
  Future<Either<Failure, bool>> updateMusculoSkeletal(
      MusculoSkeletalModel musculoSkeletal) async {
    if (await networkInfo.isConnected) {
      try {
        await musculoSkeletalRemoteDataSource
            .updateMusculoSkeletal(musculoSkeletal);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> addMusculoSkeletal(
      MusculoSkeletalModel musculoSkeletal) async {
    if (await networkInfo.isConnected) {
      try {
        await musculoSkeletalRemoteDataSource
            .addMusculoSkeletal(musculoSkeletal);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<MusculoSkeletalLookUpData>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await musculoSkeletalRemoteDataSource.getDropDown(dropdownName);
        print(result);
        return Right(result);
      } catch (e) {
        print(e);
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
        final result = await musculoSkeletalRemoteDataSource.getEncounters(id);
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
