import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

abstract class NeuroSensoryLocalDataSource {
  Future<NeuroSensory> getNeuroSensory();

  Future<List<NeuroDropDown>> getDropDown(String value);

  Future<void> addNeuroSensory();
  Future<void> deleteNeuroSensory();
  Future<void> updateNeuroSensory(NeuroSensory neuroSensory);
}

class NeuroSensoryLocalDataSourceImpl implements NeuroSensoryLocalDataSource {
  @override
  Future<void> addNeuroSensory() {
    // TODO: implement addNeuroSensory
    return null;
  }

  @override
  Future<void> deleteNeuroSensory() {
    // TODO: implement deleteNeuroSensory
    return null;
  }

  @override
  Future<List<NeuroDropDown>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<NeuroSensory> getNeuroSensory() {
    // TODO: implement getNeuroSensory
    return null;
  }

  @override
  Future<void> updateNeuroSensory(NeuroSensory neuroSensory) {
    // TODO: implement updateNeuroSensory
    return null;
  }
}
