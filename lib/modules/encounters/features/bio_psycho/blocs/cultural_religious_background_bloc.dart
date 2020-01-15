import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/cultural_religious_rackground.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/cultural_religious_background_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CulturalReligiousBackgroundBloc implements BaseBloc {
  final sectionName = 'RCULT';
  int modelId;

  final CulturalReligiousBackgroundRepository culturalReligiousBackgroundRepo;
  TokenService _tokenService = TokenService();

  CulturalReligiousBackground culturalReligiousBackgroundData =
      CulturalReligiousBackground();

  BehaviorSubject<CulturalReligiousBackground> culturalReligiousBackground =
      BehaviorSubject<CulturalReligiousBackground>();

  Observable<CulturalReligiousBackground>
      get culturalReligiousBackgroundObservable =>
          culturalReligiousBackground.stream;

  BehaviorSubject<List<GenricQuestions>> culturalandreligiousOutlookQuestions =
      BehaviorSubject<List<GenricQuestions>>();

  Observable<List<GenricQuestions>> get culturalandreligiousOutlookObservable =>
      culturalandreligiousOutlookQuestions.stream;

  BehaviorSubject<List<Language>> languageList =
      BehaviorSubject<List<Language>>();

  Observable<List<Language>> get languageListObservable => languageList.stream;

  CulturalReligiousBackgroundBloc(
      {@required this.culturalReligiousBackgroundRepo});

  getCulturalReligiousBackground() async {
    var resultEncounters = await culturalReligiousBackgroundRepo
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await culturalReligiousBackgroundRepo
          .getCulturalReligiousBackground(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          culturalReligiousBackgroundData = data,
          culturalReligiousBackground.sink.add(data),
        },
      );
    } else {
      culturalReligiousBackgroundData = CulturalReligiousBackground();
    }
  }

  void addCulturalReligiousBackground() async {
    culturalReligiousBackgroundData.encounterId =
        _tokenService.selectedEncounterId;

    await culturalReligiousBackgroundRepo
        .addCulturalReligiousBackground(culturalReligiousBackgroundData);
    if (culturalReligiousBackgroundData.id == null) {
      getCulturalReligiousBackground();
    }
  }

  getCulturalandreligiousOutlookQuestions() async {
    var culturalandreligiousOutlookQuestionsResponse =
        await culturalReligiousBackgroundRepo.getNvTbQuestions();
    culturalandreligiousOutlookQuestionsResponse.fold((Failure failure) => {},
        (data) {
      culturalandreligiousOutlookQuestions.sink.add(data);
    });
  }

  getLanguage() async {
    var languageResponse = await culturalReligiousBackgroundRepo.getLanguage();
    languageResponse.fold((Failure failure) => {}, (data) {
      languageList.sink.add(data);
    });
  }

  void initialize() async {
    getCulturalandreligiousOutlookQuestions();
    getLanguage();
    await getCulturalReligiousBackground();
  }

  @override
  void dispose() {
    culturalandreligiousOutlookQuestions.close();
    culturalReligiousBackground.close();
    languageList.close();
  }
}
