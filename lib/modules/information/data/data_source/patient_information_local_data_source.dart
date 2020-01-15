import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';

abstract class PatientInformationLocalDataSource {
  Future<PatientInformationModel> getPatientInformation(int id);
  Future<void> addPatientInformation(
      PatientInformationModel patientInformationModel);
  Future<void> deletePatientInformation();
  Future<void> updatePatientInformation(
      PatientInformationModel patientInformation);

  Future<List<PatientInformationLookUpData>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class PatientInformationLocalDataSourceImpl
    implements PatientInformationLocalDataSource {
  @override
  Future<void> addPatientInformation(
      PatientInformationModel patientInformationModel) {
    // TODO: implement addPatientInformation
    return null;
  }

  @override
  Future<void> deletePatientInformation() {
    // TODO: implement deletePatientInformation
    return null;
  }

  @override
  Future<List<PatientInformationLookUpData>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<PatientInformationModel> getPatientInformation(int id) {
    // TODO: implement getPatientInformation
    return null;
  }

  @override
  Future<void> updatePatientInformation(
      PatientInformationModel patientInformation) {
    // TODO: implement updatePatientInformation
    return null;
  }
}
