import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/support_recovery_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/support_recovery_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/support_recovery.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

abstract class SupportRecoveryRepository {
  Future<Either<Failure, SupportRecovery>> getSupportRecovery(int id);
  Future<int> addSupportRecovery(SupportRecovery data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class SupportRecoveryRepositoryImpl implements SupportRecoveryRepository {
  final SupportRecoveryRemoteDataSource supportRecoveryRemoteDataSource;
  final SupportRecoveryLocalDataSource supportRecoveryLocalDataSource;
  final NetworkInfo networkInfo;

  SupportRecoveryRepositoryImpl({
    @required this.supportRecoveryRemoteDataSource,
    @required this.supportRecoveryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addSupportRecovery(SupportRecovery data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await supportRecoveryRemoteDataSource
              .updateSupportRecovery(data);
        } else {
          return await supportRecoveryRemoteDataSource.addSupportRecovery(data);
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
  Future<Either<Failure, SupportRecovery>> getSupportRecovery(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await supportRecoveryRemoteDataSource.getSupportRecovery(id);
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
        final result = await supportRecoveryRemoteDataSource.getEncounters(id);
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
