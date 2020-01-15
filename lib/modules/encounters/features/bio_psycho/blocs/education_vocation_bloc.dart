import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/education_vocation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/education_vocation_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class EducationVocationBloc implements BaseBloc {
  final sectionName = 'REDUC';
  int modelId;
  final EducationVocationRepository educationVocationRepo;

  TokenService _tokenService = TokenService();

  EducationVocation educationVocationData = EducationVocation();

  List<EdunvocHelpneedfor> edunvocHelpneedfor = [];

  BehaviorSubject<EducationVocation> educationVocation =
      BehaviorSubject<EducationVocation>();

  Observable<EducationVocation> get educationVocationObservable =>
      educationVocation.stream;

  BehaviorSubject<List<GenricDropDown>> attendance =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get attendanceObservable =>
      attendance.stream;

  BehaviorSubject<List<GenricDropDown>> grades =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get gradesObservable => grades.stream;

  BehaviorSubject<List<GenricDropDown>> helpNeededFor =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get helpNeededForObservable =>
      helpNeededFor.stream;

  EducationVocationBloc({@required this.educationVocationRepo}) {}

  getEducationVocation() async {
    var resultEncounters = await educationVocationRepo
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
      var result = await educationVocationRepo.getEducationVocation(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          educationVocationData = data,
          educationVocation.sink.add(data),
        },
      );

      if (educationVocationData.edunvocHelpneedfor != null &&
          educationVocationData.edunvocHelpneedfor.length > 0) {
        edunvocHelpneedfor = educationVocationData.edunvocHelpneedfor;
      }
    }
  }

  void addEducationVocation() async {
    educationVocationData.encounterId = _tokenService.selectedEncounterId;
    educationVocationData.edunvocHelpneedfor = edunvocHelpneedfor;
    await educationVocationRepo.addEducationVocation(educationVocationData);
    if (educationVocationData.id == null) {
      getEducationVocation();
    }
  }

  getAttendance() async {
    var result = await educationVocationRepo.getGenricDropDown('Attendance');
    result.fold(
      (Failure failure) => {},
      (data) => {
        attendance.sink.add(data),
      },
    );
  }

  getHelpNeededFor() async {
    var result = await educationVocationRepo.getGenricDropDown('HelpNeededFor');
    result.fold(
      (Failure failure) => {},
      (data) => {
        helpNeededFor.sink.add(data),
      },
    );
  }

  getGrades() async {
    var result = await educationVocationRepo.getGenricDropDown('Grades');
    result.fold(
      (Failure failure) => {},
      (data) => {
        grades.sink.add(data),
      },
    );
  }

  bool checkValue(GenricDropDown value) {
    var currentValue = false;
    edunvocHelpneedfor.forEach((d) {
      if (d.needId == value.id) {
        currentValue = true;
      }
    });
    return currentValue;
  }

  void setValueForEvaluation(GenricDropDown value) {
    bool isEsist = false;
    EdunvocHelpneedfor cuurrentTub = EdunvocHelpneedfor();
    if (edunvocHelpneedfor.length > 0) {
      edunvocHelpneedfor.forEach((d) {
        if (d.needId == value.id) {
          isEsist = true;
          cuurrentTub = d;
        }
      });
    }

    if (!isEsist) {
      cuurrentTub.needId = value.id;
      cuurrentTub.encounterId = _tokenService.selectedEncounterId;
      edunvocHelpneedfor.add(cuurrentTub);
    } else {
      edunvocHelpneedfor.remove(cuurrentTub);
    }
  }

  void initialize() async {
    getAttendance();
    getHelpNeededFor();
    getGrades();
    await getEducationVocation();
  }

  @override
  void dispose() {
    educationVocation.close();
    helpNeededFor.close();
    grades.close();
    attendance.close();
  }
}
