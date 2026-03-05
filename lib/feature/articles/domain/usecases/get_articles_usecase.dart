import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/articles_entity.dart';
import '../repositories/articles_repository.dart';

/// Params untuk GetArticlesUseCase dengan pagination support
class GetArticlesParams extends Equatable {
  /// URL untuk next page (null untuk first page)
  final String? nextUrl;

  const GetArticlesParams({this.nextUrl});

  @override
  List<Object?> get props => [nextUrl];
}

/// Use case untuk mendapatkan articles dengan pagination support
class GetArticlesUseCase extends UseCase<ArticlesEntity, GetArticlesParams> {
  final ArticlesRepository repository;

  GetArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, ArticlesEntity>> call(GetArticlesParams params) async {
    // Jika ada nextUrl, gunakan itu untuk pagination
    // Jika tidak, gunakan default URL
    return await repository.getArticles(nextUrl: params.nextUrl);
  }
}
