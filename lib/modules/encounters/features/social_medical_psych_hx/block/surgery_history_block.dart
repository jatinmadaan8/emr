import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';
import '../../../../encounters/data/repository/surgery_history.repository.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/surgery_history.dart';

class SurgeryHistoryBloc implements BaseBloc {
  static const sectionName = 'RSURG';
  int _modelId;
  SurgeryHistoryModel _surgeryHistory;

  final SurgeryHistoryRepository surgeryHistoryRepo;
  TokenService _tokenService = TokenService();

  SurgeryHistoryBloc({@required this.surgeryHistoryRepo});

  BehaviorSubject<SurgeryHistoryModel> _surgeryHistorySubject =
      BehaviorSubject<SurgeryHistoryModel>();
  Observable<SurgeryHistoryModel> get surgeryHistoryModel =>
      _surgeryHistorySubject.stream;

  /// -------------
  BehaviorSubject<List<SurgeryTypesLookupModel>> _surgeryTypesSubject =
      BehaviorSubject<List<SurgeryTypesLookupModel>>();
  Observable<List<SurgeryTypesLookupModel>> get surgeryTypes =>
      _surgeryTypesSubject.stream;

  _getSurgeryHistory() async {
    var resultEncounters = await surgeryHistoryRepo
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
      final result = await surgeryHistoryRepo.getSurgeryHistory(_modelId);

      result.fold(
        (failure) => _surgeryHistorySubject.sink.addError(failure.message),
        (surgeryHistory) {
          _surgeryHistory = surgeryHistory;
          _surgeryHistorySubject.sink.add(surgeryHistory);
        },
      );
    } else {
      _surgeryHistorySubject.sink.add(SurgeryHistoryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getSurgeryTypes() async {
    var result = await surgeryHistoryRepo.getSurgeryTypes();
    result.fold(
      (failure) => _surgeryTypesSubject.sink.addError(failure.message),
      (data) => _surgeryTypesSubject.sink.add(data),
    );
  }

  initialize() async {
    Future.wait(<Future>[
      _getSurgeryTypes(),
    ]);
    await _getSurgeryHistory();
  }

  onSavePressed(SurgeryHistoryModel surgeryHistory) async {
    if (_modelId > 0) {
      var result =
          await surgeryHistoryRepo.updateSurgeryHistory(surgeryHistory);
      result.fold(
        // todo
        (failure) => print("Update Failed"),
        (data) => print("SurgeryHistory BLOC : Updated " + data.toString()),
      );
    } else {
      var result = await surgeryHistoryRepo.addSurgeryHistory(surgeryHistory);
      result.fold(
        // todo
        (failure) => print("Add Failed"),
        (data) => print("SurgeryHistory BLOC : Added " + data.toString()),
      );
    }
  }

  @override
  void dispose() {
    _surgeryHistorySubject.close();
    _surgeryTypesSubject.close();
  }
}
