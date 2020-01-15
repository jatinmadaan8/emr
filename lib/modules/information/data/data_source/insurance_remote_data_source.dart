import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class InsuranceRemoteDataSource {
  Future<List<InsuranceModel>> getInsurance(int id);
  Future<void> addInsurance(InsuranceModel insuranceModel);
  Future<void> deleteInsurance();
  Future<void> updateInsurance(InsuranceModel insurance);

  Future<List<Encounters>> getEncounters(int id);
  Future<List<String>> getStates();
  Future<List<GenderNavigation>> getGender();
  Future<List<PrefferedContactNavigation>> getPrefferedContact();
  // Future<List<PublicityCodeNavigation>> getPublicity();
  // Future<List<RegistryStatusCodeNavigation>> getRegistryStatus();
  Future<List<String>> getRelationship();
  
//  Future<List<InsuranceLookUpData>> getDropDown(String value);
//  Future<List<DefaultProviderModel>> getDefaultProvider();
//  Future<List<String>> getLanguage();
//  Future<List<String>> getEthnicity();
//  Future<List<String>> getReligion();
//  Future<List<RaceNavigation>> getRace();
//  Future<List<PreferredPhoneModel>> getPreferredPhone();
}

class InsuranceRemoteDataSourceImpl
    implements InsuranceRemoteDataSource {
  final HttpService httpService;

  InsuranceRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<List<InsuranceModel>> getInsurance(int id) async {
    try {
      return httpService
          .get(path: '/api/InsurancePolicy/$id')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<InsuranceModel>.from(
              data.map((x) {
                return InsuranceModel.fromJson(x);
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
  Future<void> addInsurance(
      InsuranceModel insuranceModel) async {
//    print("Add Insurance " +
//        jsonEncode(InsuranceModel.toAddJson()));
//    try {
//      await httpService
//          .post(
//            url: '/api/Insurance',
//            encodedJson: jsonEncode(
//              InsuranceModel.toAddJson(),
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
  Future<void> deleteInsurance() {
    // TODO:
    return null;
  }

  @override
  Future<void> updateInsurance(
      InsuranceModel insuranceModel) async {
    print("Update Other Information " +
        jsonEncode(insuranceModel.toJson()));

    try {
      await httpService
          .put(
        url: '/api/Insurance/${insuranceModel.id}',
        encodedJson: jsonEncode(
          insuranceModel.toUpdateJson(),
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
//  Future<List<InsuranceLookUpData>> getDropDown(String value) {
//    try {
//      return httpService
//          .get(path: '/api/LookupData/' + value)
//          .handleError((err) {
//            throw Failure(code: err.code, message: err.message);
//          })
//          .map(
//            (data) => List<InsuranceLookUpData>.from(
//              data.map((x) {
//                return InsuranceLookUpData.fromJson(x);
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
  Future<List<GenderNavigation>> getGender() async {
    try {
      return httpService
          .get(path: '/api/LookupData/Gender')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<GenderNavigation>.from(
              data.map((x) {
                return GenderNavigation.fromJson(x);
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
  Future<List<PrefferedContactNavigation>> getPrefferedContact() async {
    try {
      return httpService
          .get(path: '/api/LookupData/PreferredPhone')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<PrefferedContactNavigation>.from(
              data.map((x) {
                return PrefferedContactNavigation.fromJson(x);
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
