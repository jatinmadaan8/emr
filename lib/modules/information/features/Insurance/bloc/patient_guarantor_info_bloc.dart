import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/insurance.repository.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/repository/other_information.repository.dart';
import 'package:rxdart/rxdart.dart';

class InsuranceBloc implements BaseBloc {
  List<InsuranceModel> _insuranceModel;

  final InsuranceRepository insuranceRepository;
  TokenService _tokenService = TokenService();

  InsuranceBloc({@required this.insuranceRepository});

  BehaviorSubject<List<InsuranceModel>> _insuranceSubject =
      BehaviorSubject<List<InsuranceModel>>();
  Observable<List<InsuranceModel>> get insuranceObservable =>
      _insuranceSubject.stream;

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

  BehaviorSubject<List<GenderNavigation>> _genderSubject = BehaviorSubject<List<GenderNavigation>>();
  Observable<List<GenderNavigation>> get gender => _genderSubject.stream;

  // BehaviorSubject<List<RegistryStatusCodeNavigation>> _registryStatusSubject = BehaviorSubject<List<RegistryStatusCodeNavigation>>();
  // Observable<List<RegistryStatusCodeNavigation>> get registryStatus => _registryStatusSubject.stream;

  BehaviorSubject<List<String>> _relationshipSubject = BehaviorSubject<List<String>>();
  Observable<List<String>> get relationship => _relationshipSubject.stream;
//
 BehaviorSubject<List<PrefferedContactNavigation>> _preferredContactSubject =
     BehaviorSubject<List<PrefferedContactNavigation>>();
 Observable<List<PrefferedContactNavigation>> get preferredContact =>
     _preferredContactSubject.stream;
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

  _getInsurance() async {
    final result = await insuranceRepository
        .getInsurance(_tokenService.selectedPatientId);

    result.fold(
      (failure) => _insuranceSubject.sink.addError(failure.message),
      (insuranceModel) {
        _insuranceModel = insuranceModel;
        _insuranceSubject.sink.add(insuranceModel);
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
    var result = await insuranceRepository.getStates();
    result.fold(
      (failure) => _stateSubject.sink.addError(failure.message),
      (data) => _stateSubject.sink.add(data),
    );
  }

  getGender() async {
    var result = await insuranceRepository.getGender();
    result.fold(
      (failure) => _genderSubject.sink.addError(failure.message),
      (data) => _genderSubject.sink.add(data),
    );
  }

  // getRegistryStatus() async {
  //   var result = await insuranceRepository.getRegistryStatus();
  //   result.fold(
  //     (failure) => _registryStatusSubject.sink.addError(failure.message),
  //     (data) => _registryStatusSubject.sink.add(data),
  //   );
  // }

  getRelationship() async {
    var result = await insuranceRepository.getRelationship();
    result.fold(
      (failure) => _relationshipSubject.sink.addError(failure.message),
      (data) => _relationshipSubject.sink.add(data),
    );
  }

  

 getPrefferedContact() async {
   var result = await insuranceRepository.getPrefferedContact();
   result.fold(
     (failure) => _preferredContactSubject.sink.addError(failure.message),
     (data) => _preferredContactSubject.sink.add(data),
   );
 }

  onSavePressed(InsuranceModel insurance) async {
    var result = await insuranceRepository
        .updateInsurance(insurance);
    result.fold(
      // todo
      (failure) => print(
          "Insurance BLOC : Update Failed ${failure.message.toString()}"),
      (data) => print("Insurance BLOC : Updated " + data.toString()),
    );
  }

  void initialize() async {
    Future.wait(<Future>[
//      _getGender(),
//      _getDefaultProvider(),
//      _getStates(),
//      _getPreferredContact(),
    ]);

    await _getInsurance();
  }

  @override
  void dispose() {
    _insuranceSubject.close();
    _stateSubject.close();
    _genderSubject.close();
    // _registryStatusSubject.close();
    _relationshipSubject.close();
//    _genderSubject.close();
//    _defaultProviderSubject.close();
   _preferredContactSubject.close();
//    _languageSubject.close();
//    _ethnicitySubject.close();
//    _religionSubject.close();
//    _raceSubject.close();
  }
}
