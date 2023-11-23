import 'package:news_hub/controller/news_controller.dart';
import 'package:news_hub/models/category_news_model/category_news_model.dart';
import 'package:news_hub/models/news_channel_headline_model/news_channel_headlines_model.dart';

class NewsViewModel {
  final _news = NewsApi();

  Future<NewsChannelHeadlinesModel> fetchNewsHeadlines(name) async {
    final res = await _news.fetchNewsHeadlines(name);
    return res;
  }

  Future<CategoryNewsModel> fetchNewsByCategory(category) async {
    final res = await _news.fetchNewsByCategory(category);
    return res;
  }
}
