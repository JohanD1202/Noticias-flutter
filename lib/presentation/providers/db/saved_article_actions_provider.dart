import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';


final savedArticleActionsProvider = Provider((ref) {
  final repo = ref.watch(savedArticleRepositoryProvider);
  return SavedArticleActions(repo);
});


