import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/cardio_vascular.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/cardio_vascular.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class CardioVascularBloc implements BaseBloc {
  static const sectionName = 'RCARD';
  int _modelId;
  CardioVascularModel _cardioVascularModel;

  final CardioVascularRepository cardioVascularRepository;
  TokenService _tokenService = TokenService();

  CardioVascularBloc({@required this.cardioVascularRepository});

  BehaviorSubject<CardioVascularModel> _cardioVascularSubject =
      BehaviorSubject<CardioVascularModel>();
  Observable<CardioVascularModel> get cardioVascularObservable =>
      _cardioVascularSubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<CardioVascularDropDown>> _cardiovascularEdemaSubject =
      BehaviorSubject<List<CardioVascularDropDown>>();
  Observable<List<CardioVascularDropDown>> get cardiovascularEdema =>
      _cardiovascularEdemaSubject.stream;

  BehaviorSubject<List<CardioVascularDropDown>> _cardiovascularQualitySubject =
      BehaviorSubject<List<CardioVascularDropDown>>();
  Observable<List<CardioVascularDropDown>> get cardiovascularQuality =>
      _cardiovascularQualitySubject.stream;

  BehaviorSubject<List<CardioVascularDropDown>> _cardiovascularRhythmSubject =
      BehaviorSubject<List<CardioVascularDropDown>>();
  Observable<List<CardioVascularDropDown>> get cardiovascularRhythm =>
      _cardiovascularRhythmSubject.stream;

  BehaviorSubject<List<CardioVascularDropDown>> _cardiovascularProblemsSubject =
      BehaviorSubject<List<CardioVascularDropDown>>();
  Observable<List<CardioVascularDropDown>> get cardiovascularProblems =>
      _cardiovascularProblemsSubject.stream;

  getCardioVascular() async {
    var resultEncounters = await cardioVascularRepository
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
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
      final result = await cardioVascularRepository.getCardioVascular(_modelId);

      result.fold(
        (failure) => _cardioVascularSubject.sink.addError(failure.message),
        (cardioVascularModel) {
          _cardioVascularModel = cardioVascularModel;
          _cardioVascularSubject.sink.add(cardioVascularModel);
        },
      );
    } else {
      _cardioVascularSubject.sink.add(CardioVascularModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  getCardioVascularEdema() async {
    var result =
        await cardioVascularRepository.getDropDown('CardiovascularEdema');
    result.fold(
      (failure) => _cardiovascularEdemaSubject.sink.addError(failure.message),
      (data) => _cardiovascularEdemaSubject.sink.add(data),
    );
  }

  getCardiovascularQuality() async {
    var result =
        await cardioVascularRepository.getDropDown('CardiovascularQuality');
    result.fold(
      (failure) => _cardiovascularQualitySubject.sink.addError(failure.message),
      (data) => _cardiovascularQualitySubject.sink.add(data),
    );
  }

  getCardiovascularRhythm() async {
    var result =
        await cardioVascularRepository.getDropDown('CardiovascularRhythm');
    result.fold(
      (failure) => _cardiovascularRhythmSubject.sink.addError(failure.message),
      (data) => _cardiovascularRhythmSubject.sink.add(data),
    );
  }

  getCardiovascularProblems() async {
    var result =
        await cardioVascularRepository.getDropDown('CardiovascularProblems');
    result.fold(
      (failure) =>
          _cardiovascularProblemsSubject.sink.addError(failure.message),
      (data) => _cardiovascularProblemsSubject.sink.add(data),
    );
  }

  onSavePressed(CardioVascularModel cardioVascular) async {
    if (_modelId > 0) {
      var result =
          await cardioVascularRepository.updateCardioVascular(cardioVascular);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Cardio Vascular BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await cardioVascularRepository.addCardioVascular(cardioVascular);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Cardio Vascular BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      getCardioVascularEdema(),
      getCardiovascularProblems(),
      getCardiovascularQuality(),
      getCardiovascularRhythm(),
    ]);

    await getCardioVascular();
  }

  @override
  void dispose() {
    _cardioVascularSubject.close();
    _cardiovascularEdemaSubject.close();
    _cardiovascularQualitySubject.close();
    _cardiovascularRhythmSubject.close();
    _cardiovascularRhythmSubject.close();
    _cardiovascularProblemsSubject.close();
  }
}
