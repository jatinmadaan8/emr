import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/further_evaluation_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/further_evaluation_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/further_evaluation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class FurtherEvaluationRepository {
  Future<Either<Failure, List<FurtherEvaluation>>> getFurtherEvaluation(int id);
  Future<int> addFurtherEvaluation(List<FurtherEvaluation> data, int id);
  Future<Either<Failure, List<GenricDropDown>>> getEvaluationTypes();
}

class FurtherEvaluationRepositoryImpl implements FurtherEvaluationRepository {
  final FurtherEvaluationRemoteDataSource furtherEvaluationRemoteDataSource;
  final FurtherEvaluationLocalDataSource furtherEvaluationLocalDataSource;
  final NetworkInfo networkInfo;

  FurtherEvaluationRepositoryImpl({
    @required this.furtherEvaluationRemoteDataSource,
    @required this.furtherEvaluationLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addFurtherEvaluation(List<FurtherEvaluation> data, int id) async {
    if (await networkInfo.isConnected) {
      try {
        if (id != null) {
          return await furtherEvaluationRemoteDataSource
              .updateFurtherEvaluation(data, id);
        } else {
          return await furtherEvaluationRemoteDataSource.addFurtherEvaluation(
              data, id);
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
  Future<Either<Failure, List<FurtherEvaluation>>> getFurtherEvaluation(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await furtherEvaluationRemoteDataSource.getFurtherEvaluation(id);
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
  Future<Either<Failure, List<GenricDropDown>>> getEvaluationTypes() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await furtherEvaluationRemoteDataSource.getEvaluationTypes();
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
