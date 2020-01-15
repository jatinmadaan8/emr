import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_male_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_male_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';

abstract class ReproductionMaleRepository {
  Future<Either<Failure, ReproductionMaleModel>> getReproductionMale(int id);
  Future<Either<Failure, bool>> updateReproductionMale(
      ReproductionMaleModel reproductionMale);
  Future<Either<Failure, bool>> addReproductionMale(
      ReproductionMaleModel reproductionMale);

  Future<Either<Failure, List<ReproductionMaleLookUpData>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class ReproductionMaleRepositoryImpl implements ReproductionMaleRepository {
  final ReproductionMaleRemoteDataSource reproductionMaleRemoteDataSource;
  final ReproductionMaleLocalDataSource reproductionMaleLocalDataSource;
  final NetworkInfo networkInfo;

  ReproductionMaleRepositoryImpl({
    @required this.reproductionMaleRemoteDataSource,
    @required this.reproductionMaleLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReproductionMaleModel>> getReproductionMale(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await reproductionMaleRemoteDataSource.getReproductionMale(id);
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
  Future<Either<Failure, bool>> updateReproductionMale(
      ReproductionMaleModel reproductionMale) async {
    if (await networkInfo.isConnected) {
      try {
        await reproductionMaleRemoteDataSource
            .updateReproductionMale(reproductionMale);
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
  Future<Either<Failure, bool>> addReproductionMale(
      ReproductionMaleModel reproductionMale) async {
    if (await networkInfo.isConnected) {
      try {
        await reproductionMaleRemoteDataSource
            .addReproductionMale(reproductionMale);
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
  Future<Either<Failure, List<ReproductionMaleLookUpData>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await reproductionMaleRemoteDataSource.getDropDown(dropdownName);
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
        final result = await reproductionMaleRemoteDataSource.getEncounters(id);
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
