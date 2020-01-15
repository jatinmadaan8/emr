import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/substance_use_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/substance_use_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/education_vocation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/substance_use_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class SubstanceUseRepository {
  Future<Either<Failure, SubstanceUseModel>> getSubstanceUse(int id);
  Future<Either<Failure, bool>> updateSubstanceUse(
      SubstanceUseModel substanceUseModel);
  Future<Either<Failure, bool>> addSubstanceUse(
      SubstanceUseModel substanceUseModel);

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<SubstanceUseSelectModel>>> getSelectValues(
      String name);
}

class SubstanceUseRepositoryImpl implements SubstanceUseRepository {
  final SubstanceUseRemoteDataSource substanceUseRemoteDataSource;
  final SubstanceUseLocalDataSource substanceUseLocalDataSource;
  final NetworkInfo networkInfo;

  SubstanceUseRepositoryImpl({
    @required this.substanceUseRemoteDataSource,
    @required this.substanceUseLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, SubstanceUseModel>> getSubstanceUse(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await substanceUseRemoteDataSource.getSubstanceUse(id);
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
        final result = await substanceUseRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, List<SubstanceUseSelectModel>>> getSelectValues(
      String name) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await substanceUseRemoteDataSource.getSelectValues(name);
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
  Future<Either<Failure, bool>> addSubstanceUse(
      SubstanceUseModel substanceUseModel) async {
    if (await networkInfo.isConnected) {
      try {
        await substanceUseRemoteDataSource.addSubstanceUse(substanceUseModel);
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
  Future<Either<Failure, bool>> updateSubstanceUse(
      SubstanceUseModel substanceUseModel) async {
    if (await networkInfo.isConnected) {
      try {
        await substanceUseRemoteDataSource
            .updateSubstanceUse(substanceUseModel);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
