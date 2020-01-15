import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/integumentary_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/integumentary_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/integumentary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

abstract class IntegumentaryRepository {
  Future<Either<Failure, IntegumentaryModel>> getIntegumentary(int id);
  Future<Either<Failure, bool>> updateIntegumentary(
      IntegumentaryModel integumentary);
  Future<Either<Failure, bool>> addIntegumentary(
      IntegumentaryModel integumentary);

  Future<Either<Failure, List<IntegumentaryLookUpData>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class IntegumentaryRepositoryImpl implements IntegumentaryRepository {
  final IntegumentaryRemoteDataSource integumentaryRemoteDataSource;
  final IntegumentaryLocalDataSource integumentaryLocalDataSource;
  final NetworkInfo networkInfo;

  IntegumentaryRepositoryImpl({
    @required this.integumentaryRemoteDataSource,
    @required this.integumentaryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, IntegumentaryModel>> getIntegumentary(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await integumentaryRemoteDataSource.getIntegumentary(id);
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
  Future<Either<Failure, bool>> updateIntegumentary(
      IntegumentaryModel integumentary) async {
    if (await networkInfo.isConnected) {
      try {
        await integumentaryRemoteDataSource.updateIntegumentary(integumentary);
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
  Future<Either<Failure, bool>> addIntegumentary(
      IntegumentaryModel integumentary) async {
    if (await networkInfo.isConnected) {
      try {
        await integumentaryRemoteDataSource.addIntegumentary(integumentary);
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
  Future<Either<Failure, List<IntegumentaryLookUpData>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await integumentaryRemoteDataSource.getDropDown(dropdownName);
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
        final result = await integumentaryRemoteDataSource.getEncounters(id);
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
