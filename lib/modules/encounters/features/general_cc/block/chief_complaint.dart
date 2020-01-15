import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/base_bloc.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/general_cc/chief_complaint.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/genric_drop_down.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/general_cc.repository.dart';
import 'package:rxdart/rxdart.dart';

class ChiefComplaintBloc implements BaseBloc {
  static const sectionName = 'RCHIE';
  int chiefComplaintId;
  final GeneralCCRepository generalCCRepo;
  TokenService _tokenService = TokenService();
  BehaviorSubject<List<GenricDropDown>> informant =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get informantListObservable =>
      informant.stream;

  BehaviorSubject<List<GenricDropDown>> methodOfArrival =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get methodOfArrivalListObservable =>
      methodOfArrival.stream;

  BehaviorSubject<List<GenricDropDown>> officeVisitReason =
      BehaviorSubject<List<GenricDropDown>>();

  Observable<List<GenricDropDown>> get officeVisitReasonObservable =>
      officeVisitReason.stream;

  BehaviorSubject<ChiefComplaint> chiefComplaint =
      BehaviorSubject<ChiefComplaint>();

  Observable<ChiefComplaint> get chiefComplaintObservable =>
      chiefComplaint.stream;

  ChiefComplaint chiefComplaintData = ChiefComplaint();

  ChiefComplaintBloc({@required this.generalCCRepo});

  getInformant() async {
    var result = await generalCCRepo.getDropDown('Informant');
    result.fold(
      (Failure failure) => {},
      (data) => {
        informant.sink.add(data),
      },
    );
  }

  getChiefComplaint() async {
    var resultEncounters =
        await generalCCRepo.getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) => {},
      (data) => {
        chiefComplaintId = data.firstWhere((value) {
          return value.sectionName == sectionName;
        }).id,
      },
    );
    if (chiefComplaintId > 0) {
      var result = await generalCCRepo.getChiefComplaint(chiefComplaintId);
      result.fold(
        (Failure failure) => {},
        (data) => {
          chiefComplaintData = data,
          chiefComplaint.sink.add(data),
        },
      );
    }
  }

  getMethodOfArrival() async {
    var result = await generalCCRepo.getDropDown('MethodOfArrival');
    result.fold(
      (Failure failure) => {},
      (data) => {methodOfArrival.sink.add(data)},
    );
  }

  getOfficeVisitReason() async {
    var result = await generalCCRepo.getDropDown('OfficeVisitReason');
    result.fold(
      (Failure failure) => {},
      (data) => {officeVisitReason.sink.add(data)},
    );
  }

  void initialize() async {
    getOfficeVisitReason();
    getMethodOfArrival();
    getInformant();
    await getChiefComplaint();
  }

  void saveChiefComplaint() async {
    chiefComplaintData.encounterId = _tokenService.selectedEncounterId;
    if (chiefComplaintData.id == null) {
      var result = await generalCCRepo.addChiefComplaint(chiefComplaintData);
      getChiefComplaint();
    }
    if (chiefComplaintData.id != null) {
      var result = generalCCRepo.updateChiefComplaint(chiefComplaintData);
      var s = result;
    }
  }

  @override
  void dispose() {
    informant.close();
    methodOfArrival.close();
    officeVisitReason.close();
    chiefComplaint.close();
  }
}
