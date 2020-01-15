import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/support_recovery.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/support_recovery_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SupportRecoveryBloc implements BaseBloc {
  final sectionName = 'RBLOO';
  int modelId;

  final SupportRecoveryRepository supportRecoveryRepo;
  TokenService _tokenService = TokenService();

  SupportRecovery supportRecoveryData = SupportRecovery();
  //    SupportRecovery();

  BehaviorSubject<SupportRecovery> supportRecovery =
      BehaviorSubject<SupportRecovery>();

  Observable<SupportRecovery> get supportRecoveryObservable =>
      supportRecovery.stream;

  SupportRecoveryBloc({@required this.supportRecoveryRepo});

  getSupportRecovery() async {
    var resultEncounters = await supportRecoveryRepo
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
      var result = await supportRecoveryRepo.getSupportRecovery(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          supportRecoveryData = data,
          supportRecovery.sink.add(data),
        },
      );
    } else {
      supportRecoveryData = SupportRecovery();
    }
  }

  void addSupportRecovery() async {
    supportRecoveryData.encounterId = _tokenService.selectedEncounterId;

    await supportRecoveryRepo.addSupportRecovery(supportRecoveryData);
    if (supportRecoveryData.id == null) {
      getSupportRecovery();
    }
  }

  void initialize() async {
    await getSupportRecovery();
  }

  @override
  void dispose() {
    supportRecovery.close();
  }
}
