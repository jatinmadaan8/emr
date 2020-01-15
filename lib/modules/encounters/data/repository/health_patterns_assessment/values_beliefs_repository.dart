import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/values_beliefs_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/values_beliefs_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/values_blefs.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class ValuesBeliefsRepository {
  Future<Either<Failure, ValuesBeliefs>> getTuberculosis(int id);
  Future<int> addValuesBeliefs(ValuesBeliefs data);
  Future<Either<Failure, List<GenricQuestions>>> getVobQuestions();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class ValuesBeliefsRepositoryImpl implements ValuesBeliefsRepository {
  final ValuesBeliefsRemoteDataSource valuesBeliefsRemoteDataSource;
  final ValuesBeliefsLocalDataSource valuesBeliefsLocalDataSource;
  final NetworkInfo networkInfo;

  ValuesBeliefsRepositoryImpl({
    @required this.valuesBeliefsRemoteDataSource,
    @required this.valuesBeliefsLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addValuesBeliefs(ValuesBeliefs data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await valuesBeliefsRemoteDataSource.updateValuesBeliefs(data);
        } else {
          return await valuesBeliefsRemoteDataSource.addValuesBeliefs(data);
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
  Future<Either<Failure, ValuesBeliefs>> getTuberculosis(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await valuesBeliefsRemoteDataSource.getValuesBeliefs(id);
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
  Future<Either<Failure, List<GenricQuestions>>> getVobQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await valuesBeliefsRemoteDataSource.getVobQuestions();
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
        final result = await valuesBeliefsRemoteDataSource.getEncounters(id);
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
