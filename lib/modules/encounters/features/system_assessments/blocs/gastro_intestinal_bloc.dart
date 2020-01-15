import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/gastro_intestinal.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/gastro_intestinal.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class GastroIntestinalBloc implements BaseBloc {
  static const sectionName = 'RGAST';
  int _modelId;
  GastroIntestinalModel _gastroIntestinalModel;

  final GastroIntestinalRepository gastroIntestinalRepository;
  TokenService _tokenService = TokenService();

  GastroIntestinalBloc({@required this.gastroIntestinalRepository});

  BehaviorSubject<GastroIntestinalModel> _gastroIntestinalSubject =
      BehaviorSubject<GastroIntestinalModel>();
  Observable<GastroIntestinalModel> get gastroIntestinalObservable =>
      _gastroIntestinalSubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<GastroIntestinalDropDown>> _gastroBowelSubject =
      BehaviorSubject<List<GastroIntestinalDropDown>>();
  Observable<List<GastroIntestinalDropDown>> get gastroBowel =>
      _gastroBowelSubject.stream;

  BehaviorSubject<List<GastroIntestinalDropDown>> _gastroEternalSubject =
      BehaviorSubject<List<GastroIntestinalDropDown>>();
  Observable<List<GastroIntestinalDropDown>> get gastroEternal =>
      _gastroEternalSubject.stream;

  _getGastroIntestinal() async {
    var resultEncounters = await gastroIntestinalRepository
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
      final result =
          await gastroIntestinalRepository.getGastroIntestinal(_modelId);

      result.fold(
        (failure) => _gastroIntestinalSubject.sink.addError(failure.message),
        (gastroIntestinalModel) {
          _gastroIntestinalModel = gastroIntestinalModel;
          _gastroIntestinalSubject.sink.add(gastroIntestinalModel);
        },
      );
    } else {
      _gastroIntestinalSubject.sink.add(GastroIntestinalModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getGastroBowel() async {
    var result = await gastroIntestinalRepository.getDropDown('GastroBowel');
    result.fold(
      (failure) => _gastroBowelSubject.sink.addError(failure.message),
      (data) => _gastroBowelSubject.sink.add(data),
    );
  }

  _getGastroEternal() async {
    var result = await gastroIntestinalRepository.getDropDown('GastroEternal');
    result.fold(
      (failure) => _gastroEternalSubject.sink.addError(failure.message),
      (data) => _gastroEternalSubject.sink.add(data),
    );
  }

  onSavePressed(GastroIntestinalModel gastroIntestinal) async {
    if (_modelId > 0) {
      var result = await gastroIntestinalRepository
          .updateGastroIntestinal(gastroIntestinal);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Gastro Intestinal BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await gastroIntestinalRepository
          .addGastroIntestinal(gastroIntestinal);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Gastro Intestinal BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getGastroEternal(),
      _getGastroBowel(),
    ]);

    await _getGastroIntestinal();
  }

  @override
  void dispose() {
    _gastroIntestinalSubject.close();
    _gastroBowelSubject.close();
    _gastroEternalSubject.close();
  }
}
