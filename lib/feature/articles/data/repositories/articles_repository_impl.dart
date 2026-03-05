import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/articles_entity.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasources/articles_remote_datasource.dart';

/// Implementasi dari ArticlesRepository
/// Layer ini menghubungkan domain layer dengan data layer
class ArticlesRepositoryImpl implements ArticlesRepository {
  final ArticlesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ArticlesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ArticlesEntity>> getArticles({String? nextUrl}) async {
    /// Check koneksi internet terlebih dahulu
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getArticles();
        return Right(remoteArticles);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
