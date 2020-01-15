import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/respiratory_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/respiratory_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/respiratory.dart';

abstract class RespiratoryRepository {
  Future<Either<Failure, RespiratoryModel>> getRespiratory(int id);
  Future<Either<Failure, bool>> updateRespiratory(RespiratoryModel respiratory);
  Future<Either<Failure, bool>> addRespiratory(RespiratoryModel respiratory);

  Future<Either<Failure, List<RespiratoryDropDown>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class RespiratoryRepositoryImpl implements RespiratoryRepository {
  final RespiratoryRemoteDataSource respiratoryRemoteDataSource;
  final RespiratoryLocalDataSource respiratoryLocalDataSource;
  final NetworkInfo networkInfo;

  RespiratoryRepositoryImpl({
    @required this.respiratoryRemoteDataSource,
    @required this.respiratoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, RespiratoryModel>> getRespiratory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await respiratoryRemoteDataSource.getRespiratory(id);
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
  Future<Either<Failure, bool>> updateRespiratory(
      RespiratoryModel respiratory) async {
    if (await networkInfo.isConnected) {
      try {
        await respiratoryRemoteDataSource.updateRespiratory(respiratory);
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
  Future<Either<Failure, bool>> addRespiratory(
      RespiratoryModel respiratory) async {
    if (await networkInfo.isConnected) {
      try {
        await respiratoryRemoteDataSource.addRespiratory(respiratory);
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
  Future<Either<Failure, List<RespiratoryDropDown>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await respiratoryRemoteDataSource.getDropDown(dropdownName);
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
        final result = await respiratoryRemoteDataSource.getEncounters(id);
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
