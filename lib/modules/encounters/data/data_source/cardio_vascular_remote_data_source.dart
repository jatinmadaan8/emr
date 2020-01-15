import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/cardio_vascular.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class CardioVascularRemoteDataSource {
  Future<CardioVascularModel> getCardioVascular(int id);
  Future<void> addCardioVascular(CardioVascularModel cardioVascularModel);
  Future<void> deleteCardioVascular();
  Future<void> updateCardioVascular(CardioVascularModel cardioVascular);

  Future<List<CardioVascularDropDown>> getDropDown(String value);
  Future<List<Encounters>> getEncounters(int id);
}

class CardioVascularRemoteDataSourceImpl
    implements CardioVascularRemoteDataSource {
  final HttpService httpService;

  CardioVascularRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<CardioVascularModel> getCardioVascular(int id) async {
    try {
      return httpService
          .get(path: '/api/CardioVascular/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((_) => CardioVascularModel.fromJson(_))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addCardioVascular(
      CardioVascularModel cardioVascularModel) async {
    print("Add Cardio " +
        jsonEncode(
          cardioVascularModel.toAddJson(),
        ));
    try {
      await httpService
          .post(
              url: '/api/CardioVascular',
              encodedJson: jsonEncode(
                cardioVascularModel.toAddJson(),
              ))
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteCardioVascular() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateCardioVascular(
      CardioVascularModel cardioVascularModel) async {
    print(jsonEncode(cardioVascularModel.toUpdateJson()));
    try {
      await httpService
          .put(
        url: '/api/CardioVascular/${cardioVascularModel.id}',
        encodedJson: jsonEncode(
          cardioVascularModel.toUpdateJson(),
        ),
      )
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<CardioVascularDropDown>> getDropDown(String value) {
    try {
      return httpService
          .get(path: '/api/LookupData/' + value)
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<CardioVascularDropDown>.from(
              data.map((x) {
                return CardioVascularDropDown.fromJson(x);
              }),
            ),
          )
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  Future<List<Encounters>> getEncounters(int id) {
    try {
      return httpService
          .get(path: '/api/Encounters/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => List<Encounters>.from(data.map((x) {
                return Encounters.fromMap(x);
              })))
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
}
