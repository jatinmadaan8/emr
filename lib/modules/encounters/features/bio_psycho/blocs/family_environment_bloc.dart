import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/family_environment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/family_environment_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class FamilyEnvironmentBloc implements BaseBloc {
  final sectionName = 'RFAMI';
  int modelId;
  final FamilyEnvironmentRepository familyEnvironmentRepo;

  TokenService _tokenService = TokenService();

  FamilyEnvironment familyEnvironmentData = FamilyEnvironment();

  BehaviorSubject<FamilyEnvironment> familyEnvironment =
      BehaviorSubject<FamilyEnvironment>();

  Observable<FamilyEnvironment> get familyEnvironmentObservable =>
      familyEnvironment.stream;

  BehaviorSubject<List<GenricDropDown>> childhoodLifestyle =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get childhoodLifestyleObservable =>
      childhoodLifestyle.stream;

  BehaviorSubject<List<GenricDropDown>> attendance =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get attendanceObservable =>
      attendance.stream;

  BehaviorSubject<List<GenricDropDown>> discipline =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get disciplineObservable =>
      discipline.stream;

  BehaviorSubject<List<GenricDropDown>> movedLifetime =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get movedLifetimeObservable =>
      movedLifetime.stream;

  FamilyEnvironmentBloc({@required this.familyEnvironmentRepo}) {}

  getFamilyEnviroment() async {
    var resultEncounters = await familyEnvironmentRepo
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await familyEnvironmentRepo.getFamilyEnviroment(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          familyEnvironmentData = data,
          familyEnvironment.sink.add(data),
        },
      );
    }
  }

  void addFamilyEnviroment() async {
    familyEnvironmentData.encounterId = _tokenService.selectedEncounterId;
    await familyEnvironmentRepo.addFamilyEnviroment(familyEnvironmentData);
    if (familyEnvironmentData.id == null) {
      getFamilyEnviroment();
    }
  }

  getAttendance() async {
    var result = await familyEnvironmentRepo.getGenricDropDown('Attendance');
    result.fold(
      (Failure failure) => {},
      (data) => {
        attendance.sink.add(data),
      },
    );
  }

  getChildhoodLifestyle() async {
    var result =
        await familyEnvironmentRepo.getGenricDropDown('ChildhoodLifestyle');
    result.fold(
      (Failure failure) => {},
      (data) => {
        childhoodLifestyle.sink.add(data),
      },
    );
  }

  getDiscipline() async {
    var result = await familyEnvironmentRepo.getGenricDropDown('Discipline');
    result.fold(
      (Failure failure) => {},
      (data) => {
        discipline.sink.add(data),
      },
    );
  }

  getMovedLifetime() async {
    var result = await familyEnvironmentRepo.getGenricDropDown('MovedLifetime');
    result.fold(
      (Failure failure) => {},
      (data) => {
        movedLifetime.sink.add(data),
      },
    );
  }

  void initialize() async {
    getAttendance();
    getChildhoodLifestyle();
    getDiscipline();
    getMovedLifetime();
    await getFamilyEnviroment();
  }

  @override
  void dispose() {
    movedLifetime.close();
    discipline.close();
    childhoodLifestyle.close();
    attendance.close();
    familyEnvironment.close();
  }
}
