import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/patient_information_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/patient_information_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/patient_information.dart';

abstract class PatientInformationRepository {
  Future<Either<Failure, PatientInformationModel>> getPatientInformation(
      int id);
  Future<Either<Failure, bool>> updatePatientInformation(
      PatientInformationModel patientInformation);
  Future<Either<Failure, bool>> addPatientInformation(
      PatientInformationModel patientInformation);

  Future<Either<Failure, List<PatientInformationLookUpData>>> getGender();
  Future<Either<Failure, List<ReferralSources>>> getReferralSources();
  Future<Either<Failure, List<BillType>>> getBillType();

  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
  Future<Either<Failure, List<DefaultProviderModel>>> getDefaultProvider();
  Future<Either<Failure, List<String>>> getStates();
  Future<Either<Failure, List<String>>> getLanguage();
  Future<Either<Failure, List<String>>> getEthnicity();
  Future<Either<Failure, List<String>>> getReligion();
  Future<Either<Failure, List<RaceNavigation>>> getRace();

  Future<Either<Failure, String>> getImage(int patientId);
  Future<Either<Failure, int>> uploadImage(String imageBase64, int patientId);

  Future<Either<Failure, List<PreferredPhoneModel>>> getPreferredPhone();
}

class PatientInformationRepositoryImpl implements PatientInformationRepository {
  final PatientInformationRemoteDataSource patientInformationRemoteDataSource;
  final PatientInformationLocalDataSource patientInformationLocalDataSource;
  final NetworkInfo networkInfo;

  PatientInformationRepositoryImpl({
    @required this.patientInformationRemoteDataSource,
    @required this.patientInformationLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PatientInformationModel>> getPatientInformation(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getPatientInformation(id);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> updatePatientInformation(
      PatientInformationModel patientInformation) async {
    if (await networkInfo.isConnected) {
      try {
        await patientInformationRemoteDataSource
            .updatePatientInformation(patientInformation);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> addPatientInformation(
      PatientInformationModel patientInformation) async {
    if (await networkInfo.isConnected) {
      try {
        await patientInformationRemoteDataSource
            .addPatientInformation(patientInformation);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getEncounters(id);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<DefaultProviderModel>>>
      getDefaultProvider() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getDefaultProvider();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<String>>> getStates() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getStates();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<PreferredPhoneModel>>> getPreferredPhone() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getPreferredPhone();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<String>>> getLanguage() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getLanguage();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<String>>> getEthnicity() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getEthnicity();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<String>>> getReligion() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getReligion();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<RaceNavigation>>> getRace() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getRace();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, String>> getImage(int patientId) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getImage(patientId);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, int>> uploadImage(
      String imageBase64, int patientId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.uploadImage(
            imageBase64, patientId);
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<BillType>>> getBillType() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getBillType();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<PatientInformationLookUpData>>>
      getGender() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await patientInformationRemoteDataSource.getGender();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<ReferralSources>>> getReferralSources() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await patientInformationRemoteDataSource.getReferralSources();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
}
