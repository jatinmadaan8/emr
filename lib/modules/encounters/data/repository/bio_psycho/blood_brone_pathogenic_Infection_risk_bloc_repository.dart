import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/blood_brone_pathogenic_infection_risk_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/bio_psycho/blood_brone_pathogenic_infection_risk_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/blood_brone_pathogenic_infection_risk.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';

abstract class BloodBronePathogenicInfectionRiskRepository {
  Future<Either<Failure, BloodBronePathogenicInfectionRisk>> getBloodBrone(
      int id);
  Future<int> addBloodBrone(BloodBronePathogenicInfectionRisk data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class BloodBronePathogenicInfectionRiskRepositoryImpl
    implements BloodBronePathogenicInfectionRiskRepository {
  final BloodBronePathogenicInfectionRiskRemoteDataSource
      bloodBronePathogenicInfectionRiskRemoteDataSource;
  final BloodBronePathogenicInfectionRiskLocalDataSource
      bloodBronePathogenicInfectionRiskLocalDataSource;
  final NetworkInfo networkInfo;

  BloodBronePathogenicInfectionRiskRepositoryImpl({
    @required this.bloodBronePathogenicInfectionRiskRemoteDataSource,
    @required this.bloodBronePathogenicInfectionRiskLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addBloodBrone(BloodBronePathogenicInfectionRisk data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await bloodBronePathogenicInfectionRiskRemoteDataSource
              .updateBloodBrone(data);
        } else {
          return await bloodBronePathogenicInfectionRiskRemoteDataSource
              .addBloodBrone(data);
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
  Future<Either<Failure, BloodBronePathogenicInfectionRisk>> getBloodBrone(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await bloodBronePathogenicInfectionRiskRemoteDataSource
            .getBloodBrone(id);
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
        final result = await bloodBronePathogenicInfectionRiskRemoteDataSource
            .getEncounters(id);
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
