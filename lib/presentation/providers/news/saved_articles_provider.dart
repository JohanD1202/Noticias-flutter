import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';

final savedArticlesProvider =
    NotifierProvider<SavedArticlesNotifier, List<Article>>(
  SavedArticlesNotifier.new,
);

class SavedArticlesNotifier extends Notifier<List<Article>> {
  @override
  List<Article> build() {
    return [];
  }

  void add(Article article) {
    if(state.any((a) => a.url == article.url)) return;
    state = [...state, article];
  }

  void remove(Article article) {
    state = state.where((a) => a.url != article.url).toList();
  }

  bool isSaved(Article article) {
    return state.any((a) => a.url == article.url);
  }
}
