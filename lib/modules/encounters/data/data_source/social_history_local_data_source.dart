import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/social_medical_psych_hx/social_history.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class SocialHistoryLocalDataSource {
  Future<SocialHistoryModel> getSocialHistory(int id);
  Future<void> addSocialHistory(SocialHistoryModel socialHistory);
  Future<void> deleteSocialHistory();
  Future<void> updateSocialHistory(SocialHistoryModel socialHistory);

  Future<List<Encounters>> getEncounters(int id);
}

class SocialHistoryLocalDataSourceImpl implements SocialHistoryLocalDataSource {
  @override
  Future<void> addSocialHistory(SocialHistoryModel socialHistory) {
    // TODO: implement addSocialHistory
    return null;
  }

  @override
  Future<void> deleteSocialHistory() {
    // TODO: implement deleteSocialHistory
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<SocialHistoryModel> getSocialHistory(int id) {
    // TODO: implement getSocialHistory
    return null;
  }

  @override
  Future<void> updateSocialHistory(SocialHistoryModel socialHistory) {
    // TODO: implement updateSocialHistory
    return null;
  }
}
