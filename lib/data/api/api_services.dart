import 'dart:convert';

import 'package:flightnews/data/models/articles_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String accept = 'application/json';
  String baseUrl = 'https://api.spaceflightnewsapi.net/v4';

  Future<Articles> getArticles(int index) async {
    final response = await http.get(Uri.parse('$baseUrl/articles'));
    if (response.statusCode == 200) {
      return Articles.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
