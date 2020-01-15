import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/neuro_sensory.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class NeuroSensoryBloc implements BaseBloc {
  static const sectionName = 'RNEUR';
  int _modelId;
  NeuroSensory _neuroSensory;

  final NeuroSensoryRepository neuroSensoryRepository;
  TokenService _tokenService = TokenService();

  NeuroSensoryBloc({@required this.neuroSensoryRepository});

  BehaviorSubject<NeuroSensory> _neuroSensorySubject =
      BehaviorSubject<NeuroSensory>();
  Observable<NeuroSensory> get neuroSensoryObservable =>
      _neuroSensorySubject.stream;

  BehaviorSubject<List<NeuroDropDown>> _neuroSymptomsSubject =
      BehaviorSubject<List<NeuroDropDown>>();
  Observable<List<NeuroDropDown>> get neuroSymptoms =>
      _neuroSymptomsSubject.stream;

  BehaviorSubject<List<NeuroDropDown>> _neuroOrientedSubject =
      BehaviorSubject<List<NeuroDropDown>>();
  Observable<List<NeuroDropDown>> get neuroOriented =>
      _neuroOrientedSubject.stream;

  BehaviorSubject<List<NeuroDropDown>> _neuroConsciousnessSubject =
      BehaviorSubject<List<NeuroDropDown>>();
  Observable<List<NeuroDropDown>> get neuroConsciousness =>
      _neuroConsciousnessSubject.stream;

  getNeuroSensory() async {
    var resultEncounters = await neuroSensoryRepository
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
      final result = await neuroSensoryRepository.getNeuroSensory(_modelId);

      result.fold(
        (failure) => _neuroSensorySubject.sink.addError(failure.message),
        (neuroSensory) {
          _neuroSensory = neuroSensory;
          _neuroSensorySubject.sink.add(neuroSensory);
        },
      );
    } else {
      _neuroSensorySubject.sink.add(NeuroSensory(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  getNeuroSymptoms() async {
    var result = await neuroSensoryRepository.getDropDown('NeuroSymptoms');
    result.fold(
      (failure) => _neuroSymptomsSubject.sink.addError(failure.message),
      (data) => _neuroSymptomsSubject.sink.add(data),
    );
  }

  getNeuroOriented() async {
    var result = await neuroSensoryRepository.getDropDown('NeuroOriented');
    result.fold(
      (failure) => _neuroOrientedSubject.sink.addError(failure.message),
      (data) => _neuroOrientedSubject.sink.add(data),
    );
  }

  getNeuroConsciousness() async {
    var result = await neuroSensoryRepository.getDropDown('NeuroConsciousness');
    result.fold(
      (failure) => _neuroConsciousnessSubject.sink.addError(failure.message),
      (data) => _neuroConsciousnessSubject.sink.add(data),
    );
  }

  onSavePressed(NeuroSensory neuroSensory) async {
    if (_modelId > 0) {
      var result =
          await neuroSensoryRepository.updateNeuroSensory(neuroSensory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Neuro Sensory BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await neuroSensoryRepository.addNeuroSensory(neuroSensory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Neuro Sensory BLOC : Updated " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      getNeuroSymptoms(),
      getNeuroOriented(),
      getNeuroConsciousness(),
    ]);
    await getNeuroSensory();
  }

  @override
  void dispose() {
    _neuroSensorySubject.close();
    _neuroSymptomsSubject.close();
    _neuroOrientedSubject.close();
    _neuroConsciousnessSubject.close();
  }
}
