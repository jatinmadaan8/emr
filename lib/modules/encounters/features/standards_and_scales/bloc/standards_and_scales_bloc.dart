import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/standards_scales/standards_scales.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/standards_scales_repository.dart';
import '../../../../../core/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class StandardsAndScalesBloc implements BaseBloc {
  static const sectionName = 'RESOA';
  int modelId;
  bool isLoading = false;
  int selectedForm = null;
  final StandardsAndScalesRepository standardsAndScalesRepo;
  TokenService _tokenService = TokenService();

  List<StandardsAndScalesForm> standardsAndScalesFormData = [];

  BehaviorSubject<List<StandardsAndScales>> standardsAndScales =
      BehaviorSubject<List<StandardsAndScales>>();
  Observable<List<StandardsAndScales>> get standardsAndScalesObservable =>
      standardsAndScales.stream;

  BehaviorSubject<List<StandardsAndScalesForm>> standardsAndScalesForm =
      BehaviorSubject<List<StandardsAndScalesForm>>();
  Observable<List<StandardsAndScalesForm>>
      get standardsAndScalesFormObservable => standardsAndScalesForm.stream;

  StandardsAndScalesBloc({@required this.standardsAndScalesRepo});

  getStandardsAndScales() async {
    var result = await standardsAndScalesRepo.getStandardsAndScales();
    result.fold(
      (Failure failure) => {},
      (data) => {
        standardsAndScales.sink.add(data),
      },
    );
  }

  getStandardsAndScalesForm() async {
    isLoading = true;
    var result = await standardsAndScalesRepo
        .getStandardsAndScalesForm(_tokenService.selectedEncounterId);
    isLoading = false;
    result.fold(
      (Failure failure) => {},
      (data) => {
        standardsAndScalesFormData = data,
        standardsAndScalesForm.sink.add(data),
      },
    );
  }

  onSelectForm(int id) {
    var list = standardsAndScalesFormData.toList();
    var isExist = false;
    if (list != null && list.length > 0) {
      for (var i = 0; i < list.length; i++) {
        if (id == list[i].screenerId) {
          isExist = true;
        }
      }
    }
    if (isExist == false) {
      addStandardsAndScales(id);
    }
  }

  void addStandardsAndScales(int id) async {
    AddStandardsAndScale addStandardsAndScale = AddStandardsAndScale();
    addStandardsAndScale.encounterId = _tokenService.selectedEncounterId;
    addStandardsAndScale.screenerId = id;
    await standardsAndScalesRepo.addStandardsAndScales(addStandardsAndScale);
    getStandardsAndScalesForm();
  }

  void initialize() async {
    getStandardsAndScales();
    getStandardsAndScalesForm();
  }

  @override
  void dispose() {
    standardsAndScales.close();
    standardsAndScalesForm.close();
  }
}
