
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/abuse_neglect.dart';

abstract class AbuseNeglectLocalDataSource {
  Future<AbuseNeglect> getMobilityStatus();
}


class AbuseNeglectLocalDataSourceImpl implements AbuseNeglectLocalDataSource
{
  @override
  Future<AbuseNeglect> getMobilityStatus() {
    // TODO: implement getMobilityStatus
    return null;
  }

}