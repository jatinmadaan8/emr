
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/cognitive_perceptual_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/health_patterns_assessment/cognitive_perceptual_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/cognitive_perceptual_model.dart';
import '../../../../../core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

//part of activity_exercise;

abstract class CogniitivePeceptualRepository {
  Future<Either<Failure, List<CogitivePeceptualCommonModel>>> getCommunication();
  Future<Either<Failure, List<CogitivePeceptualCommonModel>>> getLangSpoken();
  Future<Either<Failure, List<CogitivePeceptualCommonModel>>> getHearing();
  Future<Either<Failure, List<CogitivePeceptualCommonModel>>> getVision();

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, CognitivePerceptual>> getCognitivePerceptual(int id);
  Future<int> addNewCognitivePerceptual(CognitivePerceptual ae);
  Future<int> updateExistingCognitivePerceptual(CognitivePerceptual ae);
}


class CogniitivePeceptualRepositoryImpl implements CogniitivePeceptualRepository {
  final CognitivePerceptualRemoteDataSource cognitivePerceptualRemoteDataSource;
  final CognitivePerceptualLocalDataSource cognitivePerceptualLocalDataSource;
  final NetworkInfo networkInfo;

  CogniitivePeceptualRepositoryImpl({
    @required this.cognitivePerceptualRemoteDataSource,
    @required this.cognitivePerceptualLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure,
      List<CogitivePeceptualCommonModel>>> getCommunication() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource
            .getCommunications();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure,
      List<
          CogitivePeceptualCommonModel>>> getLangSpoken() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource
            .getLanguageSpoken();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure, List<CogitivePeceptualCommonModel>>> getHearing() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource.getHearings();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }

  @override
  Future<Either<Failure,
      List<CogitivePeceptualCommonModel>>> getVision() async {
    // TODO: implement getMobilityStatus
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource.getVision();
        return Right(result);
      } catch (e) {
        print("Thrown Error $e");
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
  }


  @override
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource.getEncounters(id);
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
  Future<Either<Failure, CognitivePerceptual>> getCognitivePerceptual(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await cognitivePerceptualRemoteDataSource.getCognitivePerceptual(id);
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
  Future<int> addNewCognitivePerceptual(CognitivePerceptual ae) async {
    if (await networkInfo.isConnected) {
      try {

        return await cognitivePerceptualRemoteDataSource.addCognitivePerceptual(ae);

      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }


  @override
  Future<int> updateExistingCognitivePerceptual(CognitivePerceptual ae) async {
    if (await networkInfo.isConnected) {
      try {
        return await cognitivePerceptualRemoteDataSource.updateCognitivePerceptual(ae);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}