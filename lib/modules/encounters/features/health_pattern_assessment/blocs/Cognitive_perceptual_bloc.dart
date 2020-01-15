import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/health_pattern_assessment/cognitive_perceptual_model.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/health_patterns_assessment/cognitive_perceptual_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';


class CognitivePerceptualBloc implements BaseBloc {
  static const sectionName = 'RCOGN';
  final CogniitivePeceptualRepository cogniitivePeceptualRepository;
  BehaviorSubject<List<CogitivePeceptualCommonModel>>
  communicationSubject$ =
  BehaviorSubject<List<CogitivePeceptualCommonModel>>();

  Observable<List<CogitivePeceptualCommonModel>>
  get communicationObservable => communicationSubject$.stream;

  BehaviorSubject<List<CogitivePeceptualCommonModel>>
  langSpokenDeviceSubject$ =
  BehaviorSubject<List<CogitivePeceptualCommonModel>>();

  Observable<List<CogitivePeceptualCommonModel>>
  get langSpokenObservable => langSpokenDeviceSubject$.stream;

  BehaviorSubject<List<CogitivePeceptualCommonModel>> visionSubject$ =
  BehaviorSubject<List<CogitivePeceptualCommonModel>>();

  Observable<List<CogitivePeceptualCommonModel>>
  get visionObservable => visionSubject$.stream;

  BehaviorSubject<List<CogitivePeceptualCommonModel>> hearingSubject$ =
  BehaviorSubject<List<CogitivePeceptualCommonModel>>();

  Observable<List<CogitivePeceptualCommonModel>> get hearingObservable =>
      hearingSubject$.stream;

  BehaviorSubject<CognitivePerceptual> cognitivePerceptualSubject$ =
  BehaviorSubject<CognitivePerceptual>();

  Observable<CognitivePerceptual> get cognitivePerceptualSubjectObservable =>
      cognitivePerceptualSubject$.stream;

  //BehaviorSubject<String> hobbiesIntrestOccSubject$ = BehaviorSubject<String>();

 // Observable<String> get hobbiesIntrestOccObserable =>
  //    hobbiesIntrestOccSubject$.stream;

  int modelId = 0;

  TokenService _tokenService = TokenService();

  int communicationRadioValue = 0;
  int primaryLanguageSpokenValue = 0;
  int hearingRadioValue = 0;
  int visionRadioValue = 0;
  int numbnessRadioValue = 0;
  String languageList = '';
  String hearingList = '';
  String visionList = '';
  String paraesthesiaNumbnessDesc = '';

  CognitivePerceptual cognitivePerceptual;
  CognitivePerceptualQuestionnaire cognitivePerceptualQuestionnaireLocal;

  CognitivePerceptualBloc({@required this.cogniitivePeceptualRepository});

  getCognitivePerceptual() async {
    var resultEncounters = await cogniitivePeceptualRepository
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
          (Failure failure) => {},
          (data) => {
            data.forEach((f){

              print("Model Id is :${f.sectionName}");
            }),

        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,

      },
    );

    print("Model Id is :$modelId");
    if (modelId > 0) {
      var result =
      await cogniitivePeceptualRepository.getCognitivePerceptual(modelId);
      result.fold(
            (Failure failure) => {},
            (data) => {
              print('A1'),
              cognitivePerceptual = data,
          cognitivePerceptualSubject$.sink.add(data),

          print(data.cognitivePerceptualQuestionnaire.hearingId),
          print(data.cognitivePerceptualQuestionnaire.hearingList),

          print(data.encounterId),


          communicationRadioValue =
              data.cognitivePerceptualQuestionnaire.communicationId,
              primaryLanguageSpokenValue =
              data.cognitivePerceptualQuestionnaire.languageId,
              hearingRadioValue =
              data.cognitivePerceptualQuestionnaire.hearingId,
              visionRadioValue = data.cognitivePerceptualQuestionnaire.visionId,
              numbnessRadioValue =
          data.cognitivePerceptualQuestionnaire.isParaesthesiaNumbness == true
              ? 1
              : 2,

              languageList =
          data.cognitivePerceptualQuestionnaire.languageList == null
              ? ''
              : data.cognitivePerceptualQuestionnaire.languageList,

              hearingList = data.cognitivePerceptualQuestionnaire.hearingList == null
              ? ''
              : data.cognitivePerceptualQuestionnaire.hearingList,

              visionList = data.cognitivePerceptualQuestionnaire.visionList == null
              ? ''
              : data.cognitivePerceptualQuestionnaire.visionList,

              paraesthesiaNumbnessDesc = data.cognitivePerceptualQuestionnaire.paraesthesiaNumbnessDesc == null
              ? ''
              : data.cognitivePerceptualQuestionnaire.paraesthesiaNumbnessDesc,
        },
      );
    }else
    {
      cognitivePerceptual = CognitivePerceptual();
      print('A2');
    }
  }

  callAnAPI() async {

    print(communicationRadioValue);
    print(primaryLanguageSpokenValue);
    print(hearingRadioValue);
    print(visionRadioValue);
    print(numbnessRadioValue);
    print(languageList);
    print(hearingList);
    print(visionList);
    print(paraesthesiaNumbnessDesc);
    print(modelId);



    if (modelId != 0)
    {
      updateExistingRecordCognitivePerceptual(cognitivePerceptual);
    } else {
      addNewRecordCognitivePerceptual(cognitivePerceptual);
    }
  }

  addNewRecordCognitivePerceptual(CognitivePerceptual ae) async {
    cognitivePerceptualQuestionnaireLocal = CognitivePerceptualQuestionnaire();
    cognitivePerceptualQuestionnaireLocal.cgoPcId = 0;

    /*
         int communicationRadioValue = 0;
  int primaryLanguageSpokenValue = 0;
  int hearingRadioValue = 0;
  int visionRadioValue = 0;
  int numbnessRadioValue = 0;
  String languageList = '';
  String hearingList = '';
  String visionList = '';
  String paraesthesiaNumbnessDesc = '';
  */

    if (communicationRadioValue != 0)
    {
      cognitivePerceptualQuestionnaireLocal.communicationId = communicationRadioValue;
    }

    if (primaryLanguageSpokenValue != 0)
    {
      cognitivePerceptualQuestionnaireLocal.languageId = primaryLanguageSpokenValue;
    }

    if (hearingRadioValue != 0)
    {
      cognitivePerceptualQuestionnaireLocal.hearingId = hearingRadioValue;
    }

    if (visionRadioValue != 0)
    {
      cognitivePerceptualQuestionnaireLocal.visionId = visionRadioValue;
    }

    if (numbnessRadioValue != 0)
    {
      cognitivePerceptualQuestionnaireLocal.isParaesthesiaNumbness = numbnessRadioValue == 1 ? true : false;
    }


    if (languageList != null)
    {
      cognitivePerceptualQuestionnaireLocal.languageList = languageList;
    }

    if (hearingList != null)
    {
      cognitivePerceptualQuestionnaireLocal.hearingList = hearingList;
    }
    if (visionList != null)
    {
      cognitivePerceptualQuestionnaireLocal.visionList = visionList;
    }
    if (paraesthesiaNumbnessDesc != null)
    {
      cognitivePerceptualQuestionnaireLocal.paraesthesiaNumbnessDesc = paraesthesiaNumbnessDesc;
    }

    ae.cognitivePerceptualQuestionnaire = cognitivePerceptualQuestionnaireLocal;
    ae.encounterId = _tokenService.selectedEncounterId;

    cogniitivePeceptualRepository.addNewCognitivePerceptual(ae);
  }

  updateExistingRecordCognitivePerceptual(CognitivePerceptual ae) async {

    if (communicationRadioValue != 0)
    {

      cognitivePerceptual.cognitivePerceptualQuestionnaire.communicationId= communicationRadioValue;
    }

    if (primaryLanguageSpokenValue != 0)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.languageId = primaryLanguageSpokenValue;
    }

    if (hearingRadioValue != 0)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.hearingId = hearingRadioValue;
    }

    if (visionRadioValue != 0)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.visionId = visionRadioValue;
    }

    if (numbnessRadioValue != 0)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.isParaesthesiaNumbness = numbnessRadioValue == 1 ? true : false;
    }


    if (languageList != null)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.languageList = languageList;
    }

    if (hearingList != null)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.hearingList = hearingList;
    }
    if (visionList != null)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.visionList = visionList;
    }
    if (paraesthesiaNumbnessDesc != null)
    {
      cognitivePerceptual.cognitivePerceptualQuestionnaire.paraesthesiaNumbnessDesc = paraesthesiaNumbnessDesc;
    }


    cogniitivePeceptualRepository.updateExistingCognitivePerceptual(ae);
  }

  getCommunication() async {
    var result = await cogniitivePeceptualRepository.getCommunication();
    result.fold(
          (Failure failure) => {},
          (data) => {
            print(data),
        communicationSubject$.sink.add(data),
      },
    );
  }

  getLangSpoken() async {
    var result = await cogniitivePeceptualRepository.getLangSpoken();
    result.fold(
          (Failure failure) => {},
          (data) => {
        langSpokenDeviceSubject$.sink.add(data),
      },
    );
  }

  getVision() async {
    var result = await cogniitivePeceptualRepository.getVision();
    result.fold(
          (Failure failure) => {},
          (data) => {
        visionSubject$.sink.add(data),
      },
    );
  }

  getHearing() async {
    var result = await cogniitivePeceptualRepository.getHearing();
    result.fold(
          (Failure failure) => {},
          (data) => {
        hearingSubject$.sink.add(data),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    communicationSubject$.close();
    langSpokenDeviceSubject$.close();
    visionSubject$.close();
    hearingSubject$.close();
  }
}
