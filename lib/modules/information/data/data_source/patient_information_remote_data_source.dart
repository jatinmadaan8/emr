import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/services/http_service.dart';

abstract class PatientInformationRemoteDataSource {
  Future<PatientInformationModel> getPatientInformation(int id);
  Future<void> addPatientInformation(
      PatientInformationModel patientInformationModel);
  Future<void> deletePatientInformation();
  Future<void> updatePatientInformation(
      PatientInformationModel patientInformation);

  Future<List<PatientInformationLookUpData>> getGender();
  Future<List<ReferralSources>> getReferralSources();
  Future<List<BillType>> getBillType();
  Future<List<Encounters>> getEncounters(int id);
  Future<List<DefaultProviderModel>> getDefaultProvider();
  Future<List<String>> getStates();
  Future<List<String>> getLanguage();
  Future<List<String>> getEthnicity();
  Future<List<String>> getReligion();
  Future<List<RaceNavigation>> getRace();

  Future<List<PreferredPhoneModel>> getPreferredPhone();
  Future<String> getImage(int patientId);
  Future<int> uploadImage(String imageBase64, int patientId);
}

class PatientInformationRemoteDataSourceImpl
    implements PatientInformationRemoteDataSource {
  final HttpService httpService;

  PatientInformationRemoteDataSourceImpl({@required this.httpService});

  @override
  Future<PatientInformationModel> getPatientInformation(int id) async {
    try {
      return httpService
          .get(path: '/api/PatientInformation/$id')
          .handleError((err) {
        throw Failure(code: err.code, message: err.message);
      }).map((_) {
        return PatientInformationModel.fromJson(_);
      }).first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  @override
  Future<void> addPatientInformation(
      PatientInformationModel patientInformationModel) async {
//    print("Add PatientInformation " +
//        jsonEncode(PatientInformationModel.toAddJson()));
//    try {
//      await httpService
//          .post(
//            url: '/api/PatientInformation',
//            encodedJson: jsonEncode(
//              PatientInformationModel.toAddJson(),
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
  Future<void> deletePatientInformation() {
    // TODO:
    return null;
  }

  @override
  Future<void> updatePatientInformation(
      PatientInformationModel patientInformationModel) async {
    print(jsonEncode(patientInformationModel.toUpdateJson()));

    try {
      await httpService
          .put(
        url: '/api/PatientInformation/${patientInformationModel.id}',
        encodedJson: jsonEncode(
          patientInformationModel.toUpdateJson(),
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

  @override
  Future<List<DefaultProviderModel>> getDefaultProvider() {
    try {
      return httpService
          .get(path: '/api/LookupData/DefaultProvider')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<DefaultProviderModel>.from(
              data.map((x) {
                return DefaultProviderModel.fromJson(x);
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
  Future<List<PreferredPhoneModel>> getPreferredPhone() {
    try {
      return httpService
          .get(path: '/api/LookupData/PreferredPhone')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<PreferredPhoneModel>.from(
              data.map((x) {
                return PreferredPhoneModel.fromJson(x);
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
  Future<List<String>> getLanguage() {
    try {
      return httpService
          .get(path: '/api/LookupData/Language')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<String>.from(
              data.map((x) {
                return x['value'];
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
  Future<List<String>> getEthnicity() {
    try {
      return httpService
          .get(path: '/api/LookupData/Ethnicity')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<String>.from(
              data.map((x) {
                return x['value'];
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
  Future<List<String>> getReligion() {
    try {
      return httpService
          .get(path: '/api/LookupData/Religion')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<String>.from(
              data.map((x) {
                return x['name'];
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
  Future<List<RaceNavigation>> getRace() {
    try {
      return httpService
          .get(path: '/api/LookupData/Race')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<RaceNavigation>.from(
              data.map((x) {
                return RaceNavigation.fromJson(x);
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
  Future<String> getImage(int patientId) {
    try {
      return httpService
          .get(path: '/api/PatientChartHeader/$patientId')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => data['picture'] as String)
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<int> uploadImage(String imageBase64, int patientId) {
    try {
      return httpService
          .post(
            url: '/api/PatientChartHeader/uploadImage',
            encodedJson: jsonEncode({
              "patientId": patientId,
              "image": imageBase64,
            }),
          )
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map((data) => data as int)
          .first;
    } catch (e) {
      throw Failure(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<BillType>> getBillType() {
    try {
      return httpService
          .get(path: '/api/LookupData/BillType')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<BillType>.from(
              data.map((x) {
                return BillType.fromJson(x);
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
  Future<List<PatientInformationLookUpData>> getGender() {
    try {
      return httpService
          .get(path: '/api/LookupData/Gender')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<PatientInformationLookUpData>.from(
              data.map((x) {
                return PatientInformationLookUpData.fromJson(x);
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
  Future<List<ReferralSources>> getReferralSources() {
    try {
      return httpService
          .get(path: '/api/LookupData/ReferralSources')
          .handleError((err) {
            throw Failure(code: err.code, message: err.message);
          })
          .map(
            (data) => List<ReferralSources>.from(
              data.map((x) {
                return ReferralSources.fromJson(x);
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
}
