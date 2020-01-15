import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/activity_n_exercise_models/avn_mobility_status_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/avn_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';

class ActivityNExerciseBloc implements BaseBloc {
  static const sectionName = 'RACEX';
  final ActivityNExerciseRepository activityNExerciseRepository;
  BehaviorSubject<List<ActivityNExerciseMobilityStatusModel>>
  mobilityStatusSubject$ =
  BehaviorSubject<List<ActivityNExerciseMobilityStatusModel>>();

  Observable<List<ActivityNExerciseMobilityStatusModel>>
  get mobilityStatusObservable => mobilityStatusSubject$.stream;

  BehaviorSubject<List<ActivityNExerciseAssistiveDevicesModel>>
  assistiveDeviceSubject$ =
  BehaviorSubject<List<ActivityNExerciseAssistiveDevicesModel>>();

  Observable<List<ActivityNExerciseAssistiveDevicesModel>>
  get assistiveDeviceObservable => assistiveDeviceSubject$.stream;

  BehaviorSubject<List<ActivityNExerciseLimitationsModel>> limitationsSubject$ =
  BehaviorSubject<List<ActivityNExerciseLimitationsModel>>();

  Observable<List<ActivityNExerciseLimitationsModel>>
  get limitationsObservable => limitationsSubject$.stream;

  BehaviorSubject<List<ActivityNExerciseADLsModel>> adlsSubject$ =
  BehaviorSubject<List<ActivityNExerciseADLsModel>>();

  Observable<List<ActivityNExerciseADLsModel>> get adlsObservable =>
      adlsSubject$.stream;

  BehaviorSubject<ActivitiesNExercise> activitiesNExerciseSubject$ =
  BehaviorSubject<ActivitiesNExercise>();

  Observable<ActivitiesNExercise> get activitiesNExerciseSubjectObservable =>
      activitiesNExerciseSubject$.stream;

  BehaviorSubject<String> hobbiesIntrestOccSubject$ = BehaviorSubject<String>();

  Observable<String> get hobbiesIntrestOccObserable =>
      hobbiesIntrestOccSubject$.stream;

  int modelId;

  TokenService _tokenService = TokenService();

  int mobilityStatusRadioValue = 0;
  int assistiveDeviceRadioValue = 0;
  int limitationsRadioValue = 0;
  int adlsRadioValue = 0;
  int exerciseRadioValue = 0;
  String assistiveDeviceDes = '';
  String limitationsDesc = '';
  String exerciseDesc = '';
  String hobbiesInterestOccupation = '';

  ActivitiesNExercise activitiesNExercise;
  ActivityExerciseQuestionnaire activityExerciseQuestionnaireLocal;

  ActivityNExerciseBloc({@required this.activityNExerciseRepository});

  getActivitiesAndExercise() async {
    var resultEncounters = await activityNExerciseRepository
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
          (Failure failure) => {},
          (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
        print("Model Id is :${data.first.sectionName}")
      },
    );

    print("Model Id is :$modelId");
    if (modelId > 0) {
      var result =
      await activityNExerciseRepository.getActivitiesAndExercise(modelId);
      result.fold(
            (Failure failure) => {},
            (data) => {
          activitiesNExercise = data,
          activitiesNExerciseSubject$.sink.add(data),

          print(data.activityExerciseQuestionnaire.mobilityId),
          print(data.activityExerciseQuestionnaire.exerciseDesc),
          print(data.activityExerciseQuestionnaire.assistDeviceList),
          print(data.encounterId),
          //print(data.hobbiesInterestOccupation),
          //valuesBeliefsData = data,
          //valuesBeliefs.sink.add(data),
          //

          mobilityStatusRadioValue =
              data.activityExerciseQuestionnaire.mobilityId,
          assistiveDeviceRadioValue =
              data.activityExerciseQuestionnaire.assistDeviceId,
          limitationsRadioValue =
              data.activityExerciseQuestionnaire.limitationsId,
          adlsRadioValue = data.activityExerciseQuestionnaire.adlsId,
          exerciseRadioValue =
          data.activityExerciseQuestionnaire.exerciseRegularly == true
              ? 1
              : 2,

          assistiveDeviceDes =
          data.activityExerciseQuestionnaire.assistDeviceList == null
              ? ''
              : data.activityExerciseQuestionnaire.assistDeviceList,
          limitationsDesc =
          data.activityExerciseQuestionnaire.limitationsDesc == null
              ? ''
              : data.activityExerciseQuestionnaire.limitationsDesc,
          exerciseDesc = data.activityExerciseQuestionnaire.exerciseDesc == null
              ? ''
              : data.activityExerciseQuestionnaire.exerciseDesc,
          hobbiesInterestOccupation = data.hobbiesInterestOccupation == null
              ? ''
              : data.hobbiesInterestOccupation,
          hobbiesIntrestOccSubject$.sink.add(
              data.hobbiesInterestOccupation == null
                  ? '.'
                  : data.hobbiesInterestOccupation)
        },
      );
    }else
    {
      activitiesNExercise = ActivitiesNExercise();
    }
  }

  callAnAPI() async {
    print(mobilityStatusRadioValue);
    print(assistiveDeviceRadioValue);
    print(limitationsRadioValue);
    print(adlsRadioValue);
    print(exerciseRadioValue);
    print(assistiveDeviceDes);
    print(limitationsDesc);
    print(exerciseDesc);
    print(hobbiesInterestOccupation);



    if (modelId != 0)
    {
      updateExistingRecordActivitiesNExercise(activitiesNExercise);
    } else {
      addNewRecordActivitiesNExercise(activitiesNExercise);
    }
  }

  addNewRecordActivitiesNExercise(ActivitiesNExercise ae) async {
    activityExerciseQuestionnaireLocal = ActivityExerciseQuestionnaire();
    activityExerciseQuestionnaireLocal.acnExId = 0;

    if (mobilityStatusRadioValue != 0)
    {
      activityExerciseQuestionnaireLocal.mobilityId = mobilityStatusRadioValue;
    }

    if (assistiveDeviceRadioValue != 0)
    {
      activityExerciseQuestionnaireLocal.assistDeviceId = assistiveDeviceRadioValue;
    }

    if (limitationsRadioValue != 0)
    {
      activityExerciseQuestionnaireLocal.limitationsId = limitationsRadioValue;
    }

    if (adlsRadioValue != 0)
    {
      activityExerciseQuestionnaireLocal.adlsId = adlsRadioValue;
    }

    if (exerciseRadioValue != 0)
    {
      activityExerciseQuestionnaireLocal.exerciseRegularly = exerciseRadioValue == 1 ? true : false;
    }


    if (assistiveDeviceDes != null)
    {
      activityExerciseQuestionnaireLocal.assistDeviceList = assistiveDeviceDes;
    }

    if (limitationsDesc != null)
    {
      activityExerciseQuestionnaireLocal.limitationsDesc = limitationsDesc;
    }
    if (exerciseDesc != null)
    {
      activityExerciseQuestionnaireLocal.exerciseDesc = exerciseDesc;
    }
    if (hobbiesInterestOccupation != null)
    {
      ae.hobbiesInterestOccupation = hobbiesInterestOccupation;
      // activitiesNExercise.hobbiesInterestOccupation = hobbiesInterestOccupation;
    }

    ae.activityExerciseQuestionnaire = activityExerciseQuestionnaireLocal;
    ae.encounterId = _tokenService.selectedEncounterId;

    activityNExerciseRepository.addNewActivitiesNExercise(ae);
  }

  updateExistingRecordActivitiesNExercise(ActivitiesNExercise ae) async {
    if (mobilityStatusRadioValue != 0)
    {
      activitiesNExercise.activityExerciseQuestionnaire.mobilityId = mobilityStatusRadioValue;
    }

    if (assistiveDeviceRadioValue != 0)
    {
      activitiesNExercise.activityExerciseQuestionnaire.assistDeviceId = assistiveDeviceRadioValue;
    }

    if (limitationsRadioValue != 0)
    {
      activitiesNExercise.activityExerciseQuestionnaire.limitationsId = limitationsRadioValue;
    }

    if (adlsRadioValue != 0)
    {
      activitiesNExercise.activityExerciseQuestionnaire.adlsId = adlsRadioValue;
    }

    if (exerciseRadioValue != 0)
    {
      activitiesNExercise.activityExerciseQuestionnaire.exerciseRegularly = exerciseRadioValue == 1 ? true : false;
    }


    if (assistiveDeviceDes != null)
    {
      activitiesNExercise.activityExerciseQuestionnaire.assistDeviceList = assistiveDeviceDes;
    }

    if (limitationsDesc != null)
    {
      activitiesNExercise.activityExerciseQuestionnaire.limitationsDesc = limitationsDesc;
    }
    if (exerciseDesc != null)
    {
      activitiesNExercise.activityExerciseQuestionnaire.exerciseDesc = exerciseDesc;
    }
    if (hobbiesInterestOccupation != null)
    {
      activitiesNExercise.hobbiesInterestOccupation = hobbiesInterestOccupation;
    }

    activityNExerciseRepository.updateExistingActivitiesNExercise(ae);
  }

  getMobilityStatus() async {
    var result = await activityNExerciseRepository.getMobilityStatus();
    result.fold(
          (Failure failure) => {},
          (data) => {
        mobilityStatusSubject$.sink.add(data),
      },
    );
  }

  getassistiveDevices() async {
    var result = await activityNExerciseRepository.getAssistiveDevices();
    result.fold(
          (Failure failure) => {},
          (data) => {
        assistiveDeviceSubject$.sink.add(data),
      },
    );
  }

  getLimitations() async {
    var result = await activityNExerciseRepository.getLimitations();
    result.fold(
          (Failure failure) => {},
          (data) => {
        limitationsSubject$.sink.add(data),
      },
    );
  }

  getADLs() async {
    var result = await activityNExerciseRepository.getADLs();
    result.fold(
          (Failure failure) => {},
          (data) => {
        adlsSubject$.sink.add(data),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    assistiveDeviceSubject$.close();
    mobilityStatusSubject$.close();
    hobbiesIntrestOccSubject$.close();
  }
}
