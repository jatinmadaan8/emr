import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounter.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/patients_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/patients_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/remote/patients_list/get_patients_list_request.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/repository/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientsRemoteDataSource patientsRemoteDataSource;
  final PatientsLocalDataSource patientsLocalDataSource;
  final NetworkInfo networkInfo;

  PatientRepositoryImpl({
    @required this.patientsRemoteDataSource,
    @required this.patientsLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Patient>> addPatient({Patient patient}) {
    // TODO: implement addPatient
    return null;
  }

  @override
  Future<Either<Failure, List<Patient>>> getPatientsList(
      {GetPatientsListRequest request}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientsRemoteDataSource.getPatientsList(request: request);
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
  Future<Either<Failure, List<Encounter>>> getEncounterList(
      int patientId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientsRemoteDataSource.getEncounterList(patientId);
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
