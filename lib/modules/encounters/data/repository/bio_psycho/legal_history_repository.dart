import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/legal_history_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/legal_history_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/legal_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class LegalHistoryRepository {
  Future<Either<Failure, LegalHistory>> getLegalHistory(int id);
  Future<int> addLegalHistory(LegalHistory data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricDropDown>>> getGenricDropDown(String name);
}

class LegalHistoryRepositoryImpl implements LegalHistoryRepository {
  final LegalHistoryRemoteDataSource legalHistoryRemoteDataSource;
  final LegalHistoryLocalDataSource legalHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  LegalHistoryRepositoryImpl({
    @required this.legalHistoryRemoteDataSource,
    @required this.legalHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addLegalHistory(LegalHistory data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await legalHistoryRemoteDataSource.updateLegalHistory(data);
        } else {
          return await legalHistoryRemoteDataSource.addLegalHistory(data);
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
  Future<Either<Failure, LegalHistory>> getLegalHistory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await legalHistoryRemoteDataSource.getLegalHistory(id);
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
        final result = await legalHistoryRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, List<GenricDropDown>>> getGenricDropDown(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await legalHistoryRemoteDataSource.getGenricDropDown(name);
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
