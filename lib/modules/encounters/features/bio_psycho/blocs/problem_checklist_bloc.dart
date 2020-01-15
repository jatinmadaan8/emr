import 'package:meta/meta.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/services/token_service.dart';
import '../../../../../core/base_bloc.dart';
import '../../../../../modules/encounters/data/models/bio_psycho/problem_checklist.dart';
import '../../../../../modules/encounters/data/repository/bio_psycho/problem_checklist.repository.dart';
import 'package:rxdart/rxdart.dart';

class ProblemChecklistBloc implements BaseBloc {
  final sectionName = 'RPROB';
  int probId;
  bool psychoSocialStressorsCB = false;
  final ProblemChecklistRepository problemChecklistRepo;

  TokenService _tokenService = TokenService();
  ProblemChecklist problemChecklistData;
  List<Psychostress> psychosocialStressorsList = [];
  List<PsychostressDisplay> psychosocialStressorsDisplayList = [];

  BehaviorSubject<ProblemChecklist> problemChecklistSubject;
  Observable<ProblemChecklist> problemChecklistObservable;
  BehaviorSubject<List<Psychostress>> psychosocialStressors =
      BehaviorSubject<List<Psychostress>>();
  Observable<List<Psychostress>> get psychosocialStressorsListObservable =>
      psychosocialStressors.stream;
  BehaviorSubject<List<PsychostressDisplay>> psychosocialStressorsDisplay =
      BehaviorSubject<List<PsychostressDisplay>>();
  Observable<List<PsychostressDisplay>>
      get psychosocialStressorsDisplayObservable =>
          psychosocialStressorsDisplay.stream;

  ProblemChecklistBloc({@required this.problemChecklistRepo}) {
    problemChecklistSubject = BehaviorSubject<ProblemChecklist>();
    problemChecklistObservable = problemChecklistSubject.stream;
  }

  getProblemChecklist() async {
    var resultEncounters = await problemChecklistRepo
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (failure) => {},
      (data) => {
        probId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (probId > 0) {
      final result = await problemChecklistRepo.getProblemChecklist(probId);
      result.fold(
        (failure) => problemChecklistSubject.sink.addError(failure.message),
        (data) => {
          problemChecklistData = data,
          problemChecklistSubject.sink.add(data)
        },
      );
    } else {
      problemChecklistData = new ProblemChecklist(
        id: null,
        encounterId: null,
        haveCurrentHealthIssues: false,
        havePainConcerns: false,
        problemsPsychoStress: [
          new ProblemsPsychoStress(
            id: null,
            pcId: null,
            psychoStressId: null,
            psychoStressDesc: '',
            psychostress: new Psychostress(id: null, name: ''),
          ),
        ],
      );
      problemChecklistSubject.sink.add(problemChecklistData);
    }
  }

  getPsychosocialStressors() async {
    var result = await problemChecklistRepo.getPsychosocialStressors();
    result.fold(
      (Failure failure) => {},
      (data) => {
        psychosocialStressorsList = data,
        psychosocialStressors.sink.add(data)
      },
    );
  }

  updatePainManagement() {
    problemChecklistData.havePainConcerns =
        !problemChecklistData.havePainConcerns;
    problemChecklistSubject.sink.add(problemChecklistData);
  }

  updateCurrentHealth() {
    problemChecklistData.haveCurrentHealthIssues =
        !problemChecklistData.haveCurrentHealthIssues;
    problemChecklistSubject.sink.add(problemChecklistData);
  }

  updatePsychoSocialStressorsCB() {
    psychoSocialStressorsCB = !psychoSocialStressorsCB;
    if (psychoSocialStressorsCB) {
      psychosocialStressorsDisplayList.forEach((f) {
        f.reported = false;
        f.description = '';
      });
    }
    problemChecklistSubject.sink.add(problemChecklistData);
  }

  updateProblemChecklist() {
    psychosocialStressorsDisplayList = [];
    if (problemChecklistData.problemsPsychoStress.length > 0) {
      psychosocialStressorsList.forEach((f) {
        bool found = false;
        problemChecklistData.problemsPsychoStress.forEach((x) {
          if (x.psychostress.name == f.name) {
            found = true;
            psychosocialStressorsDisplayList.add(new PsychostressDisplay(
                id: f.id,
                name: f.name,
                reported: true,
                description: x.psychoStressDesc));
          }
        });
        if (!found) {
          psychosocialStressorsDisplayList.add(new PsychostressDisplay(
              id: f.id, name: f.name, reported: false, description: ''));
        }
      });
    }
    psychosocialStressorsDisplay.sink.add(psychosocialStressorsDisplayList);
  }

  updatePsychosocialStressorReported(bool value, int id) {
    psychosocialStressorsDisplayList.forEach((f) {
      if (f.id == id) {
        f.reported = value;
        if (value == false) {
          f.description = '';
        }
      }
    });
    psychosocialStressorsDisplay.sink.add(psychosocialStressorsDisplayList);
  }

  updatePsychosocialStressorDesc(String value, int id) {
    psychosocialStressorsDisplayList.forEach((f) {
      if (f.id == id) {
        f.description = value;
      }
    });
  }

  void initialize() async {
    getPsychosocialStressors();
    await getProblemChecklist();
    await updateProblemChecklist();
  }

  savecheckList() async {
    problemChecklistData.problemsPsychoStress = [];
    psychosocialStressorsDisplayList.forEach((psychoStressor) {
      if (psychoStressor.reported) {
        problemChecklistData.problemsPsychoStress.add(new ProblemsPsychoStress(
          psychoStressId: psychoStressor.id,
          psychoStressDesc: psychoStressor.description,
        ));
      }
    });
    problemChecklistData.encounterId = _tokenService.selectedEncounterId;
    return await problemChecklistRepo.addProblemChecklist(problemChecklistData);
  }

  @override
  void dispose() {
    problemChecklistSubject.close();
    psychosocialStressors.close();
    psychosocialStressorsDisplay.close();
  }
}
