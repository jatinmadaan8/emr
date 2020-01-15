import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/coping_stress.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/coping_stress.repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CopingStressBloc implements BaseBloc {
  static const sectionName = 'RCOPI';
  int modelId;

  final CopingStressRepository copingStressRepo;
  TokenService _tokenService = TokenService();
  CopingStress copingStressData;

  BehaviorSubject<CopingStress> copingStress = BehaviorSubject<CopingStress>();
  Observable<CopingStress> get soaNoteObservable => copingStress.stream;

  List<CosQuestions> copingStressQuestionnaire = [];

  BehaviorSubject<List<GenricQuestions>> copingStressQuestions =
      BehaviorSubject<List<GenricQuestions>>();
  Observable<List<GenricQuestions>> get copingStressQuestionsObservable =>
      copingStressQuestions.stream;

  CopingStressBloc({@required this.copingStressRepo});

  getCopingStress() async {
    var resultEncounters =
        await copingStressRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await copingStressRepo.getCopingStress(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          copingStressData = data,
          copingStress.sink.add(data),
        },
      );

      if (copingStressData != null &&
          copingStressData.copingStressQuestionnaire != null) {
        copingStressQuestionnaire = copingStressData.copingStressQuestionnaire;
      }
    } else {
      copingStressData = CopingStress();
    }
  }

  void addCopingStress() async {
    copingStressData.encounterId = _tokenService.selectedEncounterId;
    copingStressData.copingStressQuestionnaire = copingStressQuestionnaire;

    await copingStressRepo.addCopingStress(copingStressData);
    if (copingStressData.id == null) {
      getCopingStress();
    }
  }

  getQuestions() async {
    var nvTbQuestionsresponse = await copingStressRepo.getCosQuestions();
    nvTbQuestionsresponse.fold((Failure failure) => {}, (data) {
      copingStressQuestions.sink.add(data);
    });
  }

  changeQuestion(GenricQuestions question, bool value) {
    bool isEsist = false;
    if (copingStressQuestionnaire.length > 0) {
      copingStressQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.response = value;
          isEsist = true;
        }
      });
    }

    if (!isEsist) {
      CosQuestions cuurrentTub = CosQuestions();
      cuurrentTub.questionId = question.id;
      cuurrentTub.response = value;
      copingStressQuestionnaire.add(cuurrentTub);
    }
  }

  changeQuestionDescription(GenricQuestions question, String value) {
    if (copingStressQuestionnaire.length > 0) {
      copingStressQuestionnaire.forEach((d) {
        if (d.questionId == question.id) {
          d.additionalInfo = value;
        }
      });
    }
  }

  String checkQuestionDescription(GenricQuestions question) {
    String currentValue = '';
    copingStressQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.additionalInfo;
      }
    });

    return currentValue == null ? '' : currentValue;
  }

  bool checkAwnser(GenricQuestions question) {
    var currentValue;
    copingStressQuestionnaire.forEach((d) {
      if (d.questionId == question.id) {
        currentValue = d.response;
      }
    });
    return currentValue;
  }

  void initialize() async {
    await getCopingStress();
    await getQuestions();
  }

  @override
  void dispose() {
    copingStress.close();
    copingStressQuestions.close();
  }
}
