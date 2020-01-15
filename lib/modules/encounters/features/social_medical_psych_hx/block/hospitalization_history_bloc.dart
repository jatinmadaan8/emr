import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/hospitalization_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/hospitalization_history.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class HospitalizationHistoryBloc implements BaseBloc {
  static const sectionName = 'RHOSP';
  int _modelId;
  HospitalizationHistoryModel _hospitalizationHistory;

  final HospitalizationHistoryRepository hospitalizationHistoryRepository;
  TokenService _tokenService = TokenService();

  HospitalizationHistoryBloc({@required this.hospitalizationHistoryRepository});

  BehaviorSubject<HospitalizationHistoryModel> _hospitalizationHistorySubject =
      BehaviorSubject<HospitalizationHistoryModel>();
  Observable<HospitalizationHistoryModel>
      get hospitalizationHistoryObservable =>
          _hospitalizationHistorySubject.stream;

  getHospitalizationHistory() async {
    var resultEncounters = await hospitalizationHistoryRepository
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
      final result = await hospitalizationHistoryRepository
          .getHospitalizationHistory(_modelId);

      result.fold(
        (failure) =>
            _hospitalizationHistorySubject.sink.addError(failure.message),
        (hospitalizationHistory) {
          _hospitalizationHistory = hospitalizationHistory;
          _hospitalizationHistorySubject.sink.add(hospitalizationHistory);
        },
      );
    } else {
      _hospitalizationHistorySubject.sink.add(HospitalizationHistoryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  onSavePressed(HospitalizationHistoryModel hospitalizationHistory) async {
    if (_modelId > 0) {
      var result = await hospitalizationHistoryRepository
          .updateHospitalizationHistory(hospitalizationHistory);
      result.fold(
        // todo
        (failure) {
          print("Upadte Failed ${failure.message}");
        },
        (data) =>
            print("HospitalizationHistory BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await hospitalizationHistoryRepository
          .addHospitalizationHistory(hospitalizationHistory);
      result.fold(
        // todo
        (failure) {
          print("Add Failed ${failure.message.toString()}");
        },
        (data) =>
            print("HospitalizationHistory BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    await getHospitalizationHistory();
  }

  @override
  void dispose() {
    _hospitalizationHistorySubject.close();
  }
}
