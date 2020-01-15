import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/nutrition_metabolic_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/nutrition_metabolic_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/nutrition_metabolic.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class NutritionMetabolicRepository {
  Future<Either<Failure, NutritionMetabolic>> getNutritionMetabolic(int id);
  Future<int> addNutritionMetabolic(NutritionMetabolic data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricLookupData>>> getLookupData(String type);
  Future<Either<Failure, List<GenricQuestions>>> getNomQuestions();
}

class NutritionMetabolicRepositoryImpl implements NutritionMetabolicRepository {
  final NutritionMetabolicRemoteDataSource nutritionMetabolicRemoteDataSource;
  final NutritionMetabolicLocalDataSource nutritionMetabolicLocalDataSource;
  final NetworkInfo networkInfo;

  NutritionMetabolicRepositoryImpl({
    @required this.nutritionMetabolicRemoteDataSource,
    @required this.nutritionMetabolicLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addNutritionMetabolic(NutritionMetabolic data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await nutritionMetabolicRemoteDataSource
              .updateNutritionMetabolic(data);
        } else {
          return await nutritionMetabolicRemoteDataSource.addNutritionMetabolic(data);
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
  Future<Either<Failure, NutritionMetabolic>> getNutritionMetabolic(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await nutritionMetabolicRemoteDataSource.getNutritionMetabolic(id);
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
        final result = await nutritionMetabolicRemoteDataSource.getEncounters(id);
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
        final result = await nutritionMetabolicRemoteDataSource.getLookupData(type);
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
  Future<Either<Failure, List<GenricQuestions>>> getNomQuestions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await nutritionMetabolicRemoteDataSource.getNomQuestions();
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
