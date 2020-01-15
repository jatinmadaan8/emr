import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/insurance_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/insurance_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/data_source/other_information_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/insurance.dart';
import 'package:practiceinsights_emr_provider/modules/information/data/models/other_information.dart';

abstract class InsuranceRepository {
  Future<Either<Failure, List<InsuranceModel>>> getInsurance(
      int id);
  Future<Either<Failure, bool>> updateInsurance(
      InsuranceModel insurance);
  Future<Either<Failure, bool>> addInsurance(
      InsuranceModel insurance);
  Future<Either<Failure, List<String>>> getStates();
  Future<Either<Failure, List<GenderNavigation>>> getGender();
  Future<Either<Failure, List<String>>> getRelationship();
  Future<Either<Failure, List<PrefferedContactNavigation>>> getPrefferedContact();
  // Future<Either<Failure, List<RegistryStatusCodeNavigation>>> getRegistryStatus();
//  Future<Either<Failure, List<InsuranceLookUpData>>> getDropDown(
//      String dropDownName);
//  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
//  Future<Either<Failure, List<DefaultProviderModel>>> getDefaultProvider();
//  Future<Either<Failure, List<String>>> getLanguage();
//  Future<Either<Failure, List<String>>> getEthnicity();
//  Future<Either<Failure, List<String>>> getReligion();
//  Future<Either<Failure, List<RaceNavigation>>> getRace();
//
}

class InsuranceRepositoryImpl implements InsuranceRepository {
  final InsuranceRemoteDataSource insuranceRemoteDataSource;
  final InsuranceLocalDataSource insuranceLocalDataSource;
  final NetworkInfo networkInfo;

  InsuranceRepositoryImpl({
    @required this.insuranceRemoteDataSource,
    @required this.insuranceLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<InsuranceModel>>> getInsurance(
      int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await insuranceRemoteDataSource.getInsurance(id);
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
  Future<Either<Failure, bool>> updateInsurance(
      InsuranceModel insurance) async {
    if (await networkInfo.isConnected) {
      try {
        await insuranceRemoteDataSource
            .updateInsurance(insurance);
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
  Future<Either<Failure, bool>> addInsurance(
      InsuranceModel insurance) async {
    if (await networkInfo.isConnected) {
      try {
        await insuranceRemoteDataSource
            .addInsurance(insurance);
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
//  Future<Either<Failure, List<InsuranceLookUpData>>> getDropDown(
//      String dropdownName) async {
//    if (await networkInfo.isConnected) {
//      try {
//        final result =
//            await InsuranceRemoteDataSource.getDropDown(dropdownName);
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
//            await InsuranceRemoteDataSource.getEncounters(id);
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
//            await InsuranceRemoteDataSource.getDefaultProvider();
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
        final result = await insuranceRemoteDataSource.getStates();
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
  Future<Either<Failure, List<GenderNavigation>>> getGender() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await insuranceRemoteDataSource.getGender();
        return Right(result);
      } catch (e) {
        return Left(e);
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }
  // @override
  // Future<Either<Failure, List<RegistryStatusCodeNavigation>>> getRegistryStatus() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final result = await InsuranceRemoteDataSource.getRegistryStatus();
  //       return Right(result);
  //     } catch (e) {
  //       return Left(e);
  //     }
  //   } else {
  //     // TODO: implement local storage operations
  //   }
  //   return null;
  // }
  @override
  Future<Either<Failure, List<String>>> getRelationship() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await insuranceRemoteDataSource.getRelationship();
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
 Future<Either<Failure, List<PrefferedContactNavigation>>> getPrefferedContact() async {
   if (await networkInfo.isConnected) {
     try {
       final result =
           await insuranceRemoteDataSource.getPrefferedContact();
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
