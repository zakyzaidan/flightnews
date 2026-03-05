import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flightnews/feature/articles/domain/repositories/articles_repository.dart';
import 'package:flightnews/feature/articles/domain/usecases/get_articles_usecase.dart';
import 'package:flightnews/feature/articles/presentation/provider/articles_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'feature/articles/data/datasources/articles_remote_datasource.dart';
import 'feature/articles/data/repositories/articles_repository_impl.dart';

/// Service Locator menggunakan GetIt
/// Ini mengelola dependency injection untuk seluruh aplikasi
final getIt = GetIt.instance;

/// Setup service locator
void setupServiceLocator() {
  // ========== Core ==========
  // Network
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt<Connectivity>()));

  // HTTP Client
  getIt.registerSingleton<http.Client>(http.Client());

  // ========== Articles Feature ==========
  // Data Source
  getIt.registerSingleton<ArticlesRemoteDataSource>(
    ArticlesRemoteDataSourceImpl(getIt<http.Client>()),
  );

  // Repository
  getIt.registerSingleton<ArticlesRepository>(
    ArticlesRepositoryImpl(
      remoteDataSource: getIt<ArticlesRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Use Cases
  getIt.registerSingleton<GetArticlesUseCase>(
    GetArticlesUseCase(getIt<ArticlesRepository>()),
  );

  // Providers
  getIt.registerSingleton<ArticlesProvider>(
    ArticlesProvider(getArticlesUseCase: getIt<GetArticlesUseCase>()),
  );
}
