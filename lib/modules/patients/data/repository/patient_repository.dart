import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounter.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/remote/patients_list/get_patients_list_request.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';

abstract class PatientRepository {
  /// Fetch patients from either web api or local database
  /// on data success, this method returns [List] of [Patient] and,
  /// on error, this will return, [Failure]
  Future<Either<Failure, List<Patient>>> getPatientsList({
    @required GetPatientsListRequest request,
  });

  /// Add patients via either web api or local database
  /// on error, this will return, [Failure]
  Future<Either<Failure, Patient>> addPatient({@required Patient patient});

  Future<Either<Failure, List<Encounter>>> getEncounterList(int patientId);
}
