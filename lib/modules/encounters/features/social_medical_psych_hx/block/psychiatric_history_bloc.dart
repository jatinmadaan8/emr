import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/psychiatric_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/psychiatric_history.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class PsychiatricHistoryBloc implements BaseBloc {
  static const sectionName = 'RPSYC';
  int _modelId;
  PsychiatricHistoryModel _psychiatricHistory;

  final PsychiatricHistoryRepository psychiatricHistoryRepository;
  TokenService _tokenService = TokenService();

  PsychiatricHistoryBloc({@required this.psychiatricHistoryRepository});

  BehaviorSubject<PsychiatricHistoryModel> _psychiatricHistorySubject =
      BehaviorSubject<PsychiatricHistoryModel>();
  Observable<PsychiatricHistoryModel> get psychiatricHistoryObservable =>
      _psychiatricHistorySubject.stream;

  BehaviorSubject<List<Disease>> _psychiatricHistoryDiseasesSubject =
      BehaviorSubject<List<Disease>>();
  Observable<List<Disease>> get psychiatricHistoryDiseases =>
      _psychiatricHistoryDiseasesSubject.stream;

  getPsychiatricHistory() async {
    var resultEncounters = await psychiatricHistoryRepository
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
      print("Exists and get data");
      final result =
          await psychiatricHistoryRepository.getPsychiatricHistory(_modelId);

      result.fold(
        (failure) => _psychiatricHistorySubject.sink.addError(failure.message),
        (psychiatricHistory) {
          _psychiatricHistory = psychiatricHistory;
          _psychiatricHistorySubject.sink.add(psychiatricHistory);
        },
      );
    } else {
      _psychiatricHistorySubject.sink.add(PsychiatricHistoryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getPsychiatricHistoryDiseases() async {
    var result = await psychiatricHistoryRepository
        .getDropDown('PsychiatricHistoryDiseases');
    result.fold(
      (failure) =>
          _psychiatricHistoryDiseasesSubject.sink.addError(failure.message),
      (data) => _psychiatricHistoryDiseasesSubject.sink.add(data),
    );
  }

  onSavePressed(PsychiatricHistoryModel psychiatricHistory) async {
    if (_modelId > 0) {
      var result = await psychiatricHistoryRepository
          .updatePsychiatricHistory(psychiatricHistory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("PsychiatricHistory BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await psychiatricHistoryRepository
          .addPsychiatricHistory(psychiatricHistory);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("PsychiatricHistory BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getPsychiatricHistoryDiseases(),
    ]);
    await getPsychiatricHistory();
  }

  @override
  void dispose() {
    _psychiatricHistorySubject.close();
    _psychiatricHistoryDiseasesSubject.close();
  }
}
