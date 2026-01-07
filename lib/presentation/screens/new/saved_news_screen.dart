import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';
import '/infrastructure/infrastructure.dart';


class SavedNewsScreen extends StatelessWidget {
  static const name = "saved-news-screen";

  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Saved News", style: styleTitle),
      ),
      body: const _SavedNewsWidget(),
    );
  }
}

class _SavedNewsWidget extends ConsumerWidget {
  const _SavedNewsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedArticlesAsync = ref.watch(savedArticlesProvider);

    return savedArticlesAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Center(
        child: Text(
          'Error loading saved news',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      data: (savedArticles) {
        if (savedArticles.isEmpty) {
          return const Center(
            child: Text("No saved news yet"),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView.separated(
            itemCount: savedArticles.length,
            itemBuilder: (_, index) {
              final article = SavedArticleMapper.toArticle(
                savedArticles[index]
              );
              return SecondaryArticleWidget(
                article: article
              );
            },
            separatorBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: const Divider(
                    height: 1,
                    thickness: 0.8,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
