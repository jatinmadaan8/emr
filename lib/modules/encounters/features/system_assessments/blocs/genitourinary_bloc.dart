import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/services/token_service.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/genitourinary.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/repository/genitourinary.repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/base_bloc.dart';

class GenitourinaryBloc implements BaseBloc {
  static const sectionName = 'RGENI';
  int _modelId;
  GenitourinaryModel _genitourinary;

  final GenitourinaryRepository genitourinaryRepository;
  TokenService _tokenService = TokenService();

  GenitourinaryBloc({@required this.genitourinaryRepository});

  BehaviorSubject<GenitourinaryModel> _genitourinarySubject =
      BehaviorSubject<GenitourinaryModel>();
  Observable<GenitourinaryModel> get genitourinaryObservable =>
      _genitourinarySubject.stream;

  BehaviorSubject<List<GenitourinaryLookUpModel>> _urineColorSubject =
      BehaviorSubject<List<GenitourinaryLookUpModel>>();
  Observable<List<GenitourinaryLookUpModel>> get urineColor =>
      _urineColorSubject.stream;

  BehaviorSubject<List<GenitourinaryLookUpModel>> _urineCathetersSubject =
      BehaviorSubject<List<GenitourinaryLookUpModel>>();
  Observable<List<GenitourinaryLookUpModel>> get urineCatheters =>
      _urineCathetersSubject.stream;

  BehaviorSubject<List<GenitourinaryLookUpModel>> _bladderSymptomsSubject =
      BehaviorSubject<List<GenitourinaryLookUpModel>>();
  Observable<List<GenitourinaryLookUpModel>> get bladderSymptoms =>
      _bladderSymptomsSubject.stream;

  getGenitourinary() async {
    var resultEncounters = await genitourinaryRepository
        .getEncounters(_tokenService.selectedEncounterId);
    resultEncounters.fold(
      (Failure failure) {},
      (data) {
        var _correspondData = data.where((value) {
          return value.sectionName == sectionName;
        }).toList();

        _modelId = (_correspondData != null && _correspondData.length > 0)
            ? _correspondData.first.id
            : -1;
      },
    );

    if (_modelId > 0) {
      final result = await genitourinaryRepository.getGenitourinary(_modelId);

      result.fold(
        (failure) => _genitourinarySubject.sink.addError(failure.message),
        (genitourinary) {
          _genitourinary = genitourinary;
          _genitourinarySubject.sink.add(genitourinary);
        },
      );
    } else {
      _genitourinarySubject.sink.add(GenitourinaryModel(
        encounterId: _tokenService.selectedEncounterId,
      ));
    }
  }

  getUrineColor() async {
    var result = await genitourinaryRepository.getDropDown('UrineColor');
    result.fold(
      (failure) => _urineColorSubject.sink.addError(failure.message),
      (data) => _urineColorSubject.sink.add(data),
    );
  }

  getUrineCatheters() async {
    var result = await genitourinaryRepository.getDropDown('UrineCatheters');
    result.fold(
      (failure) => _urineCathetersSubject.sink.addError(failure.message),
      (data) => _urineCathetersSubject.sink.add(data),
    );
  }

  getBladderSymptoms() async {
    var result = await genitourinaryRepository.getDropDown('BladderSymptoms');
    result.fold(
      (failure) => _bladderSymptomsSubject.sink.addError(failure.message),
      (data) => _bladderSymptomsSubject.sink.add(data),
    );
  }

  onSavePressed(GenitourinaryModel genitourinary) async {
    if (_modelId > 0) {
      var result =
          await genitourinaryRepository.updateGenitourinary(genitourinary);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Genitourinary BLOC : Updated " + data.toString()),
      );
    } else {
      var result =
          await genitourinaryRepository.addGenitourinary(genitourinary);
      result.fold(
        // todo
        (failure) => {},
        (data) => print("Genitourinary BLOC : Added " + data.toString()),
      );
    }
  }

  void initialize() async {
    Future.wait(<Future>[
      getUrineColor(),
      getUrineCatheters(),
      getBladderSymptoms(),
    ]);
    await getGenitourinary();
  }

  @override
  void dispose() {
    _genitourinarySubject.close();
    _urineColorSubject.close();
    _urineCathetersSubject.close();
    _bladderSymptomsSubject.close();
  }
}
