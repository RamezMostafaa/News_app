import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constatnts.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/sourceResponse.dart';

class ApiManager {
  static Future<SourceResponse?> getResponse(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.topHeadLinesSource, {
      "apiKey": ApiConstants.apiKey,
      "category": categoryId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse>? getNewsBySourceId({
    required String sourceId,
    required String page,
  }) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.newsSource, {
      "page": page,
      "pageSize": "5",
      "apiKey": ApiConstants.apiKey,
      "sources": sourceId,
    });

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsBySearch({
    required String searchArticle,
  }) async {
    Uri url = Uri.https(ApiConstants.baseurl, ApiConstants.newsSource, {
      "apiKey": ApiConstants.apiKey,
      "q": searchArticle,
    });

    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
