import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/bio_psycho/further_evaluation.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/bio_psycho/further_evaluation_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class FurtherEvaluationBloc implements BaseBloc {
  final sectionName = 'RFAMI';
  bool isAdd = false;

  final FurtherEvaluationRepository furtherEvaluationRepo;

  TokenService _tokenService = TokenService();

  List<FurtherEvaluation> furtherEvaluationData = [];
  List<FurtherEvaluation> furtherEvaluationDataReferral = [];

  BehaviorSubject<List<FurtherEvaluation>> furtherEvaluation =
      BehaviorSubject<List<FurtherEvaluation>>();

  Observable<List<FurtherEvaluation>> get furtherEvaluationObservable =>
      furtherEvaluation.stream;

  BehaviorSubject<List<GenricDropDown>> evaluationTypes =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get evaluationTypesObservable =>
      evaluationTypes.stream;

  FurtherEvaluationBloc({@required this.furtherEvaluationRepo}) {}

  getFurtherEvaluation() async {
    var result = await furtherEvaluationRepo
        .getFurtherEvaluation(_tokenService.selectedEncounterId);
    result.fold(
      (Failure failure) => {},
      (data) => {
        furtherEvaluationData = data,
        furtherEvaluation.sink.add(data),
      },
    );
    if (furtherEvaluationData == null || furtherEvaluationData.length == 0) {
      isAdd = true;
    } else {
      furtherEvaluationData.forEach((d) {
        if (d.isReferrealOffered == true) {
          furtherEvaluationDataReferral.add(d);
        }
      });
    }
  }

  getEvaluationTypes() async {
    var result = await furtherEvaluationRepo.getEvaluationTypes();
    result.fold(
      (Failure failure) => {},
      (data) => {
        evaluationTypes.sink.add(data),
      },
    );
  }

  void addFurtherEvaluation() async {
    furtherEvaluationData.forEach((d) {
      furtherEvaluationDataReferral.forEach((f) {
        if (d.evalId == f.evalId) {
          d.isReferrealOffered = f.isReferrealOffered;
        }
      });
      d.encounterId = _tokenService.selectedEncounterId;
    });
    await furtherEvaluationRepo.addFurtherEvaluation(
        furtherEvaluationData, _tokenService.selectedEncounterId);
    getFurtherEvaluation();
  }

  bool checkValue(GenricDropDown value) {
    var currentValue = false;
    furtherEvaluationData.forEach((d) {
      if (d.evalId == value.id) {
        currentValue = true;
      }
    });
    return currentValue;
  }

  bool checkRefValue(GenricDropDown value) {
    var currentValue = false;
    furtherEvaluationDataReferral.forEach((d) {
      if (d.evalId == value.id) {
        currentValue = d.isReferrealOffered;
      }
    });
    return currentValue;
  }

  void setValueForEvaluation(GenricDropDown value) {
    bool isEsist = false;
    FurtherEvaluation cuurrentTub = FurtherEvaluation();
    if (furtherEvaluationData.length > 0) {
      furtherEvaluationData.forEach((d) {
        if (d.evalId == value.id) {
          isEsist = true;
          cuurrentTub = d;
        }
      });
    }

    if (!isEsist) {
      cuurrentTub.evalId = value.id;
      furtherEvaluationData.add(cuurrentTub);
    } else {
      furtherEvaluationData.remove(cuurrentTub);
    }
  }

  void setValueForRefEvaluation(GenricDropDown value) {
    bool isEsist = false;
    FurtherEvaluation cuurrentTub = FurtherEvaluation();
    if (furtherEvaluationDataReferral.length > 0) {
      furtherEvaluationDataReferral.forEach((d) {
        if (d.evalId == value.id) {
          isEsist = true;
          cuurrentTub = d;
          cuurrentTub.isReferrealOffered =
              (cuurrentTub.isReferrealOffered == true ? false : false);
        }
      });
    }

    if (!isEsist) {
      cuurrentTub.evalId = value.id;
      cuurrentTub.isReferrealOffered = true;
      furtherEvaluationDataReferral.add(cuurrentTub);
    } else {
      furtherEvaluationDataReferral.remove(cuurrentTub);
      furtherEvaluationDataReferral.add(cuurrentTub);
    }
  }

  void initialize() async {
    await getFurtherEvaluation();
    await getEvaluationTypes();
  }

  @override
  void dispose() {
    evaluationTypes.close();
    furtherEvaluation.close();
  }
}
