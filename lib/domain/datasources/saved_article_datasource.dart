import '/domain/domain.dart';


abstract class SavedArticleDatasource {
  Future<void> save(SavedArticle article);
  Future<void> deleteByUrl(String url);
  Future<List<SavedArticle>> getAll();
  Future<bool> exists(String url);
}
