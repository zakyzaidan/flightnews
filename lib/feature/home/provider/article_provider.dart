import 'package:flightnews/data/models/articles_model.dart';
import 'package:flightnews/data/services/articles_services.dart';
import 'package:flutter/material.dart';

class ArticleProvider with ChangeNotifier {
  final ArticlesServices _service = ArticlesServices();

  Articles? _articles;
  bool _isLoading = false;
  String? _error;

  Articles? get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ArticleProvider() {
    getArticles();
  }

  Future<void> getArticles() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _articles = await _service.getArticles();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
