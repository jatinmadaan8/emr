import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/patient_information.repository.dart';
import 'package:rxdart/rxdart.dart';

class PatientInformationBloc implements BaseBloc {
  PatientInformationModel patientInformationModel;

  final PatientInformationRepository patientInformationRepository;
  TokenService _tokenService = TokenService();

  PatientInformationBloc({@required this.patientInformationRepository});

  BehaviorSubject<PatientInformationModel> _patientInformationSubject =
      BehaviorSubject<PatientInformationModel>();
  Observable<PatientInformationModel> get patientInformationObservable =>
      _patientInformationSubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<PatientInformationLookUpData>> _genderSubject =
      BehaviorSubject<List<PatientInformationLookUpData>>();
  Observable<List<PatientInformationLookUpData>> get gender =>
      _genderSubject.stream;

  BehaviorSubject<List<BillType>> _billTypeSubject =
      BehaviorSubject<List<BillType>>();
  Observable<List<BillType>> get billType => _billTypeSubject.stream;

  BehaviorSubject<List<ReferralSources>> _referralSourcesSubject =
      BehaviorSubject<List<ReferralSources>>();
  Observable<List<ReferralSources>> get referralSources =>
      _referralSourcesSubject.stream;

  BehaviorSubject<List<DefaultProviderModel>> _defaultProviderSubject =
      BehaviorSubject<List<DefaultProviderModel>>();
  Observable<List<DefaultProviderModel>> get defaultProvider =>
      _defaultProviderSubject.stream;

  BehaviorSubject<List<String>> _stateSubject = BehaviorSubject<List<String>>();
  Observable<List<String>> get states => _stateSubject.stream;

  BehaviorSubject<String> _imageSubject = BehaviorSubject<String>();
  Observable<String> get image => _imageSubject.stream;

  BehaviorSubject<int> _uploadSubject = BehaviorSubject<int>();
  Observable<int> get uploadImageStatus => _uploadSubject.stream;

  BehaviorSubject<List<PreferredPhoneModel>> _preferredPhoneSubject =
      BehaviorSubject<List<PreferredPhoneModel>>();
  Observable<List<PreferredPhoneModel>> get preferredPhone =>
      _preferredPhoneSubject.stream;

  BehaviorSubject<List<String>> _languageSubject =
      BehaviorSubject<List<String>>();
  Observable<List<String>> get language => _languageSubject.stream;

  BehaviorSubject<List<String>> _ethnicitySubject =
      BehaviorSubject<List<String>>();
  Observable<List<String>> get ethnicity => _ethnicitySubject.stream;

  BehaviorSubject<List<String>> _religionSubject =
      BehaviorSubject<List<String>>();
  Observable<List<String>> get religion => _religionSubject.stream;

  BehaviorSubject<List<RaceNavigation>> _raceSubject =
      BehaviorSubject<List<RaceNavigation>>();
  Observable<List<RaceNavigation>> get race => _raceSubject.stream;

  getLanguage() async {
    var result = await patientInformationRepository.getLanguage();
    result.fold(
      (failure) => _languageSubject.sink.addError(failure.message),
      (data) => _languageSubject.sink.add(data),
    );
  }

  getEthnicity() async {
    var result = await patientInformationRepository.getEthnicity();
    result.fold(
      (failure) => _ethnicitySubject.sink.addError(failure.message),
      (data) => _ethnicitySubject.sink.add(data),
    );
  }

  getReligion() async {
    var result = await patientInformationRepository.getReligion();
    result.fold(
      (failure) => _religionSubject.sink.addError(failure.message),
      (data) => _religionSubject.sink.add(data),
    );
  }

  getRace() async {
    var result = await patientInformationRepository.getRace();
    result.fold(
      (failure) => _raceSubject.sink.addError(failure.message),
      (data) => _raceSubject.sink.add(data),
    );
  }

  void getImage() async {
    var result = await patientInformationRepository
        .getImage(_tokenService.selectedPatientId);
    result.fold(
      (failure) => _imageSubject.sink.addError(failure.message),
      (data) => _imageSubject.sink.add(data),
    );
  }

  _getPatientInformation() async {
    final result = await patientInformationRepository
        .getPatientInformation(_tokenService.selectedPatientId);

    result.fold(
      (failure) => _patientInformationSubject.sink.addError(failure.message),
      (patientInformationModel) {
        patientInformationModel = patientInformationModel;
        _patientInformationSubject.sink.add(patientInformationModel);
      },
    );
  }

  _getGender() async {
    var result = await patientInformationRepository.getGender();
    result.fold(
      (failure) => _genderSubject.sink.addError(failure.message),
      (data) => _genderSubject.sink.add(data),
    );
  }

  _getDefaultProvider() async {
    var result = await patientInformationRepository.getDefaultProvider();
    result.fold(
      (failure) => _defaultProviderSubject.sink.addError(failure.message),
      (data) => _defaultProviderSubject.sink.add(data),
    );
  }

  _getStates() async {
    var result = await patientInformationRepository.getStates();
    result.fold(
      (failure) => _stateSubject.sink.addError(failure.message),
      (data) => _stateSubject.sink.add(data),
    );
  }

  _getPreferredPhone() async {
    var result = await patientInformationRepository.getPreferredPhone();
    result.fold(
      (failure) => _preferredPhoneSubject.sink.addError(failure.message),
      (data) => _preferredPhoneSubject.sink.add(data),
    );
  }

  uploadImage(String imageBase64) async {
    var result = await patientInformationRepository.uploadImage(
        imageBase64, _tokenService.selectedPatientId);
    result.fold(
      (failure) => _uploadSubject.sink.addError(failure.message),
      (data) => _uploadSubject.sink.add(data),
    );
  }

  onSavePressed(PatientInformationModel patientInformation) async {
    var result = await patientInformationRepository
        .updatePatientInformation(patientInformation);
    result.fold(
      // todo
      (failure) => print(
          "PatientInformation BLOC : Update Failed ${failure.message.toString()}"),
      (data) => print("PatientInformation BLOC : Updated " + data.toString()),
    );
  }

  _getReferralSources() async {
    var result = await patientInformationRepository.getReferralSources();
    result.fold(
      (failure) => _referralSourcesSubject.sink.addError(failure.message),
      (data) => _referralSourcesSubject.sink.add(data),
    );
  }

  _getBillType() async {
    var result = await patientInformationRepository.getBillType();
    result.fold(
      (failure) => _billTypeSubject.sink.addError(failure.message),
      (data) => _billTypeSubject.sink.add(data),
    );
  }

  void initialize() async {
    Future.wait(<Future>[
      _getGender(),
      _getDefaultProvider(),
      _getStates(),
      _getPreferredPhone(),
      _getReferralSources(),
      _getBillType(),
    ]);

    await _getPatientInformation();
  }

  @override
  void dispose() {
    _patientInformationSubject.close();
    _genderSubject.close();
    _defaultProviderSubject.close();
    _stateSubject.close();
    _preferredPhoneSubject.close();
    _languageSubject.close();
    _ethnicitySubject.close();
    _religionSubject.close();
    _raceSubject.close();
    _imageSubject.close();
    _uploadSubject.close();
    _referralSourcesSubject.close();
    _billTypeSubject.close();
  }
}
