import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/tuberculosis_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/tuberculosis_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/tuberculosis/tuberculosis.dart';

abstract class TuberculosisRepository {
  Future<Either<Failure, Tuberculosis>> getTuberculosis(int id);
  Future<int> addTuberculosis(Tuberculosis data);
  Future<Either<Failure, List<GenricQuestions>>> getNvTbQuestions();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class TuberculosisRepositoryImpl implements TuberculosisRepository {
  final TuberculosisRemoteDataSource tuberculosisRemoteDataSource;
  final TuberculosisLocalDataSource tuberculosisLocalDataSource;
  final NetworkInfo networkInfo;

  TuberculosisRepositoryImpl({
    @required this.tuberculosisRemoteDataSource,
    @required this.tuberculosisLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addTuberculosis(Tuberculosis data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await tuberculosisRemoteDataSource.updateTuberculosis(data);
        } else {
          return await tuberculosisRemoteDataSource.addTuberculosis(data);
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
  Future<Either<Failure, Tuberculosis>> getTuberculosis(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await tuberculosisRemoteDataSource.getTuberculosis(id);
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
  Future<Either<Failure, List<GenricQuestions>>> getNvTbQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await tuberculosisRemoteDataSource.getNvTbQuestions();
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
        final result = await tuberculosisRemoteDataSource.getEncounters(id);
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
