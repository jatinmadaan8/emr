import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:practiceinsights_emr_provider/core/error/failure.dart';
import 'package:practiceinsights_emr_provider/core/network/network_info.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/standards_scales_local_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/data_source/standards_scales_remote_data_source.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/encounters.dart';
import 'package:practiceinsights_emr_provider/modules/encounters/data/models/standards_scales/standards_scales.dart';

abstract class StandardsAndScalesRepository {
  Future<Either<Failure, List<StandardsAndScales>>> getStandardsAndScales();
  Future<int> addStandardsAndScales(AddStandardsAndScale data);
  Future<Either<Failure, List<StandardsAndScalesForm>>>
      getStandardsAndScalesForm(int id);
}

class StandardsAndScalesRepositoryImpl implements StandardsAndScalesRepository {
  final StandardsAndScalesRemoteDataSource standardsAndScalesRemoteDataSource;
  final StandardsAndScalesLocalDataSource standardsAndScalesLocalDataSource;
  final NetworkInfo networkInfo;

  StandardsAndScalesRepositoryImpl({
    @required this.standardsAndScalesRemoteDataSource,
    @required this.standardsAndScalesLocalDataSource,
    @required this.networkInfo,
  });

  @override
  Future<int> addStandardsAndScales(AddStandardsAndScale data) async {
    if (await networkInfo.isConnected) {
      try {
        return await standardsAndScalesRemoteDataSource
            .addStandardsAndScales(data);
      } catch (e) {
        return e;
      }
    } else {
      // TODO: implement local storage operations
    }
    return null;
  }

  @override
  Future<Either<Failure, List<StandardsAndScales>>>
      getStandardsAndScales() async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await standardsAndScalesRemoteDataSource.getStandardsAndScales();
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
  Future<Either<Failure, List<StandardsAndScalesForm>>>
      getStandardsAndScalesForm(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await standardsAndScalesRemoteDataSource
            .getStandardsAndScalesForm(id);
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
