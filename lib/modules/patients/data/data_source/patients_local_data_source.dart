import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';

abstract class PatientsLocalDataSource {
  Future<List<Patient>> getPatientsList();
  Future<void> addPatient();
}

class PatientsLocalDataSourceImpl implements PatientsLocalDataSource {
  @override
  Future<List<Patient>> getPatientsList() {
    // TODO: implement getPatientsList
    return null;
  }

  @override
  Future<void> addPatient() {
    // TODO: implement addPatient
    return null;
  }
}
