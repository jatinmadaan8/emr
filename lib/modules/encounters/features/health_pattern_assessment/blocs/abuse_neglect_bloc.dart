import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/abuse_neglect.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/abuse_neglect.repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AbuseNeglectBloc implements BaseBloc {
  static const sectionName = 'RABUS';
  int modelId;

  final AbuseNeglectRepository abuseNeglectRepo;
  TokenService _tokenService = TokenService();

  AbuseNeglect abuseNeglectData =
      AbuseNeglect(abuseNeglectQuestionnaire: AbuseNeglectQuestionnaire());
  List<GenricLookupData> anObservations = [];
  List<GenricLookupData> anFollowupActions = [];

  BehaviorSubject<AbuseNeglect> abuseNeglect = BehaviorSubject<AbuseNeglect>();

  Observable<AbuseNeglect> get abuseNeglectObservable => abuseNeglect.stream;

  AbuseNeglectBloc({@required this.abuseNeglectRepo});

  getAbuseNeglect() async {
    var resultEncounters =
        await abuseNeglectRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await abuseNeglectRepo.getAbuseNeglect(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          abuseNeglectData = data,
          abuseNeglect.sink.add(data),
        },
      );
    }
    else{
      abuseNeglect.sink.add(abuseNeglectData);
    }
  }

  void addAbuseNeglect() async {
    abuseNeglectData.encounterId = _tokenService.selectedEncounterId;

    await abuseNeglectRepo.addAbuseNeglect(abuseNeglectData);
    if (abuseNeglectData.id == null) {
      getAbuseNeglect();
    }
  }

  void getObservations() async {
    var result = await abuseNeglectRepo.getLookupData('AOrNNurseObesravtions');
    result.fold(
      (Failure failure) => {},
      (data) => {anObservations = data},
    );
  }

  void getFollowupActions() async {
    var result =
        await abuseNeglectRepo.getLookupData('AOrNNurseFollowupActions');
    result.fold(
      (Failure failure) => {},
      (data) => {anFollowupActions = data},
    );
  }

  void feelSafeRadioValueHandler(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.feelSafeAthome = val;
    abuseNeglect.sink.add(abuseNeglectData);
  }

  void observationRadioValueHandler(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.observationId = val;
    abuseNeglect.sink.add(abuseNeglectData);
  }

  void followupRadioValueHandler(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.followupActId = val;
    abuseNeglect.sink.add(abuseNeglectData);
  }

  void updateSafeAtHomeDesc(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.safeAtHomeDesc = val;
  }

  void updateObservationDesc(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.observationDesc = val;
  }

  void updateFollowupActDesc(val) {
    abuseNeglectData.abuseNeglectQuestionnaire.followupActDesc = val;
  }

  void initialize() async {
    getObservations();
    getFollowupActions();
    await getAbuseNeglect();
  }

  @override
  void dispose() {
    abuseNeglect.close();
  }
}
