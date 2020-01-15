import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/neuro_sensory_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

abstract class NeuroSensoryRepository {
  Future<Either<Failure, NeuroSensory>> getNeuroSensory(int id);
  Future<Either<Failure, bool>> updateNeuroSensory(NeuroSensory neuroSensory);
  Future<Either<Failure, bool>> addNeuroSensory(NeuroSensory neuroSensory);

  Future<Either<Failure, List<NeuroDropDown>>> getDropDown(String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class NeuroSensoryRepositoryImpl implements NeuroSensoryRepository {
  final NeuroSensoryRemoteDataSource neuroSensoryRemoteDataSource;
  final NeuroSensoryLocalDataSource neuroSensoryLocalDataSource;
  final NetworkInfo networkInfo;

  NeuroSensoryRepositoryImpl({
    @required this.neuroSensoryRemoteDataSource,
    @required this.neuroSensoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NeuroSensory>> getNeuroSensory(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await neuroSensoryRemoteDataSource.getNeuroSensory(id);
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
  Future<Either<Failure, bool>> updateNeuroSensory(
      NeuroSensory neuroSensory) async {
    if (await networkInfo.isConnected) {
      try {
        await neuroSensoryRemoteDataSource.updateNeuroSensory(neuroSensory);
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
  Future<Either<Failure, bool>> addNeuroSensory(
      NeuroSensory neuroSensory) async {
    if (await networkInfo.isConnected) {
      try {
        await neuroSensoryRemoteDataSource.addNeuroSensory(neuroSensory);
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
  Future<Either<Failure, List<NeuroDropDown>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await neuroSensoryRemoteDataSource.getDropDown(dropdownName);
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
        final result = await neuroSensoryRemoteDataSource.getEncounters(id);
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
