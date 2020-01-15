import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/soa/soa_note.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/soa_note_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SoaNoteBloc implements BaseBloc {
  static const sectionName = 'RESOA';
  int modelId;

  final SoaNoteRepository soaNoteRepo;
  TokenService _tokenService = TokenService();
  SoaNote soaNoteData;

  BehaviorSubject<SoaNote> soaNote = BehaviorSubject<SoaNote>();
  Observable<SoaNote> get soaNoteObservable => soaNote.stream;

  SoaNoteBloc({@required this.soaNoteRepo});

  getChiefComplaint() async {
    var resultEncounters =
        await soaNoteRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        modelId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (modelId > 0) {
      var result = await soaNoteRepo.getSoaNote(modelId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          soaNoteData = data,
          soaNote.sink.add(data),
        },
      );
    } else {
      soaNoteData = SoaNote();
    }
  }

  void addSoaNote() async {
    soaNoteData.encounterId = _tokenService.selectedEncounterId;
    var result = await soaNoteRepo.addSoaNote(soaNoteData);
    if (soaNoteData.id == null) {
      getChiefComplaint();
    }
  }

  void initialize() async {
    getChiefComplaint();
  }

  @override
  void dispose() {
    soaNote.close();
  }
}
