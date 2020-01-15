import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/musculoskeletal.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/musculoskeletal.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class MusculoSkeletalBloc implements BaseBloc {
  static const sectionName = 'RMUSC';
  int _modelId;
  MusculoSkeletalModel _musuloSkeletal;

  final MusculoSkeletalRepository musculoSkeletalRepository;
  TokenService _tokenService = TokenService();

  MusculoSkeletalBloc({@required this.musculoSkeletalRepository});

  BehaviorSubject<MusculoSkeletalModel> _musculoSkeletalSubject =
      BehaviorSubject<MusculoSkeletalModel>();
  Observable<MusculoSkeletalModel> get musculoSkeletalObservable =>
      _musculoSkeletalSubject.stream;

  BehaviorSubject<List<MusculoSkeletalLookUpData>>
      _musculoSkeletalProblemsSubject =
      BehaviorSubject<List<MusculoSkeletalLookUpData>>();
  Observable<List<MusculoSkeletalLookUpData>> get musculoSkeletalProblems =>
      _musculoSkeletalProblemsSubject.stream;

  BehaviorSubject<List<MusculoSkeletalLookUpData>>
      _musculoSkeletalStrengthSubject =
      BehaviorSubject<List<MusculoSkeletalLookUpData>>();
  Observable<List<MusculoSkeletalLookUpData>> get rGripStrength =>
      _musculoSkeletalStrengthSubject.stream;

  Observable<List<MusculoSkeletalLookUpData>> get lGripStrength =>
      _musculoSkeletalStrengthSubject.stream;

  Observable<List<MusculoSkeletalLookUpData>> get rPushStrength =>
      _musculoSkeletalStrengthSubject.stream;

  Observable<List<MusculoSkeletalLookUpData>> get lPushStrength =>
      _musculoSkeletalStrengthSubject.stream;

  _getMusculoSkeletal() async {
    var resultEncounters = await musculoSkeletalRepository
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
      final result =
          await musculoSkeletalRepository.getMusculoSkeletal(_modelId);

      result.fold(
        (failure) => _musculoSkeletalSubject.sink.addError(failure.message),
        (musculoSkeletal) {
          _musuloSkeletal = musculoSkeletal;
          _musculoSkeletalSubject.sink.add(musculoSkeletal);
        },
      );
    } else {
      _musculoSkeletalSubject.sink.add(MusculoSkeletalModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getMusculoSkeletalProblems() async {
    var result =
        await musculoSkeletalRepository.getDropDown('MusculoskeletalProblems');
    result.fold(
      (failure) =>
          _musculoSkeletalProblemsSubject.sink.addError(failure.message),
      (data) => _musculoSkeletalProblemsSubject.sink.add(data),
    );
  }

  _getMusculoskeletalStrength() async {
    var result =
        await musculoSkeletalRepository.getDropDown('MusculoskeletalStrength');
    result.fold(
      (failure) =>
          _musculoSkeletalStrengthSubject.sink.addError(failure.message),
      (data) => _musculoSkeletalStrengthSubject.sink.add(data),
    );
  }

  onSavePressed(MusculoSkeletalModel musculoSkeletal) async {
    if (_modelId > 0) {
      var result = await musculoSkeletalRepository
          .updateMusculoSkeletal(musculoSkeletal);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("MusculoSkeletal BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await musculoSkeletalRepository.addMusculoSkeletal(musculoSkeletal);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("MusculoSkeletal BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getMusculoSkeletalProblems(),
      _getMusculoskeletalStrength(),
    ]);
    await _getMusculoSkeletal();
  }

  @override
  void dispose() {
    _musculoSkeletalSubject.close();
    _musculoSkeletalProblemsSubject.close();
    _musculoSkeletalStrengthSubject.close();
  }
}
