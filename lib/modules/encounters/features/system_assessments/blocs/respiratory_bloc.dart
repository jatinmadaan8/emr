import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/respiratory.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/respiratory.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class RespiratoryBloc implements BaseBloc {
  static const sectionName = 'RRESP';
  int _modelId;
  RespiratoryModel _respiratoryModel;

  final RespiratoryRepository respiratoryRepository;
  TokenService _tokenService = TokenService();

  RespiratoryBloc({@required this.respiratoryRepository});

  BehaviorSubject<RespiratoryModel> _respiratorySubject =
      BehaviorSubject<RespiratoryModel>();
  Observable<RespiratoryModel> get respiratoryObservable =>
      _respiratorySubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<RespiratoryDropDown>> _rspBreathPatternSubject =
      BehaviorSubject<List<RespiratoryDropDown>>();
  Observable<List<RespiratoryDropDown>> get rspBreathPattern =>
      _rspBreathPatternSubject.stream;

  BehaviorSubject<List<RespiratoryDropDown>> _rspChestAppearenceSubject =
      BehaviorSubject<List<RespiratoryDropDown>>();
  Observable<List<RespiratoryDropDown>> get rspChestAppearence =>
      _rspChestAppearenceSubject.stream;

  BehaviorSubject<List<RespiratoryDropDown>> _rspSymptomsSubject =
      BehaviorSubject<List<RespiratoryDropDown>>();
  Observable<List<RespiratoryDropDown>> get rspSymptoms =>
      _rspSymptomsSubject.stream;

  BehaviorSubject<List<RespiratoryDropDown>> _rspBreathSoundsSubject =
      BehaviorSubject<List<RespiratoryDropDown>>();
  Observable<List<RespiratoryDropDown>> get rspBreathSounds =>
      _rspBreathSoundsSubject.stream;

  _getRespiratory() async {
    var resultEncounters = await respiratoryRepository
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) {},
      (data) {
        var _correspondData = data.where((value) {
          return value.sectionName == sectionName;
        }).toList();

        _modelId = (_correspondData != null && _correspondData.length > 0)
            ? _correspondData.first.id
            : -1;
      },
    );

    if (_modelId > 0) {
      final result = await respiratoryRepository.getRespiratory(_modelId);

      result.fold(
        (failure) => _respiratorySubject.sink.addError(failure.message),
        (respiratoryModel) {
          _respiratoryModel = respiratoryModel;
          _respiratorySubject.sink.add(respiratoryModel);
        },
      );
    } else {
      _respiratorySubject.sink.add(RespiratoryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getRspBreathPattern() async {
    var result = await respiratoryRepository.getDropDown('RspBreathPattern');
    result.fold(
      (failure) => _rspBreathPatternSubject.sink.addError(failure.message),
      (data) => _rspBreathPatternSubject.sink.add(data),
    );
  }

  _getRspChestAppearence() async {
    var result = await respiratoryRepository.getDropDown('RspChestAppearence');
    result.fold(
      (failure) => _rspChestAppearenceSubject.sink.addError(failure.message),
      (data) => _rspChestAppearenceSubject.sink.add(data),
    );
  }

  _getRspSymptoms() async {
    var result = await respiratoryRepository.getDropDown('RspSymptoms');
    result.fold(
      (failure) => _rspSymptomsSubject.sink.addError(failure.message),
      (data) => _rspSymptomsSubject.sink.add(data),
    );
  }

  _getRspBreathSounds() async {
    var result = await respiratoryRepository.getDropDown('RspBreathSounds');
    result.fold(
      (failure) => _rspBreathSoundsSubject.sink.addError(failure.message),
      (data) => _rspBreathSoundsSubject.sink.add(data),
    );
  }

  onSavePressed(RespiratoryModel respiratory) async {
    if (_modelId > 0) {
      var result = await respiratoryRepository.updateRespiratory(respiratory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Respiratory BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await respiratoryRepository.addRespiratory(respiratory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Respiratory BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getRspBreathPattern(),
      _getRspChestAppearence(),
      _getRspSymptoms(),
      _getRspBreathSounds(),
    ]);

    await _getRespiratory();
  }

  @override
  void dispose() {
    _respiratorySubject.close();
    _rspBreathPatternSubject.close();
    _rspChestAppearenceSubject.close();
    _rspSymptomsSubject.close();
    _rspBreathSoundsSubject.close();
  }
}
