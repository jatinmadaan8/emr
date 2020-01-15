import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/general_cc.local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/general_cc.remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/pain_assessment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';

import '../models/bio_psycho/problem_checklist.dart';

abstract class GeneralCCRepository {
  Future<Either<Failure, ChiefComplaint>> getChiefComplaint(
      int chiefComplaintId);
  Future<Either<Failure, List<GenricDropDown>>> getDropDown(
      String dropdownName);
  Future<int> addChiefComplaint(ChiefComplaint chiefComplaint);
  Future<int> updateChiefComplaint(ChiefComplaint chiefComplaint);

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, PainAssessment>> getPainAssessment(
      int chiefComplaintId);

  Future<int> addPainAssessment(PainAssessment painAssessment);
  Future<int> updatePainAssessment(PainAssessment painAssessment);
}

class GeneralCCRepositoryImpl implements GeneralCCRepository {
  final GeneralCCRemoteDataSource generalCCRemoteDataSource;
  final GeneralCCLocalDataSource generalCCLocalDataSource;
  final NetworkInfo networkInfo;

  GeneralCCRepositoryImpl({
    @required this.generalCCRemoteDataSource,
    @required this.generalCCLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addChiefComplaint(ChiefComplaint chiefComplaint) async {
    if (await networkInfo.isConnected) {
      try {
        return await generalCCRemoteDataSource
            .addChiefComplaint(chiefComplaint);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, ChiefComplaint>> getChiefComplaint(
      int chiefComplaintId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await generalCCRemoteDataSource.getChiefComplaint(chiefComplaintId);
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
  Future<int> updateChiefComplaint(ChiefComplaint chiefComplaint) async {
    if (await networkInfo.isConnected) {
      try {
        return await generalCCRemoteDataSource
            .updateChiefComplaint(chiefComplaint);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<GenricDropDown>>> getDropDown(
      String dropdownName) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await generalCCRemoteDataSource.getDropDown(dropdownName);
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
  Future<Either<Failure, PainAssessment>> getPainAssessment(
      int chiefComplaintId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await generalCCRemoteDataSource.getPainAssessment(chiefComplaintId);
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
        final result = await generalCCRemoteDataSource.getEncounters(id);
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
  Future<int> addPainAssessment(PainAssessment painAssessment) async {
    if (await networkInfo.isConnected) {
      try {
        return await generalCCRemoteDataSource
            .addPainAssessment(painAssessment);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<int> updatePainAssessment(PainAssessment painAssessment) async {
    if (await networkInfo.isConnected) {
      try {
        return await generalCCRemoteDataSource
            .updatePainAssessment(painAssessment);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
