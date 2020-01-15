import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/education_vocation_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/education_vocation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

abstract class EducationVocationRepository {
  Future<Either<Failure, EducationVocation>> getEducationVocation(int id);
  Future<int> addEducationVocation(EducationVocation data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<GenricDropDown>>> getGenricDropDown(String name);
}

class EducationVocationRepositoryImpl implements EducationVocationRepository {
  final EducationVocationRemoteDataSource educationVocationRemoteDataSource;
  final EducationVocationLocalDataSource educationVocationLocalDataSource;
  final NetworkInfo networkInfo;

  EducationVocationRepositoryImpl({
    @required this.educationVocationRemoteDataSource,
    @required this.educationVocationLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addEducationVocation(EducationVocation data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await educationVocationRemoteDataSource
              .updateEducationVocation(data);
        } else {
          return await educationVocationRemoteDataSource
              .addEducationVocation(data);
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
  Future<Either<Failure, EducationVocation>> getEducationVocation(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await educationVocationRemoteDataSource.getEducationVocation(id);
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
        final result =
            await educationVocationRemoteDataSource.getEncounters(id);
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
            await educationVocationRemoteDataSource.getGenricDropDown(name);
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
