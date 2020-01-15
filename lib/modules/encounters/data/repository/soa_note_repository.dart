import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/soa_note_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/soa_note_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/soa/soa_note.dart';

abstract class SoaNoteRepository {
  Future<Either<Failure, SoaNote>> getSoaNote(int id);
  Future<int> addSoaNote(SoaNote data);
  Future<Either<Failure, List<Encounters>>> getEncounters(int id);
}

class SoaNoteRepositoryImpl implements SoaNoteRepository {
  final SoaNoteRemoteDataSource soaNoteRemoteDataSource;
  final SoaNoteLocalDataSource soaNoteLocalDataSource;
  final NetworkInfo networkInfo;

  SoaNoteRepositoryImpl({
    @required this.soaNoteRemoteDataSource,
    @required this.soaNoteLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addSoaNote(SoaNote data) async {
    if (await networkInfo.isConnected) {
      try {
        if (data.id != null) {
          return await soaNoteRemoteDataSource.updateSoaNote(data);
        } else {
          return await soaNoteRemoteDataSource.addSoaNote(data);
        }
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, SoaNote>> getSoaNote(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soaNoteRemoteDataSource.getSoaNote(id);
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
  Future<Either<Failure, List<Encounters>>> getEncounters(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await soaNoteRemoteDataSource.getEncounters(id);
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
