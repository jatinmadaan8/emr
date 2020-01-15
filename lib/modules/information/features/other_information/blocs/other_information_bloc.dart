import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/other_information.repository.dart';
import 'package:rxdart/rxdart.dart';

class OtherInformationBloc implements BaseBloc {
  List<OtherInformationModel> _otherInformationModel;

  final OtherInformationRepository otherInformationRepository;
  TokenService _tokenService = TokenService();

  OtherInformationBloc({@required this.otherInformationRepository});

  BehaviorSubject<List<OtherInformationModel>> _otherInformationSubject =
      BehaviorSubject<List<OtherInformationModel>>();
  Observable<List<OtherInformationModel>> get otherInformationObservable =>
      _otherInformationSubject.stream;

  // -- drop downs and check boxes ----
//  BehaviorSubject<List<OtherInformationLookUpData>> _genderSubject =
//      BehaviorSubject<List<OtherInformationLookUpData>>();
//  Observable<List<OtherInformationLookUpData>> get gender =>
//      _genderSubject.stream;
//
//  BehaviorSubject<List<DefaultProviderModel>> _defaultProviderSubject =
//      BehaviorSubject<List<DefaultProviderModel>>();
//  Observable<List<DefaultProviderModel>> get defaultProvider =>
//      _defaultProviderSubject.stream;
//
  BehaviorSubject<List<String>> _stateSubject = BehaviorSubject<List<String>>();
  Observable<List<String>> get states => _stateSubject.stream;

  BehaviorSubject<List<PublicityCodeNavigation>> _publicitySubject = BehaviorSubject<List<PublicityCodeNavigation>>();
  Observable<List<PublicityCodeNavigation>> get publicity => _publicitySubject.stream;

  BehaviorSubject<List<RegistryStatusCodeNavigation>> _registryStatusSubject = BehaviorSubject<List<RegistryStatusCodeNavigation>>();
  Observable<List<RegistryStatusCodeNavigation>> get registryStatus => _registryStatusSubject.stream;

  BehaviorSubject<List<String>> _relationshipSubject = BehaviorSubject<List<String>>();
  Observable<List<String>> get relationship => _relationshipSubject.stream;
//
//  BehaviorSubject<List<PreferredPhoneModel>> _preferredPhoneSubject =
//      BehaviorSubject<List<PreferredPhoneModel>>();
//  Observable<List<PreferredPhoneModel>> get preferredPhone =>
//      _preferredPhoneSubject.stream;
//
//  BehaviorSubject<List<String>> _languageSubject =
//      BehaviorSubject<List<String>>();
//  Observable<List<String>> get language => _languageSubject.stream;
//
//  BehaviorSubject<List<String>> _ethnicitySubject =
//      BehaviorSubject<List<String>>();
//  Observable<List<String>> get ethnicity => _ethnicitySubject.stream;
//
//  BehaviorSubject<List<String>> _religionSubject =
//      BehaviorSubject<List<String>>();
//  Observable<List<String>> get religion => _religionSubject.stream;
//
//  BehaviorSubject<List<RaceNavigation>> _raceSubject =
//      BehaviorSubject<List<RaceNavigation>>();
//  Observable<List<RaceNavigation>> get race => _raceSubject.stream;

//  getLanguage() async {
//    var result = await otherInformationRepository.getLanguage();
//    result.fold(
//      (failure) => _languageSubject.sink.addError(failure.message),
//      (data) => _languageSubject.sink.add(data),
//    );
//  }
//
//  getEthnicity() async {
//    var result = await otherInformationRepository.getEthnicity();
//    result.fold(
//      (failure) => _ethnicitySubject.sink.addError(failure.message),
//      (data) => _ethnicitySubject.sink.add(data),
//    );
//  }
//
//  getReligion() async {
//    var result = await otherInformationRepository.getReligion();
//    result.fold(
//      (failure) => _religionSubject.sink.addError(failure.message),
//      (data) => _religionSubject.sink.add(data),
//    );
//  }
//
//  getRace() async {
//    var result = await otherInformationRepository.getRace();
//    result.fold(
//      (failure) => _raceSubject.sink.addError(failure.message),
//      (data) => _raceSubject.sink.add(data),
//    );
//  }

  _getOtherInformation() async {
    final result = await otherInformationRepository
        .getOtherInformation(_tokenService.selectedPatientId);

    result.fold(
      (failure) => _otherInformationSubject.sink.addError(failure.message),
      (otherInformationModel) {
        _otherInformationModel = otherInformationModel;
        _otherInformationSubject.sink.add(otherInformationModel);
      },
    );
  }

//  _getGender() async {
//    var result = await otherInformationRepository.getDropDown('Gender');
//    result.fold(
//      (failure) => _genderSubject.sink.addError(failure.message),
//      (data) => _genderSubject.sink.add(data),
//    );
//  }
//
//  _getDefaultProvider() async {
//    var result = await otherInformationRepository.getDefaultProvider();
//    result.fold(
//      (failure) => _defaultProviderSubject.sink.addError(failure.message),
//      (data) => _defaultProviderSubject.sink.add(data),
//    );
//  }
//
  getStates() async {
    var result = await otherInformationRepository.getStates();
    result.fold(
      (failure) => _stateSubject.sink.addError(failure.message),
      (data) => _stateSubject.sink.add(data),
    );
  }

  getPublicity() async {
    var result = await otherInformationRepository.getPublicity();
    result.fold(
      (failure) => _publicitySubject.sink.addError(failure.message),
      (data) => _publicitySubject.sink.add(data),
    );
  }

  getRegistryStatus() async {
    var result = await otherInformationRepository.getRegistryStatus();
    result.fold(
      (failure) => _registryStatusSubject.sink.addError(failure.message),
      (data) => _registryStatusSubject.sink.add(data),
    );
  }

  getRelationship() async {
    var result = await otherInformationRepository.getRelationship();
    result.fold(
      (failure) => _relationshipSubject.sink.addError(failure.message),
      (data) => _relationshipSubject.sink.add(data),
    );
  }

  
//
//  _getPreferredPhone() async {
//    var result = await otherInformationRepository.getPreferredPhone();
//    result.fold(
//      (failure) => _preferredPhoneSubject.sink.addError(failure.message),
//      (data) => _preferredPhoneSubject.sink.add(data),
//    );
//  }

  onSavePressed(OtherInformationModel otherInformation) async {
    var result = await otherInformationRepository
        .updateOtherInformation(otherInformation);
    result.fold(
      // todo
      (failure) => print(
          "OtherInformation BLOC : Update Failed ${failure.message.toString()}"),
      (data) => print("OtherInformation BLOC : Updated " + data.toString()),
    );
  }

  void initialize() async {
    Future.wait(<Future>[
//      _getGender(),
//      _getDefaultProvider(),
//      _getStates(),
//      _getPreferredPhone(),
    ]);

    await _getOtherInformation();
  }

  @override
  void dispose() {
    _otherInformationSubject.close();
    _stateSubject.close();
    _publicitySubject.close();
    _registryStatusSubject.close();
    _relationshipSubject.close();
//    _genderSubject.close();
//    _defaultProviderSubject.close();
//    _preferredPhoneSubject.close();
//    _languageSubject.close();
//    _ethnicitySubject.close();
//    _religionSubject.close();
//    _raceSubject.close();
  }
}
