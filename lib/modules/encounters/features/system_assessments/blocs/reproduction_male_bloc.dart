import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_male.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/reproduction_male.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class ReproductionMaleBloc implements BaseBloc {
  static const sectionName = 'RMALE';
  int _modelId;
  ReproductionMaleModel _reproductionMaleModel;

  final ReproductionMaleRepository reproductionMaleRepository;
  TokenService _tokenService = TokenService();

  ReproductionMaleBloc({@required this.reproductionMaleRepository});

  BehaviorSubject<ReproductionMaleModel> _reproductionMaleSubject =
      BehaviorSubject<ReproductionMaleModel>();
  Observable<ReproductionMaleModel> get reproductionMaleObservable =>
      _reproductionMaleSubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<ReproductionMaleLookUpData>> _reproMaleProblemsSubject =
      BehaviorSubject<List<ReproductionMaleLookUpData>>();
  Observable<List<ReproductionMaleLookUpData>> get reproMaleProblems =>
      _reproMaleProblemsSubject.stream;

  _getReproductionMale() async {
    var resultEncounters = await reproductionMaleRepository
        .getEncounters(_tokenService.selectedEncounterId);

    print(_tokenService.selectedEncounterId);

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
          await reproductionMaleRepository.getReproductionMale(_modelId);

      result.fold(
        (failure) => _reproductionMaleSubject.sink.addError(failure.message),
        (reproductionMaleModel) {
          _reproductionMaleModel = reproductionMaleModel;
          _reproductionMaleSubject.sink.add(reproductionMaleModel);
        },
      );
    } else {
      _reproductionMaleSubject.sink.add(ReproductionMaleModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getReproMaleProblems() async {
    var result =
        await reproductionMaleRepository.getDropDown('ReproMaleProblems');
    result.fold(
      (failure) => _reproMaleProblemsSubject.sink.addError(failure.message),
      (data) => _reproMaleProblemsSubject.sink.add(data),
    );
  }

  onSavePressed(ReproductionMaleModel reproductionMale) async {
    if (_modelId > 0) {
      var result = await reproductionMaleRepository
          .updateReproductionMale(reproductionMale);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("ReproductionMale BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await reproductionMaleRepository
          .addReproductionMale(reproductionMale);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("ReproductionMale BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getReproMaleProblems(),
    ]);

    await _getReproductionMale();
  }

  @override
  void dispose() {
    _reproductionMaleSubject.close();
    _reproMaleProblemsSubject.close();
  }
}
