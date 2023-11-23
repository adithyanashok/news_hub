import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_hub/models/category_news_model/category_news_model.dart';
import 'package:news_hub/models/news_channel_headline_model/news_channel_headlines_model.dart';

class NewsApi {
  Future<NewsChannelHeadlinesModel> fetchNewsHeadlines(name) async {
    // url of  news headlines
    final url =
        'https://newsapi.org/v2/top-headlines?sources=$name&apiKey=ab1ab6af928d41588fac34e546aa87ae';

    // Fetch the news
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the status code is 200(ok) decode the response and get the json
      final json = jsonDecode(response.body);

      // Return Model
      return NewsChannelHeadlinesModel.fromJson(json);
    } else {
      throw Exception("Error while fetching headlines");
    }
  }

  Future<CategoryNewsModel> fetchNewsByCategory(category) async {
    final url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=ab1ab6af928d41588fac34e546aa87ae';

    // Fetch the news
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the status code is 200(ok) decode the response and get the json
      final json = jsonDecode(response.body);

      // Return Model
      return CategoryNewsModel.fromJson(json);
    } else {
      throw Exception("Error while fetching headlines");
    }
  }
}
