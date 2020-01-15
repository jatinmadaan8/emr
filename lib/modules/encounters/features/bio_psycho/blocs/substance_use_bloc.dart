import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/substance_use_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/substance_use_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class SubstanceUseBloc implements BaseBloc {
  static const String sectionName = 'RSUBS';
  static const String PhysicalHealth = "PhysicalHealth";
  static const String DaysConfigSubstance = "DaysConfigSubstance";
  static const String AddictedDrugs = "DaysConfigSubstance";

  int modelId;
  final SubstanceUseRepository substanceUseRepository;

  TokenService _tokenService = TokenService();

  SubstanceUseModel substanceUseData = SubstanceUseModel();

  BehaviorSubject<SubstanceUseModel> _substanceUseSubject =
      BehaviorSubject<SubstanceUseModel>();

  Observable<SubstanceUseModel> get substanceUseObservable =>
      _substanceUseSubject.stream;

  // ------
  BehaviorSubject<List<SubstanceUseSelectModel>> _physicalHealthSubject =
      BehaviorSubject<List<SubstanceUseSelectModel>>();

  Observable<List<SubstanceUseSelectModel>> get physicalHealth =>
      _physicalHealthSubject.stream;

  BehaviorSubject<List<SubstanceUseSelectModel>> _addictedDrugsSubject =
      BehaviorSubject<List<SubstanceUseSelectModel>>();

  Observable<List<SubstanceUseSelectModel>> get addictedDrugs =>
      _addictedDrugsSubject.stream;

  BehaviorSubject<List<SubstanceUseSelectModel>> _daysConfigSubstanceSubject =
      BehaviorSubject<List<SubstanceUseSelectModel>>();

  Observable<List<SubstanceUseSelectModel>> get daysConfigSubstance =>
      _daysConfigSubstanceSubject.stream;

  SubstanceUseBloc({@required this.substanceUseRepository});

  _getSubstanceUse() async {
    var resultEncounters = await substanceUseRepository
        .getEncounters(_tokenService.selectedEncounterId);

    resultEncounters.fold(
      (Failure failure) => {},
      (data) {
        modelId = (data.indexWhere((d) => d.sectionName == sectionName) > 0)
            ? data.firstWhere((value) {
                return value.sectionName == sectionName;
              }).id
            : 0;
      },
    );
    if (modelId != null && modelId > 0) {
      var result = await substanceUseRepository.getSubstanceUse(modelId);
      result.fold(
        (Failure failure) =>
            _substanceUseSubject.sink.addError(failure.message),
        (data) {
          substanceUseData = data;
          _substanceUseSubject.sink.add(data);
        },
      );
    } else {
      _substanceUseSubject.sink.add(SubstanceUseModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getPhysicalHealth() async {
    var result = await substanceUseRepository.getSelectValues(PhysicalHealth);
    result.fold(
      (Failure failure) =>
          _physicalHealthSubject.sink.addError(failure.message),
      (data) => _physicalHealthSubject.sink.add(data),
    );
  }

  _getAddictedDrugs() async {
    var result = await substanceUseRepository.getSelectValues(AddictedDrugs);
    result.fold(
      (Failure failure) => _addictedDrugsSubject.sink.addError(failure.message),
      (data) => _addictedDrugsSubject.sink.add(data),
    );
  }

  _getDaysConfigSubstance() async {
    var result =
        await substanceUseRepository.getSelectValues(DaysConfigSubstance);
    result.fold(
      (Failure failure) =>
          _daysConfigSubstanceSubject.sink.addError(failure.message),
      (data) => _daysConfigSubstanceSubject.sink.add(data),
    );
  }

  void initialize() async {
    await Future.wait(<Future>[
      _getPhysicalHealth(),
      _getAddictedDrugs(),
      _getDaysConfigSubstance(),
    ]);

    await _getSubstanceUse();
  }

  onSavePressed(SubstanceUseModel substanceUseModel) async {
    if (modelId > 0) {
      var result =
          await substanceUseRepository.updateSubstanceUse(substanceUseModel);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("SubstanceUse BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await substanceUseRepository.addSubstanceUse(substanceUseModel);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("SubstanceUse BLOC : Added " + data.toString()),
      );
    }
  }

  @override
  void dispose() {
    _substanceUseSubject.close();
    _physicalHealthSubject.close();
    _addictedDrugsSubject.close();
    _daysConfigSubstanceSubject.close();
  }
}
