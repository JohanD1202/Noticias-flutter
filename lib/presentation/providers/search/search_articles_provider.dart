import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedArticlesProvider = StateNotifierProvider<SearchedArticlesNotifier, List<Article>>((ref) {

  final articleRepository = ref.read(articleRepositoryProvider);

  return SearchedArticlesNotifier(
    searchArticles: articleRepository.searchNews,
    ref: ref
  );
});


typedef SearchArticlesCallback = Future<List<Article>> Function({required String query, int page});

class SearchedArticlesNotifier extends StateNotifier<List<Article>> {

  SearchArticlesCallback searchArticles;
  final Ref ref;

  SearchedArticlesNotifier({
    required this.searchArticles,
    required this.ref
  }): super([]);

  Future<List<Article>> searchArticlesByQuery({required String query, int page = 1}) async {

    final List<Article> articles = await searchArticles(query: query);
    ref.read(searchQueryProvider.notifier).state = query;

    state = articles;
    return articles;
  }
}