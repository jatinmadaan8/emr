import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/cardio_vascular.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/neuro_sensory.dart';

abstract class CardioVascularLocalDataSource {
  Future<CardioVascularModel> getCardioVascular();

  Future<List<NeuroDropDown>> getDropDown(String value);

  Future<void> addCardioVascular();
  Future<void> deleteCardioVascular();
  Future<void> updateCardioVascular(CardioVascularModel cardioVascularModel);
}

class CardioVascularLocalDataSourceImpl
    implements CardioVascularLocalDataSource {
  @override
  Future<void> addCardioVascular() {
    // TODO: implement addCardioVascular
    return null;
  }

  @override
  Future<void> deleteCardioVascular() {
    // TODO: implement deleteCardioVascular
    return null;
  }

  @override
  Future<List<NeuroDropDown>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<CardioVascularModel> getCardioVascular() {
    // TODO: implement getCardioVascular
    return null;
  }

  @override
  Future<void> updateCardioVascular(CardioVascularModel cardioVascularModel) {
    // TODO: implement updateCardioVascular
    return null;
  }
}
