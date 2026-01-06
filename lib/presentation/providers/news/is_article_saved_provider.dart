import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';

final isArticleSavedProvider = Provider.family<bool, Article>(
  (ref, article) {
    return ref.watch(savedArticlesProvider)
        .any((a) => a.url == article.url);
  },
);
