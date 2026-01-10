import '/config/config.dart';
import '/domain/domain.dart';

abstract class NewsRemoteRepository {
  Future<List<Article>> getArticlesByCategory(NewsCategory category);

  Future<List<Article>> searchNews({required String query, int page = 1});
}