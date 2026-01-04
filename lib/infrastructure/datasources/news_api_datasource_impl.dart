import 'package:dio/dio.dart';
import '/infrastructure/infrastructure.dart';
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
  Future<List<Article>> getArticlesByCategory(NewsCategory category) async {
    final response = await dio.get('/top-headlines',
      queryParameters: {
        'category': category.name,
        'country': 'us',
        'apiKey': Environment.newsApiKey
      }
    );
    final List articlesJson = response.data['articles'];

    return articlesJson
    .map((json) => ArticleMapper.newsApiToEntity(ArticleModel.fromJson(json)))
    .toList();
  }
}