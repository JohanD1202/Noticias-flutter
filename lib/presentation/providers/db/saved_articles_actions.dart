import '/domain/domain.dart';
import '/infrastructure/infrastructure.dart';


class SavedArticleActions {
  final SavedArticleRepository repository;

  SavedArticleActions(this.repository);

  Future<void> toggleSave(Article article) async {
    final exists = await repository.exists(article.url);

    if (exists) {
      await repository.deleteByUrl(article.url);
    } else {
      await repository.save(
        SavedArticleMapper.fromArticle(article),
      );
    }
  }
}
