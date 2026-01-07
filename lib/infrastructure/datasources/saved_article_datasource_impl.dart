import 'package:isar/isar.dart';
import '/config/config.dart';
import '/domain/domain.dart';

class SavedArticleDatasourceImpl implements SavedArticleDatasource {
  @override
  Future<void> save(SavedArticle article) async {
    final isar = await IsarService.getInstance();
    await isar.writeTxn(() async {
      await isar.savedArticles.put(article);
    });
  }

  @override
  Future<void> deleteByUrl(String url) async {
    final isar = await IsarService.getInstance();
    final article = await isar.savedArticles
        .filter()
        .urlEqualTo(url)
        .findFirst();

    if (article != null) {
      await isar.writeTxn(() async {
        await isar.savedArticles.delete(article.id);
      });
    }
  }

  @override
  Future<List<SavedArticle>> getAll() async {
    final isar = await IsarService.getInstance();
    return isar.savedArticles.where().findAll();
  }

  @override
  Future<bool> exists(String url) async {
    final isar = await IsarService.getInstance();
    return await isar.savedArticles
            .filter()
            .urlEqualTo(url)
            .findFirst() !=
        null;
  }
}
