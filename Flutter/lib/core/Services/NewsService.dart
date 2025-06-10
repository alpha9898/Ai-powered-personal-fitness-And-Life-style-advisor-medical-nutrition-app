import 'package:dio/dio.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';

class NewsService {
  Dio dio;
  NewsService(this.dio);

  Future<List<ArticalsModel>> getNews(String q) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=$q&apiKey=8d90f60fcf0e40a9ba95791281c302e3',
      );

      var jsonData = response.data;
      List<dynamic> articalList = jsonData['articles'];
      List<ArticalsModel> news = [];
      for (var artical in articalList) {
        ArticalsModel articals = ArticalsModel(
          image: artical['urlToImage'],
          title: artical['title'],
          subtitle: artical['description'],
          content: artical['content'],
          url: artical['url'],
          publishedAt: artical['publishedAt'],
          author: artical['author'] ?? 'Anonymous',
        );
        news.add(articals);
      }
      return news;
    } catch (e) {
      return [];
    }
  }
}
