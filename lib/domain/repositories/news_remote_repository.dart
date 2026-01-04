import '/config/config.dart';
import '/domain/domain.dart';

abstract class NewsRemoteRepository {
  Future<List<Article>> getArticlesByCategory(NewsCategory category);
}