import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/articles_entity.dart';

/// Abstract repository untuk articles
/// Interface ini mendefinisikan kontrak untuk mengambil data articles
abstract class ArticlesRepository {
  /// Mendapatkan daftar articles dari remote data source
  /// Returns: Either<Failure, ArticlesEntity> - Failure jika ada error, ArticlesEntity jika berhasil
  Future<Either<Failure, ArticlesEntity>> getArticles({String? nextUrl});
}
