import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/legal_history.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/legal_history_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LegalHistoryBloc implements BaseBloc {
  final sectionName = 'RLEGA';
  int modelId;

  final LegalHistoryRepository legalHistoryRepo;
  TokenService _tokenService = TokenService();

  LegalHistory legalHistoryData = LegalHistory();

  BehaviorSubject<LegalHistory> legalHistory = BehaviorSubject<LegalHistory>();

  Observable<LegalHistory> get legalHistoryObservable => legalHistory.stream;

  BehaviorSubject<List<GenricDropDown>> proceedings =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get proceedingsObservable =>
      proceedings.stream;

  BehaviorSubject<List<GenricDropDown>> chargeStatus =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get chargeStatusObservable =>
      chargeStatus.stream;

  LegalHistoryBloc({@required this.legalHistoryRepo});

  getLegalHistory() async {
    var resultEncounters =
        await legalHistoryRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await legalHistoryRepo.getLegalHistory(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          legalHistoryData = data,
          legalHistory.sink.add(data),
        },
      );
    } else {
      legalHistoryData = LegalHistory();
    }

    if (legalHistoryData.legalProceeding == null) {
      legalHistoryData.legalProceeding = [];
    }
    if (legalHistoryData.criminalCharges == null) {
      legalHistoryData.criminalCharges = [];
    }
  }

  void addLegalHistory() async {
    legalHistoryData.encounterId = _tokenService.selectedEncounterId;

    await legalHistoryRepo.addLegalHistory(legalHistoryData);
    if (legalHistoryData.id == null) {
      getLegalHistory();
    }
  }

  getChargeStatus() async {
    var result = await legalHistoryRepo.getGenricDropDown('ChargeStatus');
    result.fold(
      (Failure failure) => {},
      (data) => {
        chargeStatus.sink.add(data),
      },
    );
  }

  getProceedings() async {
    var result = await legalHistoryRepo.getGenricDropDown('Proceedings');
    result.fold(
      (Failure failure) => {},
      (data) => {
        proceedings.sink.add(data),
      },
    );
  }

  bool checkLegalProceedingValue(GenricDropDown value) {
    var currentValue = false;
    legalHistoryData.legalProceeding.forEach((d) {
      if (d.proceedingId == value.id) {
        currentValue = true;
      }
    });
    return currentValue;
  }

  void setValueForLegalProceeding(GenricDropDown value) {
    bool isEsist = false;
    LegalProceeding cuurrentTub = LegalProceeding();
    if (legalHistoryData.legalProceeding.length > 0) {
      legalHistoryData.legalProceeding.forEach((d) {
        if (d.proceedingId == value.id) {
          isEsist = true;
          cuurrentTub = d;
        }
      });
    }

    if (!isEsist) {
      cuurrentTub.proceedingId = value.id;
      legalHistoryData.legalProceeding.add(cuurrentTub);
    } else {
      legalHistoryData.legalProceeding.remove(cuurrentTub);
    }
  }

  void initialize() async {
    if (legalHistoryData.legalProceeding == null) {
      legalHistoryData.legalProceeding = [];
    }
    if (legalHistoryData.criminalCharges == null) {
      legalHistoryData.criminalCharges = [];
    }
    getChargeStatus();
    getProceedings();
    await getLegalHistory();
  }

  @override
  void dispose() {
    chargeStatus.close();
    proceedings.close();
    legalHistory.close();
  }
}
