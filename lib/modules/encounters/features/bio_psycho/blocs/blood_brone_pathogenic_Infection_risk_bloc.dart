import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/blood_brone_pathogenic_infection_risk.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/cultural_religious_rackground.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/blood_brone_pathogenic_Infection_risk_bloc_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class BloodBronePathogenicInfectionRiskBloc implements BaseBloc {
  final sectionName = 'RBLOO';
  int modelId;

  final BloodBronePathogenicInfectionRiskRepository
      bloodBronePathogenicInfectionRiskRepo;
  TokenService _tokenService = TokenService();

  BloodBronePathogenicInfectionRisk culturalReligiousBackgroundData =
      BloodBronePathogenicInfectionRisk();

  BehaviorSubject<BloodBronePathogenicInfectionRisk>
      culturalReligiousBackground =
      BehaviorSubject<BloodBronePathogenicInfectionRisk>();

  Observable<BloodBronePathogenicInfectionRisk>
      get culturalReligiousBackgroundObservable =>
          culturalReligiousBackground.stream;

  BehaviorSubject<List<Language>> languageList =
      BehaviorSubject<List<Language>>();

  Observable<List<Language>> get languageListObservable => languageList.stream;

  BloodBronePathogenicInfectionRiskBloc(
      {@required this.bloodBronePathogenicInfectionRiskRepo});

  getBloodBronePathogenicInfectionRisk() async {
    var resultEncounters = await bloodBronePathogenicInfectionRiskRepo
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
      var result =
          await bloodBronePathogenicInfectionRiskRepo.getBloodBrone(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          culturalReligiousBackgroundData = data,
          culturalReligiousBackground.sink.add(data),
        },
      );
    } else {
      culturalReligiousBackgroundData = BloodBronePathogenicInfectionRisk();
    }
  }

  void addBloodBronePathogenicInfectionRisk() async {
    culturalReligiousBackgroundData.encounterId =
        _tokenService.selectedEncounterId;

    await bloodBronePathogenicInfectionRiskRepo
        .addBloodBrone(culturalReligiousBackgroundData);
    if (culturalReligiousBackgroundData.id == null) {
      getBloodBronePathogenicInfectionRisk();
    }
  }

  void initialize() async {
    await getBloodBronePathogenicInfectionRisk();
  }

  @override
  void dispose() {
    culturalReligiousBackground.close();
    languageList.close();
  }
}
