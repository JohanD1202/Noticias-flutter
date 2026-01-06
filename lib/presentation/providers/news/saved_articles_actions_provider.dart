import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';

final savedArticleActionsProvider = Provider(
  (ref) => SavedArticleActions(ref),
);

class SavedArticleActions {
  final Ref ref;

  SavedArticleActions(this.ref);

  bool isSaved(Article article) {
    return ref.read(savedArticlesProvider)
        .any((a) => a.url == article.url);
  }

  void toggleSave(Article article) {
    final notifier = ref.read(savedArticlesProvider.notifier);

    if (isSaved(article)) {
      notifier.remove(article);
    } else {
      notifier.add(article);
    }
  }
}
