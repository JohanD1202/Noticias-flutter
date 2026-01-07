import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/infrastructure/infrastructure.dart';
import '/domain/domain.dart';


final savedArticleDatasourceProvider =
    Provider<SavedArticleDatasource>((ref) {
  return SavedArticleDatasourceImpl();
});

final savedArticleRepositoryProvider =
    Provider<SavedArticleRepository>((ref) {
  final datasource = ref.watch(savedArticleDatasourceProvider);
  return SavedArticleRepositoryImpl(datasource);
});

final savedArticlesProvider =
    StreamProvider<List<SavedArticle>>((ref) {
  final repository = ref.watch(savedArticleRepositoryProvider);
  return repository.watchAll();
});


