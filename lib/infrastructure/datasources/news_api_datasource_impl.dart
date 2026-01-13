import 'package:dio/dio.dart';
import '/infrastructure/infrastructure.dart';
import '/domain/domain.dart';
import '/config/config.dart';


class NewsApiDatasourceImpl extends NewsRemoteDatasource {

  final Dio dio;
  final String apiKey;

  NewsApiDatasourceImpl(this.dio, {required this.apiKey});

  @override
  Future<List<Article>> getArticlesByCategory(NewsCategory category) async {

    if(Environment.newsApiKey.isEmpty) {
        return [];
    }

    final response = await dio.get('/top-headlines',
      queryParameters: {
        'category': category.name,
        'country': 'us',
        'apiKey': apiKey
      }
    );
    final List articlesJson = response.data['articles'];

    return articlesJson
    .map((json) => ArticleMapper.newsApiToEntity(ArticleModel.fromJson(json)))
    .toList();
  }
  
  @override
  Future<List<Article>> searchNews({required String query, int page = 1}) async {
    if(query.isEmpty) return [];
    
    final response = await dio.get('/everything',
      queryParameters: {
        'q': query,
        'language': 'en',
        'sortBy': 'publishedAt',
        'page': page,
        'pageSize': 20
      }
    );
    final List articles = response.data['articles'];

    return articles
      .map((json) => ArticleModel.fromJson(json))
      .map(ArticleMapper.newsApiToEntity)
      .toList();
  }
}