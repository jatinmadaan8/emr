import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';

import '../models/social_medical_psych_hx/medical_history_predicate.dart';
import '../data_source/medical_history_local_data_source.dart';
import '../data_source/medical_history_remote_data_source.dart';

abstract class MedicalHistoryRepository {
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist(
      String value);
}

class MedicalHistoryRepositoryImpl implements MedicalHistoryRepository {
  final MedicalHistoryRemoteDataSource medicalHistoryRemoteDataSource;
  final MedicalHistoryLocalDataSource medicalHistoryLocalDataSource;
  final NetworkInfo networkInfo;

  MedicalHistoryRepositoryImpl({
    @required this.medicalHistoryRemoteDataSource,
    @required this.medicalHistoryLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist(
      String value) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await medicalHistoryRemoteDataSource
            .getMedicalHistoryPredicatelist(value);
        return result;
      } catch (e) {
        return null;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
