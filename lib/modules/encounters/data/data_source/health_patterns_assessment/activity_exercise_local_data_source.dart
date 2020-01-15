
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';


//ActivityNExerciseMobilityStatusModel
abstract class ActivityNExerciseLocalDataSource {
  Future<ActivityNExerciseMobilityStatusModel> getMobilityStatus();
}


class ActivityNExerciseLocalDataSourceImpl implements ActivityNExerciseLocalDataSource
{
  @override
  Future<ActivityNExerciseMobilityStatusModel> getMobilityStatus() {
    // TODO: implement getMobilityStatus
    return null;
  }

}