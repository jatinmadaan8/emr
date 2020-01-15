import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_female_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/reproduction_female_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_female.dart';

abstract class ReproductionFemaleRepository {
  Future<Either<Failure, ReproductionFemaleModel>> getReproductionFemale(
      int id);
  Future<Either<Failure, bool>> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemale);
  Future<Either<Failure, bool>> addReproductionFemale(
      ReproductionFemaleModel reproductionFemale);

  Future<Either<Failure, List<ReproductionFemaleLookUpData>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<ReproductionFemaleLookUpDataDescription>>>
      getDropDownDescription(String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class ReproductionFemaleRepositoryImpl implements ReproductionFemaleRepository {
  final ReproductionFemaleRemoteDataSource reproductionFemaleRemoteDataSource;
  final ReproductionFemaleLocalDataSource reproductionFemaleLocalDataSource;
  final NetworkInfo networkInfo;

  ReproductionFemaleRepositoryImpl({
    @required this.reproductionFemaleRemoteDataSource,
    @required this.reproductionFemaleLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReproductionFemaleModel>> getReproductionFemale(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await reproductionFemaleRemoteDataSource.getReproductionFemale(id);
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
  Future<Either<Failure, bool>> updateReproductionFemale(
      ReproductionFemaleModel reproductionFemale) async {
    if (await networkInfo.isConnected) {
      try {
        await reproductionFemaleRemoteDataSource
            .updateReproductionFemale(reproductionFemale);
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
  Future<Either<Failure, bool>> addReproductionFemale(
      ReproductionFemaleModel reproductionFemale) async {
    if (await networkInfo.isConnected) {
      try {
        await reproductionFemaleRemoteDataSource
            .addReproductionFemale(reproductionFemale);
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
  Future<Either<Failure, List<ReproductionFemaleLookUpData>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await reproductionFemaleRemoteDataSource.getDropDown(dropdownName);
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
  Future<Either<Failure, List<ReproductionFemaleLookUpDataDescription>>>
      getDropDownDescription(String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await reproductionFemaleRemoteDataSource
            .getDropDownDescription(dropdownName);
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
        final result =
            await reproductionFemaleRemoteDataSource.getEncounters(id);
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
