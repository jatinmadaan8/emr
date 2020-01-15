import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/social_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/social_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/social_history.dart';

abstract class SocialHistoryRepository {
  Future<Either<Failure, SocialHistoryModel>> getSocialHistory(int id);
  Future<Either<Failure, bool>> updateSocialHistory(
      SocialHistoryModel socialHistory);
  Future<Either<Failure, bool>> addSocialHistory(
      SocialHistoryModel socialHistory);

  Future<Either<Failure, List<MaritalStatus>>> getMaritalStatus();
  Future<Either<Failure, List<SexualActivity>>> getSmokingStatus();
  Future<Either<Failure, List<SexualActivity>>> getSexualActivity();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class SocialHistoryRepositoryImpl implements SocialHistoryRepository {
  final SocialHistoryRemoteDataSource socialHistoryRemoteDataSource;
  final SocialHistoryLocalDataSource socialHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  SocialHistoryRepositoryImpl({
    @required this.socialHistoryRemoteDataSource,
    @required this.socialHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SocialHistoryModel>> getSocialHistory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await socialHistoryRemoteDataSource.getSocialHistory(id);
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
  Future<Either<Failure, bool>> updateSocialHistory(
      SocialHistoryModel socialHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await socialHistoryRemoteDataSource.updateSocialHistory(socialHistory);
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
  Future<Either<Failure, bool>> addSocialHistory(
      SocialHistoryModel socialHistory) async {
    if (await networkInfo.isConnected) {
      try {
        await socialHistoryRemoteDataSource.addSocialHistory(socialHistory);
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
  Future<Either<Failure, List<MaritalStatus>>> getMaritalStatus() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await socialHistoryRemoteDataSource.getMaritalStatus();
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
  Future<Either<Failure, List<SexualActivity>>> getSmokingStatus() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await socialHistoryRemoteDataSource.getSmokingStatus();
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
  Future<Either<Failure, List<SexualActivity>>> getSexualActivity() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await socialHistoryRemoteDataSource.getSexualActivity();
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
        final result = await socialHistoryRemoteDataSource.getEncounters(id);
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
