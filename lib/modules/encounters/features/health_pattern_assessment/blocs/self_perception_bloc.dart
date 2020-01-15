import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/self_perception.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/values_blefs.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/self_perception_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SelfPerceptionBloc implements BaseBloc {
  static const sectionName = 'RSELF';
  int modelId;

  final SelfPerceptionRepository selfPerceptionRepo;
  TokenService _tokenService = TokenService();
  SelfPerception selfPerceptionData = SelfPerception();

  BehaviorSubject<SelfPerception> selfPerception =
      BehaviorSubject<SelfPerception>();

  Observable<SelfPerception> get selfPerceptionObservable =>
      selfPerception.stream;

  List<VobQuestions> selfPerceptionQuestionnaire = [];

  BehaviorSubject<List<GenricQuestions>> selfPerceptionQuestions =
      BehaviorSubject<List<GenricQuestions>>();

  Observable<List<GenricQuestions>> get selfPerceptionQuestionsObservable =>
      selfPerceptionQuestions.stream;

  SelfPerceptionBloc({@required this.selfPerceptionRepo});

  getSelfPerception() async {
    var resultEncounters = await selfPerceptionRepo
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await selfPerceptionRepo.getSelfPerception(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          selfPerceptionData = data,
          selfPerception.sink.add(data),
        },
      );
    }
  }

  void addSelfPerception() async {
    selfPerceptionData.encounterId = _tokenService.selectedEncounterId;
    await selfPerceptionRepo.addSelfPerception(selfPerceptionData);
    if (selfPerceptionData.id == null) {
      getSelfPerception();
    }
  }

  void initialize() async {
    await getSelfPerception();
  }

  @override
  void dispose() {
    selfPerception.close();
    selfPerceptionQuestions.close();
  }
}
