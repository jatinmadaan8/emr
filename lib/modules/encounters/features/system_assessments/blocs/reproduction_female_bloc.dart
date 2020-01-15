import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/reproduction_female.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/reproduction_female.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class ReproductionFemaleBloc implements BaseBloc {
  static const sectionName = 'RRFEM';
  int _modelId;
  ReproductionFemaleModel _reproductionFemaleModel;

  final ReproductionFemaleRepository reproductionFemaleRepository;
  TokenService _tokenService = TokenService();

  ReproductionFemaleBloc({@required this.reproductionFemaleRepository});

  BehaviorSubject<ReproductionFemaleModel> _reproductionFemaleSubject =
      BehaviorSubject<ReproductionFemaleModel>();
  Observable<ReproductionFemaleModel> get reproductionFemaleObservable =>
      _reproductionFemaleSubject.stream;

  // -- drop downs and check boxes ----
  BehaviorSubject<List<ReproductionFemaleLookUpData>>
      _reproFemaleProblemsSubject =
      BehaviorSubject<List<ReproductionFemaleLookUpData>>();
  Observable<List<ReproductionFemaleLookUpData>> get reproFemaleProblems =>
      _reproFemaleProblemsSubject.stream;

  BehaviorSubject<List<ReproductionFemaleLookUpDataDescription>>
      _reproFemaleBirthControlTypesSubject =
      BehaviorSubject<List<ReproductionFemaleLookUpDataDescription>>();
  Observable<List<ReproductionFemaleLookUpDataDescription>>
      get birthControlTypes => _reproFemaleBirthControlTypesSubject.stream;

  _getReproductionFemale() async {
    var resultEncounters = await reproductionFemaleRepository
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
          await reproductionFemaleRepository.getReproductionFemale(_modelId);

      result.fold(
        (failure) => _reproductionFemaleSubject.sink.addError(failure.message),
        (reproductionFemaleModel) {
          _reproductionFemaleModel = reproductionFemaleModel;
          _reproductionFemaleSubject.sink.add(reproductionFemaleModel);
        },
      );
    } else {
      _reproductionFemaleSubject.sink.add(ReproductionFemaleModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getReproFemaleProblems() async {
    var result =
        await reproductionFemaleRepository.getDropDown('ReproFemaleProblems');
    result.fold(
      (failure) => _reproFemaleProblemsSubject.sink.addError(failure.message),
      (data) => _reproFemaleProblemsSubject.sink.add(data),
    );
  }

  _getBirthControlTypes() async {
    var result = await reproductionFemaleRepository
        .getDropDownDescription('BirthControlTypes');
    result.fold(
      (failure) =>
          _reproFemaleBirthControlTypesSubject.sink.addError(failure.message),
      (data) => _reproFemaleBirthControlTypesSubject.sink.add(data),
    );
  }

  onSavePressed(ReproductionFemaleModel reproductionFemale) async {
    if (_modelId > 0) {
      var result = await reproductionFemaleRepository
          .updateReproductionFemale(reproductionFemale);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("ReproductionFemale BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await reproductionFemaleRepository
          .addReproductionFemale(reproductionFemale);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("ReproductionFemale BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    await Future.wait(<Future>[
      _getReproFemaleProblems(),
      _getBirthControlTypes(),
    ]);

    await _getReproductionFemale();
  }

  @override
  void dispose() {
    _reproductionFemaleSubject.close();
    _reproFemaleProblemsSubject.close();
    _reproFemaleBirthControlTypesSubject.close();
  }
}
