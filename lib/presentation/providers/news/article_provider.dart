import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';

final articleProvider = FutureProvider.family<List<Article>, NewsCategory>((ref, category) async {
  final repo = ref.watch(articleRepositoryProvider);
  return repo.getArticlesByCategory(category);
});
