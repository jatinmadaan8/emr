import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/pain_assessment.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/general_cc.repository.dart';
import 'package:rxdart/rxdart.dart';

class PainAssessmentBloc implements BaseBloc {
  static const sectionName = 'RPAIN';
  int painAssessmentId;
  final GeneralCCRepository generalCCRepo;
  TokenService _tokenService = TokenService();

  BehaviorSubject<List<GenricDropDown>> painDuration =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painDurationListObservable =>
      painDuration.stream;

  BehaviorSubject<List<GenricDropDown>> painLocation =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painLocationListObservable =>
      painLocation.stream;

  BehaviorSubject<List<GenricDropDown>> painScale =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painScaleObservable => painScale.stream;

  BehaviorSubject<List<GenricDropDown>> painType =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painTypeObservable => painType.stream;

  BehaviorSubject<List<GenricDropDown>> painQuality =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painQualityObservable =>
      painQuality.stream;

  BehaviorSubject<List<GenricDropDown>> painManagementReferral =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get painManagementReferralObservable =>
      painManagementReferral.stream;

  BehaviorSubject<PainAssessment> painAssessment =
      BehaviorSubject<PainAssessment>();

  Observable<PainAssessment> get painAssessmentObservable =>
      painAssessment.stream;

  PainAssessment painAssessmentData = PainAssessment();

  PainAssessmentBloc({@required this.generalCCRepo});

  getPainDuration() async {
    var result = await generalCCRepo.getDropDown('GetPainDuration');
    result.fold(
      (Failure failure) => {},
      (data) => {painDuration.sink.add(data)},
    );
  }

  getPainLocation() async {
    var result = await generalCCRepo.getDropDown('GetPainLocation');
    result.fold(
      (Failure failure) => {},
      (data) => {painLocation.sink.add(data)},
    );
  }

  getPainScale() async {
    var result = await generalCCRepo.getDropDown('GetPainScale');
    result.fold(
      (Failure failure) => {},
      (data) => {painScale.sink.add(data)},
    );
  }

  getPainType() async {
    var result = await generalCCRepo.getDropDown('GetPainType');
    result.fold(
      (Failure failure) => {},
      (data) => {painType.sink.add(data)},
    );
  }

  getPainQuality() async {
    var result = await generalCCRepo.getDropDown('GetPainQuality');
    result.fold(
      (Failure failure) => {},
      (data) => {painQuality.sink.add(data)},
    );
  }

  getPainManagementReferral() async {
    var result = await generalCCRepo.getDropDown('PainManagementReferral');
    result.fold(
      (Failure failure) => {},
      (data) => {painManagementReferral.sink.add(data)},
    );
  }

  getPainAssessmentHistory() async {
    var resultEncounters =
        await generalCCRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        painAssessmentId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (painAssessmentId > 0) {
      var result = await generalCCRepo.getPainAssessment(painAssessmentId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          painAssessmentData = data,
          painAssessment.sink.add(data),
        },
      );
    }
  }

  savePainAssessment() async {
    painAssessmentData.encounterId = _tokenService.selectedEncounterId;
    if (painAssessmentData.id == null) {
      var result = await generalCCRepo.addPainAssessment(painAssessmentData);
      getPainAssessmentHistory();
    }
    if (painAssessmentData.id != null) {
      var result = generalCCRepo.updatePainAssessment(painAssessmentData);
      var s = result;
    }
  }

  void initialize() async {
    getPainQuality();
    getPainType();
    getPainScale();
    getPainLocation();
    getPainDuration();
    getPainManagementReferral();
    await getPainAssessmentHistory();
  }

  @override
  void dispose() {
    painDuration.close();
    painScale.close();
    painType.close();
    painQuality.close();
    painManagementReferral.close();
    painAssessment.close();
    painQuality.close();
  }
}
