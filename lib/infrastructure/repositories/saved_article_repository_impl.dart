import '/domain/domain.dart';

class SavedArticleRepositoryImpl implements SavedArticleRepository {
  final SavedArticleDatasource datasource;

  SavedArticleRepositoryImpl(this.datasource);

  @override
  Future<void> save(SavedArticle article) {
    return datasource.save(article);
  }

  @override
  Future<void> deleteByUrl(String url) {
    return datasource.deleteByUrl(url);
  }

  @override
  Future<List<SavedArticle>> getAll() {
    return datasource.getAll();
  }

  @override
  Future<bool> exists(String url) {
    return datasource.exists(url);
  }
  
  @override
  Stream<List<SavedArticle>> watchAll() {
    return datasource.watchAll();
  }
}
