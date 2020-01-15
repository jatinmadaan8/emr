import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/genitourinary_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/genitourinary_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/genitourinary.dart';

abstract class GenitourinaryRepository {
  Future<Either<Failure, GenitourinaryModel>> getGenitourinary(int id);
  Future<Either<Failure, bool>> updateGenitourinary(
      GenitourinaryModel genitourinary);
  Future<Either<Failure, bool>> addGenitourinary(
      GenitourinaryModel genitourinary);

  Future<Either<Failure, List<GenitourinaryLookUpModel>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class GenitourinaryRepositoryImpl implements GenitourinaryRepository {
  final GenitourinaryRemoteDataSource genitourinaryRemoteDataSource;
  final GenitourinaryLocalDataSource genitourinaryLocalDataSource;
  final NetworkInfo networkInfo;

  GenitourinaryRepositoryImpl({
    @required this.genitourinaryRemoteDataSource,
    @required this.genitourinaryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, GenitourinaryModel>> getGenitourinary(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await genitourinaryRemoteDataSource.getGenitourinary(id);
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
  Future<Either<Failure, bool>> updateGenitourinary(
      GenitourinaryModel genitourinary) async {
    if (await networkInfo.isConnected) {
      try {
        await genitourinaryRemoteDataSource.updateGenitourinary(genitourinary);
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
  Future<Either<Failure, bool>> addGenitourinary(
      GenitourinaryModel genitourinary) async {
    if (await networkInfo.isConnected) {
      try {
        await genitourinaryRemoteDataSource.addGenitourinary(genitourinary);
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
  Future<Either<Failure, List<GenitourinaryLookUpModel>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await genitourinaryRemoteDataSource.getDropDown(dropdownName);
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
        final result = await genitourinaryRemoteDataSource.getEncounters(id);
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
