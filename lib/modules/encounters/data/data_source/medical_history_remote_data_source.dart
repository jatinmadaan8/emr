import 'package:meta/meta.dart';

import '../../../../core/services/http_service.dart';
import '../../../../core/error/failure.dart';
import '../models/social_medical_psych_hx/medical_history_predicate.dart';

abstract class MedicalHistoryRemoteDataSource {
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist(
      String value);
}

class MedicalHistoryRemoteDataSourceImpl
    implements MedicalHistoryRemoteDataSource {
  final HttpService httpService;

  MedicalHistoryRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<MedicalHistoryPredicate>> getMedicalHistoryPredicatelist(
      String value) async {
    try {
      return httpService
          .get(path: '/api/LookupData/MasterICD10?argPredicate=$value')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((data) {
        // print(data);

        return List<MedicalHistoryPredicate>.from(data.map((x) {
          //print(MedicalHistoryPredicate.fromMap(x).id);
          return MedicalHistoryPredicate.fromMap(x);
        }));
      }).first;
      // print(res);
      //  return null;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
