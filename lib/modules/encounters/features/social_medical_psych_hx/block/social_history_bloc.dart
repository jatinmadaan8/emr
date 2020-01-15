import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/social_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/social_history.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class SocialHistoryBloc implements BaseBloc {
  static const sectionName = 'RSOCI';
  int _modelId;
  SocialHistoryModel _socialHistory;

  final SocialHistoryRepository socialHistoryRepository;
  TokenService _tokenService = TokenService();

  SocialHistoryBloc({@required this.socialHistoryRepository});

  BehaviorSubject<SocialHistoryModel> _socialHistorySubject =
      BehaviorSubject<SocialHistoryModel>();
  Observable<SocialHistoryModel> get socialHistoryObservable =>
      _socialHistorySubject.stream;

  BehaviorSubject<List<MaritalStatus>> _maritalStatusSubject =
      BehaviorSubject<List<MaritalStatus>>();
  Observable<List<MaritalStatus>> get maritalStatus =>
      _maritalStatusSubject.stream;

  BehaviorSubject<List<SexualActivity>> _smokingStatusSubject =
      BehaviorSubject<List<SexualActivity>>();
  Observable<List<SexualActivity>> get smokingStatus =>
      _smokingStatusSubject.stream;

  BehaviorSubject<List<SexualActivity>> _sexualActivitySubject =
      BehaviorSubject<List<SexualActivity>>();
  Observable<List<SexualActivity>> get sexualActivity =>
      _sexualActivitySubject.stream;

  getSocialHistory() async {
    var resultEncounters = await socialHistoryRepository
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
      final result = await socialHistoryRepository.getSocialHistory(_modelId);

      result.fold(
        (failure) => _socialHistorySubject.sink.addError(failure.message),
        (socialHistory) {
          _socialHistory = socialHistory;
          _socialHistorySubject.sink.add(socialHistory);
        },
      );
    } else {
      _socialHistorySubject.sink.add(SocialHistoryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  _getMaritalStatus() async {
    var result = await socialHistoryRepository.getMaritalStatus();
    result.fold(
      (failure) => _maritalStatusSubject.sink.addError(failure.message),
      (data) => _maritalStatusSubject.sink.add(data),
    );
  }

  _getSmokingStatus() async {
    var result = await socialHistoryRepository.getSmokingStatus();
    result.fold(
      (failure) => _smokingStatusSubject.sink.addError(failure.message),
      (data) => _smokingStatusSubject.sink.add(data),
    );
  }

  _getSexualActivity() async {
    var result = await socialHistoryRepository.getSexualActivity();
    result.fold(
      (failure) => _sexualActivitySubject.sink.addError(failure.message),
      (data) => _sexualActivitySubject.sink.add(data),
    );
  }

  onSavePressed(SocialHistoryModel socialHistory) async {
    if (_modelId > 0) {
      var result =
          await socialHistoryRepository.updateSocialHistory(socialHistory);
      result.fold(
        // todo
        (failure) => print("Update Failed"),
        (data) => print("SocialHistory BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await socialHistoryRepository.addSocialHistory(socialHistory);
      result.fold(
        // todo
        (failure) => print("Add Failed"),
        (data) => print("SocialHistory BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      _getMaritalStatus(),
      _getSmokingStatus(),
      _getSexualActivity(),
    ]);
    await getSocialHistory();
  }

  @override
  void dispose() {
    _socialHistorySubject.close();
    _maritalStatusSubject.close();
    _smokingStatusSubject.close();
    _sexualActivitySubject.close();
  }
}
