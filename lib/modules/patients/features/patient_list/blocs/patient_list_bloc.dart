import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounter.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/features/bio_psycho/screens/problem_check_list.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/data_source/remote/patients_list/get_patients_list_request.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/models/patient.dart';
import 'package:practiceinsights_emr_provider/modules/patients/data/repository/patient_repository.dart';
import 'package:rxdart/rxdart.dart';

class PatientListBloc implements BaseBloc {
  final PatientRepository patientsListRepo;
  BehaviorSubject<List<Patient>> subject = BehaviorSubject<List<Patient>>();

  Observable<List<Patient>> get patientsListObservable => subject.stream;
  PatientListBloc({@required this.patientsListRepo});

  BehaviorSubject<List<Encounter>> encounter =
      BehaviorSubject<List<Encounter>>();
  Observable<List<Encounter>> get encounterListObservable => encounter.stream;

  TokenService _tokenService = TokenService();
  int pageSize = 100;
  int page = 0;
  bool isLoading = false;
  getPatientsList(String filter) async {
    isLoading = false;
    final result = await patientsListRepo.getPatientsList(
      request: GetPatientsListRequest(
        page: page,
        pageSize: pageSize,
        showMyPateints: true,
        filter: Filter(any: filter),
        sortBy: null,
        sortOrderAsc: false,
      ),
    );
    result.fold(
      (Failure failure) => subject.sink.addError(failure.message),
      (data) => subject.sink.add(data),
    );
  }

  Function filterChange(String value) {
    getPatientsList(value);
  }

  getEncounters(Patient selectedPatient, BuildContext context) async {
    isLoading = true;
    var result = await patientsListRepo.getEncounterList(selectedPatient.id);
    isLoading = false;
    result.fold((Failure failure) => encounter.sink.addError(failure.message),
        (data) {
      _tokenService.encounters = data;
      _tokenService.selectedPatient = selectedPatient;
      _tokenService.selectedEncounterId = _tokenService.encounters[0].id;
    });
    if (_tokenService.encounters != null && _tokenService.encounters.length > 0)
      Navigator.of(context).pushNamed(ProblemCheckListScreen.routeName);
  }

  @override
  void dispose() {
    subject.close();
  }
}
