import '/config/config.dart';
import '/domain/domain.dart';

abstract class NewsRemoteDatasource {
  Future<List<Article>> getArticlesByCategory(NewsCategory category);
}