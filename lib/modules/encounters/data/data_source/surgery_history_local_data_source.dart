import '../models/social_medical_psych_hx/surgery_history.dart';

abstract class SurgeryHistoryLocalDataSource {
  Future<List<SurgeryTypes>> getSurgeryTypes();
}

class SurgeryHistoryLocalDataSourceImpl
    implements SurgeryHistoryLocalDataSource {
  @override
  Future<List<SurgeryTypes>> getSurgeryTypes() {
    // TODO:
    return null;
  }
}
