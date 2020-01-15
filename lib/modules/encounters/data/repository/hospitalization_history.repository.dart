import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/hospitalization_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/hospitalization_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/hospitalization_history.dart';

abstract class HospitalizationHistoryRepository {
  Future<Either<Failure, HospitalizationHistoryModel>>
      getHospitalizationHistory(int id);
  Future<Either<Failure, bool>> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);
  Future<Either<Failure, bool>> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory);

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class HospitalizationHistoryRepositoryImpl
    implements HospitalizationHistoryRepository {
  final HospitalizationHistoryRemoteDataSource
      hospitalizationHistoryRemoteDataSource;
  final HospitalizationHistoryLocalDataSource
      hospitalizationHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  HospitalizationHistoryRepositoryImpl({
    @required this.hospitalizationHistoryRemoteDataSource,
    @required this.hospitalizationHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, HospitalizationHistoryModel>>
      getHospitalizationHistory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await hospitalizationHistoryRemoteDataSource
            .getHospitalizationHistory(id);
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
  Future<Either<Failure, bool>> updateHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await hospitalizationHistoryRemoteDataSource
            .updateHospitalizationHistory(hospitalizationHistory);
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
  Future<Either<Failure, bool>> addHospitalizationHistory(
      HospitalizationHistoryModel hospitalizationHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await hospitalizationHistoryRemoteDataSource
            .addHospitalizationHistory(hospitalizationHistory);
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
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await hospitalizationHistoryRemoteDataSource.getEncounters(id);
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
