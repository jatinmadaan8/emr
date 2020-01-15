import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/psychiatric_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/psychiatric_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/psychiatric_history.dart';

abstract class PsychiatricHistoryRepository {
  Future<Either<Failure, PsychiatricHistoryModel>> getPsychiatricHistory(
      int id);
  Future<Either<Failure, bool>> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);
  Future<Either<Failure, bool>> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory);

  Future<Either<Failure, List<Disease>>> getDropDown(String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class PsychiatricHistoryRepositoryImpl implements PsychiatricHistoryRepository {
  final PsychiatricHistoryRemoteDataSource psychiatricHistoryRemoteDataSource;
  final PsychiatricHistoryLocalDataSource psychiatricHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  PsychiatricHistoryRepositoryImpl({
    @required this.psychiatricHistoryRemoteDataSource,
    @required this.psychiatricHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PsychiatricHistoryModel>> getPsychiatricHistory(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await psychiatricHistoryRemoteDataSource.getPsychiatricHistory(id);
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
  Future<Either<Failure, bool>> updatePsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await psychiatricHistoryRemoteDataSource
            .updatePsychiatricHistory(psychiatricHistory);
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
  Future<Either<Failure, bool>> addPsychiatricHistory(
      PsychiatricHistoryModel psychiatricHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await psychiatricHistoryRemoteDataSource
            .addPsychiatricHistory(psychiatricHistory);
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
  Future<Either<Failure, List<Disease>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await psychiatricHistoryRemoteDataSource.getDropDown(dropdownName);
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
        final result =
            await psychiatricHistoryRemoteDataSource.getEncounters(id);
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
