import 'package:flutter_project/news_article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _endpoint =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=ade0fbe48e3645eca011736afde1cfd1';
  Future<NewsArticle> getNewsData() async {
    try {
      final response = await http.get(Uri.parse(_endpoint));
      if (response.statusCode == 200) {
        return newsdata(response.body.toString());
      } else {
        throw Exception('Failed to load news articles');
      }
    } catch (e) {
      throw Exception('Failed to load news articles: $e');
    }
  }
}
