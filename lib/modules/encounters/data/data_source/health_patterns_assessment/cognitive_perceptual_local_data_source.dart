
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';


//ActivityNExerciseMobilityStatusModel
abstract class CognitivePerceptualLocalDataSource {
  Future<ActivityNExerciseMobilityStatusModel> getMobilityStatus();
}


class CognitivePerceptualLocalDataSourceImpl implements CognitivePerceptualLocalDataSource
{
  @override
  Future<ActivityNExerciseMobilityStatusModel> getMobilityStatus() {
    // TODO: implement getMobilityStatus
    return null;
  }

}