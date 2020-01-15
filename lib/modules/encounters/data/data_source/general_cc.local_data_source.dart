import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';

abstract class GeneralCCLocalDataSource {
  Future<ChiefComplaint> getChiefComplaintlist();
  Future<void> addChiefComplaintlist();
  Future<void> deleteChiefComplaintlist();
  Future<void> updateChiefComplaintlist();
}

class GeneralCCLocalDataSourceImpl implements GeneralCCLocalDataSource {
  @override
  Future<ChiefComplaint> getChiefComplaintlist() {
    // TODO:
    return null;
  }

  @override
  Future<void> addChiefComplaintlist() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateChiefComplaintlist() {
    // TODO:
    return null;
  }

  @override
  Future<void> deleteChiefComplaintlist() {
    // TODO:
    return null;
  }
}
