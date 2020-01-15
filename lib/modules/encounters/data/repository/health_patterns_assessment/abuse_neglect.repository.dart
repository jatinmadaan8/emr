import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/abuse_neglect_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/abuse_neglect_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/abuse_neglect.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class AbuseNeglectRepository {
  Future<Either<Failure, AbuseNeglect>> getAbuseNeglect(int id);
  Future<int> addAbuseNeglect(AbuseNeglect data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricLookupData>>> getLookupData(String type);
}

class AbuseNeglectRepositoryImpl implements AbuseNeglectRepository {
  final AbuseNeglectRemoteDataSource abuseNeglectRemoteDataSource;
  final AbuseNeglectLocalDataSource abuseNeglectLocalDataSource;
  final NetworkInfo networkInfo;

  AbuseNeglectRepositoryImpl({
    @required this.abuseNeglectRemoteDataSource,
    @required this.abuseNeglectLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addAbuseNeglect(AbuseNeglect data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await abuseNeglectRemoteDataSource
              .updateAbuseNeglect(data);
        } else {
          return await abuseNeglectRemoteDataSource.addAbuseNeglect(data);
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
  Future<Either<Failure, AbuseNeglect>> getAbuseNeglect(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await abuseNeglectRemoteDataSource.getAbuseNeglect(id);
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
        final result = await abuseNeglectRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, List<GenricLookupData>>> getLookupData(String type) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await abuseNeglectRemoteDataSource.getLookupData(type);
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
