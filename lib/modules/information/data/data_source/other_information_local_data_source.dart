import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class OtherInformationLocalDataSource {
  Future<OtherInformationModel> getOtherInformation(int id);
  Future<void> addOtherInformation(OtherInformationModel otherInformationModel);
  Future<void> deleteOtherInformation();
  Future<void> updateOtherInformation(OtherInformationModel otherInformation);

  Future<List<Encounters>> getEncounters(int id);
}

class OtherInformationLocalDataSourceImpl
    implements OtherInformationLocalDataSource {
  @override
  Future<void> addOtherInformation(
      OtherInformationModel otherInformationModel) {
    // TODO: implement addOtherInformation
    return null;
  }

  @override
  Future<void> deleteOtherInformation() {
    // TODO: implement deleteOtherInformation
    return null;
  }

  @override
  Future<List<Encounters>> getEncounters(int id) {
    // TODO: implement getEncounters
    return null;
  }

  @override
  Future<OtherInformationModel> getOtherInformation(int id) {
    // TODO: implement getOtherInformation
    return null;
  }

  @override
  Future<void> updateOtherInformation(OtherInformationModel otherInformation) {
    // TODO: implement updateOtherInformation
    return null;
  }
}
