import 'package:flutter/material.dart';
import '../../domain/entities/articles_entity.dart';
import '../../domain/usecases/get_articles_usecase.dart';

/// Provider untuk manage state articles dengan pagination support
class ArticlesProvider extends ChangeNotifier {
  final GetArticlesUseCase getArticlesUseCase;

  // State variables
  ArticlesEntity? _articles;
  bool _isLoading = false;
  bool _isLoadingMore = false; // ← Untuk loading state saat pagination
  String? _errorMessage;
  String? _nextUrl; // ← Store next URL untuk pagination

  // Getters
  ArticlesEntity? get articles => _articles;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  String? get nextUrl => _nextUrl;
  bool get hasNextPage =>
      _nextUrl != null; // ← Check apakah ada page berikutnya

  /// Constructor dengan dependency injection
  ArticlesProvider({required this.getArticlesUseCase}) {
    getArticles();
  }

  /// Method untuk fetch articles pertama kali
  Future<void> getArticles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getArticlesUseCase(GetArticlesParams(nextUrl: null));

    result.fold(
      /// Left = Failure
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },

      /// Right = Success
      (articlesEntity) {
        _articles = articlesEntity;
        _nextUrl = articlesEntity.next; // ← Store next URL untuk pagination
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Method untuk fetch next page articles (pagination)
  Future<void> getMoreArticles(String nextUrl) async {
    // Jangan load lebih jika tidak ada next URL atau sedang loading
    if (!hasNextPage || _isLoadingMore) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    final result = await getArticlesUseCase(
      GetArticlesParams(nextUrl: nextUrl),
    );

    result.fold(
      /// Left = Failure
      (failure) {
        _errorMessage = failure.message;
        _isLoadingMore = false;
        notifyListeners();
      },

      /// Right = Success - append new articles to existing list
      (newArticlesEntity) {
        if (_articles != null) {
          // Combine articles dari page sebelumnya dengan page baru
          final combinedResults = [
            ..._articles!.results,
            ...newArticlesEntity.results,
          ];

          // Update articles dengan combined results
          _articles = ArticlesEntity(
            count: newArticlesEntity.count,
            next: newArticlesEntity.next,
            previous: _articles?.previous,
            results: combinedResults,
          );

          // Update next URL untuk pagination berikutnya
          _nextUrl = newArticlesEntity.next;
        }

        _isLoadingMore = false;
        notifyListeners();
      },
    );
  }

  /// Method untuk retry fetch articles
  Future<void> retryGetArticles() async {
    // Reset ke first page
    _nextUrl = null;
    await getArticles();
  }

  /// Method untuk reset pagination
  void resetPagination() {
    _nextUrl = null;
    _articles = null;
    _errorMessage = null;
  }
}
