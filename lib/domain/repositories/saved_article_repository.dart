import '/domain/domain.dart';


abstract class SavedArticleRepository {
  Future<void> save(SavedArticle article);
  Future<void> deleteByUrl(String url);
  Future<List<SavedArticle>> getAll();
  Future<bool> exists(String url);
  Stream<List<SavedArticle>> watchAll();
}
