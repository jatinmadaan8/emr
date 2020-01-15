
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/sleep_rest.dart';

abstract class SleepRestLocalDataSource {
  Future<SleepRest> getMobilityStatus();
}


class SleepRestLocalDataSourceImpl implements SleepRestLocalDataSource
{
  @override
  Future<SleepRest> getMobilityStatus() {
    // TODO: implement getMobilityStatus
    return null;
  }

}