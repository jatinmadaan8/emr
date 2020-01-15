import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/tuberculosis/tuberculosis.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/tuberculosis_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class TuberculosisBloc implements BaseBloc {
  static const sectionName = 'RTUBE';
  int modelId;

  final TuberculosisRepository tuberculosisRepo;
  TokenService _tokenService = TokenService();
  Tuberculosis tuberculosisData;
  BehaviorSubject<Tuberculosis> tuberculosis = BehaviorSubject<Tuberculosis>();
  Observable<Tuberculosis> get soaNoteObservable => tuberculosis.stream;

  List<TuberculosisQuestionnaire> tuberculosisQuestionnaire = [];

  BehaviorSubject<List<GenricQuestions>> nvTbQuestions =
      BehaviorSubject<List<GenricQuestions>>();
  Observable<List<GenricQuestions>> get nvTbQuestionsObservable =>
      nvTbQuestions.stream;

  TuberculosisBloc({@required this.tuberculosisRepo});

  getTuberculosis() async {
    var resultEncounters =
        await tuberculosisRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await tuberculosisRepo.getTuberculosis(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          tuberculosisData = data,
          tuberculosis.sink.add(data),
        },
      );

      if (tuberculosisData != null &&
          tuberculosisData.tuberculosisQuestionnaire != null) {
        tuberculosisQuestionnaire = tuberculosisData.tuberculosisQuestionnaire;
      }
    } else {
      tuberculosisData = Tuberculosis();
    }
  }

  void addTuberculosis() async {
    tuberculosisData.encounterId = _tokenService.selectedEncounterId;

    tuberculosisData.tuberculosisQuestionnaire = tuberculosisQuestionnaire;

    var result = await tuberculosisRepo.addTuberculosis(tuberculosisData);
    if (tuberculosisData.id == null) {
      getTuberculosis();
    }
  }

  getNvTbQuestions() async {
    var nvTbQuestionsresponse = await tuberculosisRepo.getNvTbQuestions();
    nvTbQuestionsresponse.fold((Failure failure) => {}, (data) {
      nvTbQuestions.sink.add(data);
    });
  }

  changeQuestion(GenricQuestions question, bool value) {
    bool isEsist = false;
    if (tuberculosisQuestionnaire.length > 0) {
      tuberculosisQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.response = value;
          isEsist = true;
        }
      });
    }

    if (!isEsist) {
      TuberculosisQuestionnaire cuurrentTub = TuberculosisQuestionnaire();
      cuurrentTub.questionId = question.id;
      cuurrentTub.response = value;
      tuberculosisQuestionnaire.add(cuurrentTub);
    }
  }

  changeQuestionDescription(GenricQuestions question, String value) {
    if (tuberculosisQuestionnaire.length > 0) {
      tuberculosisQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.additionalInfo = value;
        }
      });
    }
  }

  String checkQuestionDescription(GenricQuestions question) {
    String currentValue = '';
    tuberculosisQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.additionalInfo;
      }
    });

    return currentValue == null ? '' : currentValue;
  }

  bool checkAwnser(GenricQuestions question) {
    var currentValue;
    tuberculosisQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.response;
      }
    });
    return currentValue;
  }

  void initialize() async {
    await getTuberculosis();
    await getNvTbQuestions();
  }

  @override
  void dispose() {
    tuberculosis.close();
    nvTbQuestions.close();
  }
}
