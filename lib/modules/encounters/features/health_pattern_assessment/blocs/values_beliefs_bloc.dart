import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/values_blefs.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/values_beliefs_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ValuesBeliefsBloc implements BaseBloc {
  static const sectionName = 'RVABE';
  int modelId;

  final ValuesBeliefsRepository valuesBeliefsRepo;
  TokenService _tokenService = TokenService();
  ValuesBeliefs valuesBeliefsData;

  BehaviorSubject<ValuesBeliefs> valuesBeliefs =
      BehaviorSubject<ValuesBeliefs>();
  Observable<ValuesBeliefs> get soaNoteObservable => valuesBeliefs.stream;

  List<VobQuestions> valuesBeliefsQuestionnaire = [];

  BehaviorSubject<List<GenricQuestions>> valuesBeliefsQuestions =
      BehaviorSubject<List<GenricQuestions>>();
  Observable<List<GenricQuestions>> get valuesBeliefsQuestionsObservable =>
      valuesBeliefsQuestions.stream;

  ValuesBeliefsBloc({@required this.valuesBeliefsRepo});

  getValuesBeliefs() async {
    var resultEncounters = await valuesBeliefsRepo
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
      var result = await valuesBeliefsRepo.getTuberculosis(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          valuesBeliefsData = data,
          valuesBeliefs.sink.add(data),
        },
      );

      if (valuesBeliefsData != null &&
          valuesBeliefsData.valuesBeliefsQuestionnaire != null) {
        valuesBeliefsQuestionnaire =
            valuesBeliefsData.valuesBeliefsQuestionnaire;
      }
    } else {
      valuesBeliefsData = ValuesBeliefs();
    }
  }

  void addValuesBeliefs() async {
    valuesBeliefsData.encounterId = _tokenService.selectedEncounterId;
    valuesBeliefsData.valuesBeliefsQuestionnaire = valuesBeliefsQuestionnaire;

    await valuesBeliefsRepo.addValuesBeliefs(valuesBeliefsData);
    if (valuesBeliefsData.id == null) {
      getValuesBeliefs();
    }
  }

  getQuestions() async {
    var nvTbQuestionsresponse = await valuesBeliefsRepo.getVobQuestions();
    nvTbQuestionsresponse.fold((Failure failure) => {}, (data) {
      valuesBeliefsQuestions.sink.add(data);
    });
  }

  changeQuestion(GenricQuestions question, bool value) {
    bool isEsist = false;
    if (valuesBeliefsQuestionnaire.length > 0) {
      valuesBeliefsQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.response = value;
          isEsist = true;
        }
      });
    }

    if (!isEsist) {
      VobQuestions cuurrentTub = VobQuestions();
      cuurrentTub.questionId = question.id;
      cuurrentTub.response = value;
      valuesBeliefsQuestionnaire.add(cuurrentTub);
    }
  }

  changeQuestionDescription(GenricQuestions question, String value) {
    if (valuesBeliefsQuestionnaire.length > 0) {
      valuesBeliefsQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.additionalInfo = value;
        }
      });
    }
  }

  String checkQuestionDescription(GenricQuestions question) {
    String currentValue = '';
    valuesBeliefsQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.additionalInfo;
      }
    });

    return currentValue == null ? '' : currentValue;
  }

  bool checkAwnser(GenricQuestions question) {
    var currentValue;
    valuesBeliefsQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.response;
      }
    });
    return currentValue;
  }

  void initialize() async {
    await getValuesBeliefs();
    await getQuestions();
  }

  @override
  void dispose() {
    valuesBeliefs.close();
    valuesBeliefsQuestions.close();
  }
}
