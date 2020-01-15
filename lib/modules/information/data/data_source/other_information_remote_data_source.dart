import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class OtherInformationRemoteDataSource {
  Future<List<OtherInformationModel>> getOtherInformation(int id);
  Future<void> addOtherInformation(OtherInformationModel otherInformationModel);
  Future<void> deleteOtherInformation();
  Future<void> updateOtherInformation(OtherInformationModel otherInformation);

  Future<List<Encounters>> getEncounters(int id);
  Future<List<String>> getStates();
  Future<List<PublicityCodeNavigation>> getPublicity();
  Future<List<RegistryStatusCodeNavigation>> getRegistryStatus();
  Future<List<String>> getRelationship();
//  Future<List<OtherInformationLookUpData>> getDropDown(String value);
//  Future<List<DefaultProviderModel>> getDefaultProvider();
//  Future<List<String>> getLanguage();
//  Future<List<String>> getEthnicity();
//  Future<List<String>> getReligion();
//  Future<List<RaceNavigation>> getRace();
//  Future<List<PreferredPhoneModel>> getPreferredPhone();
}

class OtherInformationRemoteDataSourceImpl
    implements OtherInformationRemoteDataSource {
  final HttpService httpService;

  OtherInformationRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<OtherInformationModel>> getOtherInformation(int id) async {
    try {
      return httpService
          .get(path: '/api/OtherInformation/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<OtherInformationModel>.from(
              data.map((x) {
                return OtherInformationModel.fromJson(x);
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

  @override
  @override
  Future<void> addOtherInformation(
      OtherInformationModel otherInformationModel) async {
//    print("Add OtherInformation " +
//        jsonEncode(OtherInformationModel.toAddJson()));
//    try {
//      await httpService
//          .post(
//            url: '/api/OtherInformation',
//            encodedJson: jsonEncode(
//              OtherInformationModel.toAddJson(),
//            ),
//          )
//          .handleError(
//            (err) => throw Failure(code: err.code, message: err.message),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
  }

  @override
  Future<void> deleteOtherInformation() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateOtherInformation(
      OtherInformationModel otherInformationModel) async {
    print("Update Other Information " +
        jsonEncode(otherInformationModel.toJson()));

    try {
      await httpService
          .put(
        url: '/api/OtherInformation/${otherInformationModel.id}',
        encodedJson: jsonEncode(
          otherInformationModel.toUpdateJson(),
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

//  @override
//  Future<List<OtherInformationLookUpData>> getDropDown(String value) {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/' + value)
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<OtherInformationLookUpData>.from(
//              data.map((x) {
//                return OtherInformationLookUpData.fromJson(x);
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
//
//
//  @override
//  Future<List<DefaultProviderModel>> getDefaultProvider() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/DefaultProvider')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<DefaultProviderModel>.from(
//              data.map((x) {
//                return DefaultProviderModel.fromJson(x);
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
  @override
  Future<List<String>> getStates() async {
    try {
      return httpService
          .get(path: '/api/LookupData/State')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<String>.from(data),
          )
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<PublicityCodeNavigation>> getPublicity() async {
    try {
      return httpService
          .get(path: '/api/LookupData/PublicityCode')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<PublicityCodeNavigation>.from(
              data.map((x) {
                return PublicityCodeNavigation.fromJson(x);
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

  @override
  Future<List<RegistryStatusCodeNavigation>> getRegistryStatus() async {
    try {
      return httpService
          .get(path: '/api/LookupData/RegistryStatusCode')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<RegistryStatusCodeNavigation>.from(
              data.map((x) {
                return RegistryStatusCodeNavigation.fromJson(x);
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

  @override
  Future<List<String>> getRelationship() async {
    try {
      return httpService
          .get(path: '/api/LookupData/RelationShip')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<String>.from(data),
          )
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }
//
//  @override
//  Future<List<PreferredPhoneModel>> getPreferredPhone() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/PreferredPhone')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<PreferredPhoneModel>.from(
//              data.map((x) {
//                return PreferredPhoneModel.fromJson(x);
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
//  @override
//  Future<List<String>> getLanguage() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/Language')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<String>.from(
//              data.map((x) {
//                return x['value'];
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
//  @override
//  Future<List<String>> getEthnicity() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/Ethnicity')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<String>.from(
//              data.map((x) {
//                return x['value'];
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
//  @override
//  Future<List<String>> getReligion() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/Religion')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<String>.from(
//              data.map((x) {
//                return x['name'];
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
//
//  @override
//  Future<List<RaceNavigation>> getRace() {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/Race')
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<RaceNavigation>.from(
//              data.map((x) {
//                return RaceNavigation.fromJson(x);
//              }),
//            ),
//          )
//          .first;
//    } catch (e) {
//      throw Failure(
//        message: e.toString(),
//      );
//    }
//  }
}
