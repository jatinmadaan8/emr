import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/gastro_intestinal_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/gastro_intestinal_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/gastro_intestinal.dart';

abstract class GastroIntestinalRepository {
  Future<Either<Failure, GastroIntestinalModel>> getGastroIntestinal(int id);
  Future<Either<Failure, bool>> updateGastroIntestinal(
      GastroIntestinalModel gastroIntestinalModel);
  Future<Either<Failure, bool>> addGastroIntestinal(
      GastroIntestinalModel gastroIntestinalModel);

  Future<Either<Failure, List<GastroIntestinalDropDown>>> getDropDown(
      String dropDownName);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class GastroIntestinalRepositoryImpl implements GastroIntestinalRepository {
  final GastroIntestinalRemoteDataSource gastroIntestinalRemoteDataSource;
  final GastroIntestinalLocalDataSource gastroIntestinalLocalDataSource;
  final NetworkInfo networkInfo;

  GastroIntestinalRepositoryImpl({
    @required this.gastroIntestinalRemoteDataSource,
    @required this.gastroIntestinalLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, GastroIntestinalModel>> getGastroIntestinal(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await gastroIntestinalRemoteDataSource.getGastroIntestinal(id);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

//  @override
//  Future<Either<Failure, bool>> updateGastroIntestinal(
//      GastroIntestinalModel GastroIntestinal) async {
//    if (await networkInfo.isConnected) {
//      try {
//        await respiratoryRemoteDataSource
//            .updateGastroIntestinal(GastroIntestinal);
//        return Right(true);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }

  @override
  Future<Either<Failure, bool>> updateGastroIntestinal(
      GastroIntestinalModel gastroIntestinal) async {
    if (await networkInfo.isConnected) {
      try {
        await gastroIntestinalRemoteDataSource
            .updateGastroIntestinal(gastroIntestinal);
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
  Future<Either<Failure, bool>> addGastroIntestinal(
      GastroIntestinalModel gastroIntestinal) async {
    if (await networkInfo.isConnected) {
      try {
        await gastroIntestinalRemoteDataSource
            .addGastroIntestinal(gastroIntestinal);
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
  Future<Either<Failure, List<GastroIntestinalDropDown>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await gastroIntestinalRemoteDataSource.getDropDown(dropdownName);
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

  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await gastroIntestinalRemoteDataSource.getEncounters(id);
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
