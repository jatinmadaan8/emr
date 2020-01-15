import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/sleep_rest.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/sleep_rest.repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SleepRestBloc implements BaseBloc {
  static const sectionName = 'RSLEE';
  int modelId;

  final SleepRestRepository sleepRestRepo;
  TokenService _tokenService = TokenService();

  SleepRest sleepRestData = SleepRest(sleepRestQuestionnaire: []);
  List<GenricLookupData> srProblems = [];

  BehaviorSubject<SleepRest> sleepRest = BehaviorSubject<SleepRest>();

  Observable<SleepRest> get sleepRestObservable => sleepRest.stream;

  SleepRestBloc({@required this.sleepRestRepo});

  getSleepRest() async {
    var resultEncounters =
        await sleepRestRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await sleepRestRepo.getSleepRest(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          sleepRestData = data,
          sleepRest.sink.add(data),
        },
      );
    } else {
      sleepRest.sink.add(sleepRestData);
    }
  }

  void addSleepRest() async {
    sleepRestData.encounterId = _tokenService.selectedEncounterId;

    await sleepRestRepo.addSleepRest(sleepRestData);
    if (sleepRestData.id == null) {
      getSleepRest();
    }
  }

  void getProblems() async {
    var result = await sleepRestRepo.getLookupData('SOrRProblems');
    result.fold(
      (Failure failure) => {},
      (data) => {srProblems = data},
    );
  }

  void updateProblems() {
    sleepRestData.sleepRestQuestionnaire.forEach((f) {
      srProblems.where((p) => p.id == f.problemsId).first.value = true;
    });
    sleepRest.sink.add(sleepRestData);
  }

  void initialize() async {
    await getProblems();
    await getSleepRest();
    updateProblems();
  }

  void problemCheckboxTap(int id, bool val) {
    srProblems.where((p) => p.id == id).first.value = val;
    if (val) {
      sleepRestData.sleepRestQuestionnaire
          .add(SleepRestQuestionnaire(problemsId: id, problemDesc: ''));
    } else {
      sleepRestData.sleepRestQuestionnaire.remove(sleepRestData
          .sleepRestQuestionnaire
          .where((p) => p.problemsId == id)
          .first);
    }
    sleepRest.sink.add(sleepRestData);
  }

  void updateHrsofNightSleep(val) {
    if (val != null) {
      sleepRestData.hrsofNightSleep = double.parse(val);
    }
  }

  void updateNoofpillows(val) {
    if (val != null) {
      sleepRestData.noofpillows = int.parse(val);
    }
  }

  void updateHelpsToSleep(val) {
    sleepRestData.helpsToSleep = val;
  }

  void updateBedTime(val) {
    sleepRestData.bedTime = val;
    sleepRest.sink.add(sleepRestData);
  }

  @override
  void dispose() {
    sleepRest.close();
  }
}
