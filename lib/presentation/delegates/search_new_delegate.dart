import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/presentation/widgets/widgets.dart';
import '/domain/domain.dart';

typedef SearchArticlesCallback = Future<List<Article>>Function({required String query, int page});

class SearchNewDelegate extends SearchDelegate<Article?> {

  final SearchArticlesCallback searchArticles;
    List<Article> initialArticles;
    StreamController<List<Article>> debouncedArticles = StreamController.broadcast();
    StreamController<bool> isLoadingStream = StreamController.broadcast();
    Timer? _debounceTimer;

  SearchNewDelegate({
    required this.searchArticles,
    required this.initialArticles
  }):super(
    searchFieldLabel: 'Search News'
  );

  bool _isClosed = false;

  void clearStreams() {
    _isClosed = true;
    debouncedArticles.close();
    isLoadingStream.close();
  }


  void _onQueryChanged(String query) {

  if (!_isClosed) isLoadingStream.add(true);

  if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

  _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
    final articles = await searchArticles(query: query);
    initialArticles = articles;
    
    if (!_isClosed) debouncedArticles.add(articles);
    if (!_isClosed) isLoadingStream.add(false);
  });
}


  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialArticles,
      stream: debouncedArticles.stream,
      builder: (context, snapshot) {

        final articles = snapshot.data ?? [];

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) => _NewItem(
            article: articles[index],
            onArticleSelected: (context, article) {
              close(context, article);
            }
          )
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if(snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 1),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(LucideIcons.refreshCcw)
              ),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(LucideIcons.x)
            ),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _NewItem extends StatelessWidget {
  final Article article;
  final Function onArticleSelected;

  const _NewItem({
    required this.article,
    required this.onArticleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onArticleSelected(context, article);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * .3,
              height: size.height * .11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: const Icon(
                        LucideIcons.imageOff,
                        size: 32,
                        color: Colors.grey,
                      ),
                    );
                  },
                )
              ),
            ),
            const SizedBox(width: 10),

            SizedBox(
              width: size.width * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: textStyles.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SourceInfo(article: article),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
