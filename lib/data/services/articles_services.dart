import 'package:flightnews/data/api/api_services.dart';
import 'package:flightnews/data/models/articles_model.dart';

class ArticlesServices {
  ApiServices apiServices = ApiServices();

  Future<Articles> getArticles() async {
    Articles articles = await apiServices.getArticles(10);

    return articles;
  }
}
