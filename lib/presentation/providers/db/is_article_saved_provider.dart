import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';


final isArticleSavedProvider =
    Provider.family<bool, Article>((ref, article) {

  final saved = ref.watch(savedArticlesProvider);

  return saved.maybeWhen(
    data: (articles) =>
        articles.any((a) => a.url == article.url),
    orElse: () => false,
  );
});
