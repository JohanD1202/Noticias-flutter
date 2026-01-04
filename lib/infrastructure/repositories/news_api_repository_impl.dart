import 'package:noticias/config/constants/news_category.dart';

import '/domain/domain.dart';

class NewsApiRepositoryImpl extends NewsRemoteRepository {
  final NewsRemoteDatasource datasource;

  NewsApiRepositoryImpl(this.datasource);

  @override
  Future<List<Article>> getArticlesByCategory(NewsCategory category) {
    return datasource.getArticlesByCategory(category);
  }
}