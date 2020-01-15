import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/respiratory.dart';

abstract class RespiratoryLocalDataSource {
  Future<RespiratoryModel> getRespiratory();

  Future<List<RespiratoryDropDown>> getDropDown(String value);

  Future<void> addRespiratory();
  Future<void> deleteRespiratory();
  Future<void> updateRespiratory(RespiratoryModel respiratory);
}

class RespiratoryLocalDataSourceImpl implements RespiratoryLocalDataSource {
  @override
  Future<void> addRespiratory() {
    // TODO: implement addRespiratory
    return null;
  }

  @override
  Future<void> deleteRespiratory() {
    // TODO: implement deleteRespiratory
    return null;
  }

  @override
  Future<List<RespiratoryDropDown>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<RespiratoryModel> getRespiratory() {
    // TODO: implement getRespiratory
    return null;
  }

  @override
  Future<void> updateRespiratory(RespiratoryModel respiratory) {
    // TODO: implement updateRespiratory
    return null;
  }
}
