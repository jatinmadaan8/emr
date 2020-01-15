import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';

import '../../models/bio_psycho/problem_checklist.dart';
import '../../data_source/bio_psycho/problem_checklist_remote_data_source.dart';
import '../../data_source/bio_psycho/problem_checklist_local_data_source.dart';

abstract class ProblemChecklistRepository {
  Future<Either<Failure, ProblemChecklist>> getProblemChecklist(int id);

  Future<int> addProblemChecklist(ProblemChecklist problemChecklist);

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<Psychostress>>> getPsychosocialStressors();
}

class ProblemChecklistRepositoryImpl implements ProblemChecklistRepository {
  final ProblemChecklistRemoteDataSource problemChecklistRemoteDataSource;
  final ProblemChecklistLocalDataSource problemChecklistLocalDataSource;
  final NetworkInfo networkInfo;

  ProblemChecklistRepositoryImpl({
    @required this.problemChecklistRemoteDataSource,
    @required this.problemChecklistLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addProblemChecklist(ProblemChecklist problemChecklist) async {
    if (await networkInfo.isConnected) {
      try {
        return await problemChecklistRemoteDataSource
            .addProblemChecklist(problemChecklist);
      } catch (e) {
        print(e);
        return 0;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<Psychostress>>> getPsychosocialStressors() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await problemChecklistRemoteDataSource.getPsychosocialStressors();
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
  Future<Either<Failure, ProblemChecklist>> getProblemChecklist(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await problemChecklistRemoteDataSource.getProblemChecklist(id);
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
        final result = await problemChecklistRemoteDataSource.getEncounters(id);
        return Right(result);
      } catch (e) {
        print(e);
        //return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
