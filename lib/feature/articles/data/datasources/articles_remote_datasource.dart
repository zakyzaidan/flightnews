import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exceptions.dart';
import '../models/articles_model.dart';

/// Abstract class untuk remote data source
abstract class ArticlesRemoteDataSource {
  /// Mendapatkan articles dari API
  /// Throws [ServerException] jika terjadi error
  Future<ArticlesModel> getArticles({String? url});
}

/// Implementasi ArticlesRemoteDataSource
class ArticlesRemoteDataSourceImpl implements ArticlesRemoteDataSource {
  final http.Client httpClient;
  static const String baseUrl = 'https://api.spaceflightnewsapi.net/v4';
  static const String accept = 'application/json';

  ArticlesRemoteDataSourceImpl(this.httpClient);

  @override
  Future<ArticlesModel> getArticles({String? url}) async {
    try {
      final response = await httpClient.get(
        Uri.parse(url ?? '$baseUrl/articles?limit=5'),
        headers: {'Accept': accept},
      );

      if (response.statusCode == 200) {
        return ArticlesModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          message: 'Failed to load articles',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: 'An error occurred: ${e.toString()}');
    }
  }
}
