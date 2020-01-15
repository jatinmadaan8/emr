import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/integumentary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/integumentary.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/neuro_sensory.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class IntegumentaryBloc implements BaseBloc {
  static const sectionName = 'RINTE';
  int _modelId;
  IntegumentaryModel _integumentary;

  final IntegumentaryRepository integumentaryRepository;
  TokenService _tokenService = TokenService();

  IntegumentaryBloc({@required this.integumentaryRepository});

  BehaviorSubject<IntegumentaryModel> _integumentarySubject =
      BehaviorSubject<IntegumentaryModel>();
  Observable<IntegumentaryModel> get integumentaryObservable =>
      _integumentarySubject.stream;

  BehaviorSubject<List<IntegumentaryLookUpData>> _skinColorSubject =
      BehaviorSubject<List<IntegumentaryLookUpData>>();
  Observable<List<IntegumentaryLookUpData>> get skinColor =>
      _skinColorSubject.stream;

  BehaviorSubject<List<IntegumentaryLookUpData>> _skinTempSubject =
      BehaviorSubject<List<IntegumentaryLookUpData>>();
  Observable<List<IntegumentaryLookUpData>> get skinTemp =>
      _skinTempSubject.stream;

  BehaviorSubject<List<IntegumentaryLookUpData>> _skinTurgorSubject =
      BehaviorSubject<List<IntegumentaryLookUpData>>();
  Observable<List<IntegumentaryLookUpData>> get skinTurgor =>
      _skinTurgorSubject.stream;

  BehaviorSubject<List<IntegumentaryLookUpData>> _skinConditionSubject =
      BehaviorSubject<List<IntegumentaryLookUpData>>();
  Observable<List<IntegumentaryLookUpData>> get skinCondition =>
      _skinConditionSubject.stream;

  _getIntegumentary() async {
    var resultEncounters = await integumentaryRepository
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
      final result = await integumentaryRepository.getIntegumentary(_modelId);

      result.fold(
        (failure) => _integumentarySubject.sink.addError(failure.message),
        (integumentary) {
          _integumentary = integumentary;
          _integumentarySubject.sink.add(integumentary);
        },
      );
    } else {
      _integumentarySubject.sink.add(IntegumentaryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getSkinColor() async {
    var result = await integumentaryRepository.getDropDown('SkinColor');
    result.fold(
      (failure) => _skinColorSubject.sink.addError(failure.message),
      (data) => _skinColorSubject.sink.add(data),
    );
  }

  _getSkinTemp() async {
    var result = await integumentaryRepository.getDropDown('SkinTemp');
    result.fold(
      (failure) => _skinTempSubject.sink.addError(failure.message),
      (data) => _skinTempSubject.sink.add(data),
    );
  }

  _getSkinTurgor() async {
    var result = await integumentaryRepository.getDropDown('SkinTurgor');
    result.fold(
      (failure) => _skinTurgorSubject.sink.addError(failure.message),
      (data) => _skinTurgorSubject.sink.add(data),
    );
  }

  _getSkinCondition() async {
    var result = await integumentaryRepository.getDropDown('SkinCondition');
    result.fold(
      (failure) => _skinConditionSubject.sink.addError(failure.message),
      (data) => _skinConditionSubject.sink.add(data),
    );
  }

  onSavePressed(IntegumentaryModel integumentary) async {
    if (_modelId > 0) {
      var result =
          await integumentaryRepository.updateIntegumentary(integumentary);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Integumentary BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await integumentaryRepository.addIntegumentary(integumentary);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Integumentary BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getSkinColor(),
      _getSkinTemp(),
      _getSkinTurgor(),
      _getSkinCondition(),
    ]);
    await _getIntegumentary();
  }

  @override
  void dispose() {
    _integumentarySubject.close();
    _skinColorSubject.close();
    _skinTempSubject.close();
    _skinTurgorSubject.close();
    _skinConditionSubject.close();
  }
}
