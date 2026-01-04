/*import 'package:dio/dio.dart';
import '/domain/domain.dart';
import '/config/config.dart';


class NewsApiDatasourceImpl extends NewsRemoteDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://newsapi.org/v2',
    queryParameters: {
      'apiKey': Environment.newsApiKey,

    },
  ));

  @override
  Future<List<Article>> getArticleByCategory(NewsCategory category) async {
    final response = await dio.get('/top-headlines',
      queryParameters: {
        'category': category.name,
        'country': 'us',
        'apiKey': Environment.newsApiKey
      }
    );
    final List articlesJson = response.data['articles'];

    return articlesJson
    .map((json) => ArticleM)
  }
}*/