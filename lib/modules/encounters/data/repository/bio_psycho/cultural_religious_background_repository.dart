import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/cultural_religious_background_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/cultural_religious_background_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/cultural_religious_rackground.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';

abstract class CulturalReligiousBackgroundRepository {
  Future<Either<Failure, CulturalReligiousBackground>>
      getCulturalReligiousBackground(int id);
  Future<int> addCulturalReligiousBackground(CulturalReligiousBackground data);
  Future<Either<Failure, List<GenricQuestions>>> getNvTbQuestions();
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<Language>>> getLanguage();
}

class CulturalReligiousBackgroundRepositoryImpl
    implements CulturalReligiousBackgroundRepository {
  final CulturalReligiousBackgroundRemoteDataSource
      culturalReligiousBackgroundDataSource;
  final CulturalReligiousBackgroundLocalDataSource
      culturalReligiousBackgroundLocalDataSource;
  final NetworkInfo networkInfo;

  CulturalReligiousBackgroundRepositoryImpl({
    @required this.culturalReligiousBackgroundDataSource,
    @required this.culturalReligiousBackgroundLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addCulturalReligiousBackground(
      CulturalReligiousBackground data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await culturalReligiousBackgroundDataSource
              .updateCulturalReligiousBackground(data);
        } else {
          return await culturalReligiousBackgroundDataSource
              .addCulturalReligiousBackground(data);
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
  Future<Either<Failure, CulturalReligiousBackground>>
      getCulturalReligiousBackground(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await culturalReligiousBackgroundDataSource
            .getCulturalReligiousBackground(id);
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
        final result =
            await culturalReligiousBackgroundDataSource.getNvTbQuestions();
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
            await culturalReligiousBackgroundDataSource.getEncounters(id);
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
  Future<Either<Failure, List<Language>>> getLanguage() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await culturalReligiousBackgroundDataSource.getLanguage();
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
