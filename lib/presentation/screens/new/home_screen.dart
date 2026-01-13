import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:noticias/presentation/delegates/search_new_delegate.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';
import '/presentation/widgets/widgets.dart';


class HomeScreen extends ConsumerStatefulWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  bool _dialogShown = false;

  void _showNoInternetDialog() {
    if (_dialogShown || !mounted) return;
    _dialogShown = true;

    final textTheme = Theme.of(context);
    final backgroundTheme = Theme.of(context).scaffoldBackgroundColor;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: backgroundTheme,
          title: const Text("Without Internet Connection"),
          titleTextStyle: textTheme.textTheme.bodyLarge,
          content: const Text("You need an internet connection to use our app."),
          contentTextStyle: textTheme.textTheme.bodyMedium,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _dialogShown = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _retryConnectivity();
                });
              },
              child: Text("Retry", style: textTheme.textTheme.bodyMedium)
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                _dialogShown = false;
                SystemNavigator.pop();
              },
              child: const Text("Go out", style: TextStyle(color: Colors.red))
            ),
          ],
        );
      },
    );
  }

  void _retryConnectivity() {
    final connectivity = ref.read(connectivityStatusProvider).value;
    if(connectivity != ConnectivityResult.none) {
      ref.invalidate(articleProvider(ref.read(selectedCategoryProvider)));
    } else {
      _showNoInternetDialog();
    }
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<AsyncValue<ConnectivityResult>>(
      connectivityStatusProvider,
      (previous, next) {
        next.whenData((status) {
          if (status == ConnectivityResult.none) {
            _showNoInternetDialog();
          }
        });
      },
    );
    
    final connectivity = ref.watch(connectivityStatusProvider).maybeWhen(
      data: (status) => status,
      orElse: () => ConnectivityResult.wifi,
    );
    final isOffline = connectivity == ConnectivityResult.none;

    final category = ref.watch(selectedCategoryProvider);
    final articlesAsync = isOffline
      ? const AsyncValue<List<Article>>.data([])
      : ref.watch(articleProvider(category));

    if(isOffline) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNoInternetDialog();
      });
    }
    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20
    );
    final styleIcon = Theme.of(context).iconTheme.color;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Recent News"),
        titleTextStyle: styleTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {

                final searchedArticles = ref.read(searchedArticlesProvider);
                final searchQuery = ref.read(searchQueryProvider);

                showSearch<Article?>(
                  query: searchQuery,
                  context: context,
                  delegate: SearchNewDelegate(
                    initialArticles: searchedArticles,
                    searchArticles: ref.read(searchedArticlesProvider.notifier).searchArticlesByQuery
                  )
                ).then((article) {
                  if(!context.mounted || article == null) return;

                  context.push('/detail', extra: article);
                });
              },
              child: Icon(
                LucideIcons.search,
                color: styleIcon,
                size: 25,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const CategorySelector(),
          const SizedBox(height: 8),
          Expanded(
            child: articlesAsync.when(
              data: (articles) {
                if(articles.isEmpty) {
                  return const Center(
                    child: Text('No news available.'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(articleProvider(category));
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      final pattern = index % 3;
                  
                      final widget = pattern == 0
                        ? ArticleWidget(
                            article: article,
                            onTap: () {
                              context.push('/detail', extra: article);
                            },
                          )
                        : SecondaryArticleWidget(
                            article: article,
                            onTap: () {
                              context.push('/detail', extra: article);
                            },
                          );
                      return Column(
                        children: [
                          widget,
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .9,
                              child: const Divider(
                                height: 1,
                                thickness: 0.8,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
              loading: () =>
                  const Center(child: SkeletonNews()),
              error: (error, _) =>
                  Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}