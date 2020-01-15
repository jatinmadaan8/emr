import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';

import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/surgery_history.dart';
import '../data_source/surgery_history_local_data_source.dart';
import '../data_source/surgery_history_remote_data_source.dart';

abstract class SurgeryHistoryRepository {
  Future<Either<Failure, SurgeryHistoryModel>> getSurgeryHistory(int id);
  Future<Either<Failure, bool>> updateSurgeryHistory(
      SurgeryHistoryModel surgeryHistory);
  Future<Either<Failure, bool>> addSurgeryHistory(
      SurgeryHistoryModel surgeryHistory);

  Future<Either<Failure, List<SurgeryTypesLookupModel>>> getSurgeryTypes();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class SurgeryHistoryRepositoryImpl implements SurgeryHistoryRepository {
  final SurgeryHistoryRemoteDataSource surgeryHistoryRemoteDataSource;
  final SurgeryHistoryLocalDataSource surgeryHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  SurgeryHistoryRepositoryImpl({
    @required this.surgeryHistoryRemoteDataSource,
    @required this.surgeryHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SurgeryHistoryModel>> getSurgeryHistory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await surgeryHistoryRemoteDataSource.getSurgeryHistory(id);
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
  Future<Either<Failure, List<SurgeryTypesLookupModel>>>
      getSurgeryTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await surgeryHistoryRemoteDataSource.getSurgeryTypes();
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
        final result = await surgeryHistoryRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, bool>> addSurgeryHistory(
      SurgeryHistoryModel surgeryHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await surgeryHistoryRemoteDataSource.addSurgeryHistory(surgeryHistory);
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
  Future<Either<Failure, bool>> updateSurgeryHistory(
      SurgeryHistoryModel surgeryHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await surgeryHistoryRemoteDataSource
            .updateSurgeryHistory(surgeryHistory);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
