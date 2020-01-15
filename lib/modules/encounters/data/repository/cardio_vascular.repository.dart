import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/cardio_vascular_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/cardio_vascular_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/cardio_vascular.dart';

abstract class CardioVascularRepository {
  Future<Either<Failure, CardioVascularModel>> getCardioVascular(int id);
  Future<Either<Failure, bool>> updateCardioVascular(
    CardioVascularModel cardioVascular,
  );
  Future<Either<Failure, bool>> addCardioVascular(
    CardioVascularModel cardioVascular,
  );
  Future<Either<Failure, List<CardioVascularDropDown>>> getDropDown(
    String dropDownName,
  );
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class CardioVascularRepositoryImpl implements CardioVascularRepository {
  final CardioVascularRemoteDataSource cardioVascularRemoteDataSource;
  final CardioVascularLocalDataSource cardioVascularLocalDataSource;
  final NetworkInfo networkInfo;

  CardioVascularRepositoryImpl({
    @required this.cardioVascularRemoteDataSource,
    @required this.cardioVascularLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, CardioVascularModel>> getCardioVascular(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await cardioVascularRemoteDataSource.getCardioVascular(id);
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
  Future<Either<Failure, bool>> updateCardioVascular(
      CardioVascularModel cardioVascular) async {
    if (await networkInfo.isConnected) {
      try {
        await cardioVascularRemoteDataSource
            .updateCardioVascular(cardioVascular);
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
  Future<Either<Failure, bool>> addCardioVascular(
      CardioVascularModel cardioVascular) async {
    if (await networkInfo.isConnected) {
      try {
        await cardioVascularRemoteDataSource.addCardioVascular(cardioVascular);
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
  Future<Either<Failure, List<CardioVascularDropDown>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await cardioVascularRemoteDataSource.getDropDown(dropdownName);
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
        final result = await cardioVascularRemoteDataSource.getEncounters(id);
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
