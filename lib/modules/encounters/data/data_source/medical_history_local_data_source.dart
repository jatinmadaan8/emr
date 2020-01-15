import '../models/social_medical_psych_hx/medical_history_predicate.dart';

abstract class MedicalHistoryLocalDataSource {
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist();
}

class MedicalHistoryLocalDataSourceImpl
    implements MedicalHistoryLocalDataSource {
  @override
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist() {
    // TODO:
    return null;
  }
}
