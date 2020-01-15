import 'package:meta/meta.dart';

import '../../../../../core/base_bloc.dart';
import '../../../../encounters/data/repository/medical_history.repository.dart';
import '../../../data/models/social_medical_psych_hx/medical_history_predicate.dart';

class MedicalHistoryBloc implements BaseBloc {
  final MedicalHistoryRepository medicalHistoryRepo;

  MedicalHistoryBloc({@required this.medicalHistoryRepo}) {}

  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist(
      String value) async {
    return medicalHistoryRepo.getMedicalHistoryPredicatelist(value);

    // result.fold(
    //   (failure) => medicalHistorySubject.sink.addError(failure.message),
    //   (medicalHistoryPredicateList) =>
    //       return medicalHistoryPredicateList,
    // );
    //return null;
    // return result.fold();
  }

  @override
  void dispose() {
    //medicalHistorySubject.close();
  }
}
