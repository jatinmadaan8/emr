import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';

abstract class OtherInformationRepository {
  Future<Either<Failure, List<OtherInformationModel>>> getOtherInformation(
      int id);
  Future<Either<Failure, bool>> updateOtherInformation(
      OtherInformationModel otherInformation);
  Future<Either<Failure, bool>> addOtherInformation(
      OtherInformationModel otherInformation);
  Future<Either<Failure, List<String>>> getStates();
  Future<Either<Failure, List<PublicityCodeNavigation>>> getPublicity();
  Future<Either<Failure, List<RegistryStatusCodeNavigation>>> getRegistryStatus();
  Future<Either<Failure, List<String>>> getRelationship();

//  Future<Either<Failure, List<OtherInformationLookUpData>>> getDropDown(
//      String dropDownName);
//  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
//  Future<Either<Failure, List<DefaultProviderModel>>> getDefaultProvider();
//  Future<Either<Failure, List<String>>> getLanguage();
//  Future<Either<Failure, List<String>>> getEthnicity();
//  Future<Either<Failure, List<String>>> getReligion();
//  Future<Either<Failure, List<RaceNavigation>>> getRace();
//
//  Future<Either<Failure, List<PreferredPhoneModel>>> getPreferredPhone();
}

class OtherInformationRepositoryImpl implements OtherInformationRepository {
  final OtherInformationRemoteDataSource otherInformationRemoteDataSource;
  final OtherInformationLocalDataSource otherInformationLocalDataSource;
  final NetworkInfo networkInfo;

  OtherInformationRepositoryImpl({
    @required this.otherInformationRemoteDataSource,
    @required this.otherInformationLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<OtherInformationModel>>> getOtherInformation(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await otherInformationRemoteDataSource.getOtherInformation(id);
        return Right(result);
      } catch (e) {
        print(e.toString());
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, bool>> updateOtherInformation(
      OtherInformationModel otherInformation) async {
    if (await networkInfo.isConnected) {
      try {
        await otherInformationRemoteDataSource
            .updateOtherInformation(otherInformation);
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
  Future<Either<Failure, bool>> addOtherInformation(
      OtherInformationModel otherInformation) async {
    if (await networkInfo.isConnected) {
      try {
        await otherInformationRemoteDataSource
            .addOtherInformation(otherInformation);
        return Right(true);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

//  @override
//  Future<Either<Failure, List<OtherInformationLookUpData>>> getDropDown(
//      String dropdownName) async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result =
//            await otherInformationRemoteDataSource.getDropDown(dropdownName);
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result =
//            await otherInformationRemoteDataSource.getEncounters(id);
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<DefaultProviderModel>>>
//      getDefaultProvider() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result =
//            await otherInformationRemoteDataSource.getDefaultProvider();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
  @override
  Future<Either<Failure, List<String>>> getStates() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await otherInformationRemoteDataSource.getStates();
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
  Future<Either<Failure, List<PublicityCodeNavigation>>> getPublicity() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await otherInformationRemoteDataSource.getPublicity();
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
  Future<Either<Failure, List<RegistryStatusCodeNavigation>>> getRegistryStatus() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await otherInformationRemoteDataSource.getRegistryStatus();
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
  Future<Either<Failure, List<String>>> getRelationship() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await otherInformationRemoteDataSource.getRelationship();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
//
//  @override
//  Future<Either<Failure, List<PreferredPhoneModel>>> getPreferredPhone() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result =
//            await otherInformationRemoteDataSource.getPreferredPhone();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<String>>> getLanguage() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result = await otherInformationRemoteDataSource.getLanguage();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<String>>> getEthnicity() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result = await otherInformationRemoteDataSource.getEthnicity();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<String>>> getReligion() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result = await otherInformationRemoteDataSource.getReligion();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
//
//  @override
//  Future<Either<Failure, List<RaceNavigation>>> getRace() async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result = await otherInformationRemoteDataSource.getRace();
//        return Right(result);
//      } catch (e) {
//        return Left(e);
//      }
//    } else {
//      // TODO: implement local storage operations
//    }
//    return null;
//  }
}
