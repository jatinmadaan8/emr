import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/nutrition_metabolic.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/questions.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/nutrition_metabolic.repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class NutritionMetabolicBloc implements BaseBloc {
  static const sectionName = 'RNUTR';
  int modelId;

  final NutritionMetabolicRepository nutritionMetabolicRepo;
  TokenService _tokenService = TokenService();
  NutritionMetabolic nutritionMetabolicData;
  List<GenricLookupData> nOrMDieticianReferral = [];

  BehaviorSubject<NutritionMetabolic> nutritionMetabolic =
      BehaviorSubject<NutritionMetabolic>();
  Observable<NutritionMetabolic> get soaNoteObservable =>
      nutritionMetabolic.stream;

  List<NutritionMetabolicQuestionnaire> nutritionalMetabolicQuestionnaire = [];

  BehaviorSubject<List<GenricQuestions>> nomQuestions =
      BehaviorSubject<List<GenricQuestions>>();
  Observable<List<GenricQuestions>> get nomQuestionsObservable =>
      nomQuestions.stream;

  NutritionMetabolicBloc({@required this.nutritionMetabolicRepo});

  getNutritionMetabolic() async {
    var resultEncounters = await nutritionMetabolicRepo
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
      var result = await nutritionMetabolicRepo.getNutritionMetabolic(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          nutritionMetabolicData = data,
          nutritionMetabolic.sink.add(data),
        },
      );

      if (nutritionMetabolicData != null &&
          nutritionMetabolicData.nutritionalMetabolicQuestionnaire != null) {
        nutritionalMetabolicQuestionnaire =
            nutritionMetabolicData.nutritionalMetabolicQuestionnaire;
      }
    } else {
      nutritionMetabolicData = NutritionMetabolic();
    }
  }

  void addNutritionMetabolic() async {
    nutritionMetabolicData.encounterId = _tokenService.selectedEncounterId;
    nutritionMetabolicData.nutritionalMetabolicQuestionnaire =
        nutritionalMetabolicQuestionnaire;
    var result = await nutritionMetabolicRepo
        .addNutritionMetabolic(nutritionMetabolicData);
    if (nutritionMetabolicData.id == null) {
      getNutritionMetabolic();
    }
  }

  getNomQuestions() async {
    var nomQuestionsresponse = await nutritionMetabolicRepo.getNomQuestions();
    nomQuestionsresponse.fold((Failure failure) => {}, (data) {
      nomQuestions.sink.add(data);
    });
  }

  getNOrMDieticianReferral() async {
    var result =
        await nutritionMetabolicRepo.getLookupData('NOrMDieticianReferral');
    result.fold(
      (Failure failure) => {},
      (data) => {nOrMDieticianReferral = data},
    );
  }

  changeQuestion(GenricQuestions question, bool value) {
    bool exist = false;
    if (nutritionalMetabolicQuestionnaire.length > 0) {
      nutritionalMetabolicQuestionnaire.forEach((d) {
        if (d.questionid == question.id) {
          d.response = value;
          exist = true;
        }
      });
    }

    if (!exist) {
      NutritionMetabolicQuestionnaire cuurrentQues =
          NutritionMetabolicQuestionnaire();
      cuurrentQues.questionid = question.id;
      cuurrentQues.response = value;
      nutritionalMetabolicQuestionnaire.add(cuurrentQues);
    }
  }

  changeQuestionDescription(GenricQuestions question, String value) {
    if (nutritionalMetabolicQuestionnaire.length > 0) {
      nutritionalMetabolicQuestionnaire.forEach((d) {
        if (d.questionid == question.id) {
          d.additionalInfo = value;
        }
      });
    }
  }

  String checkQuestionDescription(GenricQuestions question) {
    String currentValue = '';
    nutritionalMetabolicQuestionnaire.forEach((d) {
      if (d.questionid == question.id) {
        currentValue = d.additionalInfo;
      }
    });
    return currentValue == null ? '' : currentValue;
  }

  bool checkAwnser(GenricQuestions question) {
    var currentValue;
    nutritionalMetabolicQuestionnaire.forEach((d) {
      if (d.questionid == question.id) {
        currentValue = d.response;
      }
    });
    return currentValue;
  }

  bool showChildQuestion(int parentId) {
    var show = false;
    nutritionalMetabolicQuestionnaire.forEach((d) {
      if (d.questionid == parentId && d.response == true) {
        show = true;
      }
    });
    return show;
  }

  void initialize() async {
    await getNOrMDieticianReferral();
    await getNutritionMetabolic();
    await getNomQuestions();
  }

  @override
  void dispose() {
    nutritionMetabolic.close();
    nomQuestions.close();
  }
}
