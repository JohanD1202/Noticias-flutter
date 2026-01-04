import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/providers/providers.dart';
import '/presentation/widgets/widgets.dart';


class HomeScreen extends ConsumerWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    final articlesAsync = ref.watch(articleProvider(category));

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Column(
        children: [
          const CategorySelector(),
          const SizedBox(height: 8),
          Expanded(
            child: articlesAsync.when(
              data: (articles) {
                if (articles.isEmpty) {
                  return const Center(
                    child: Text('No hay noticias disponibles.'),
                  );
                }

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: article.urlToImage.isNotEmpty
                            ? Image.network(
                                article.urlToImage,
                                width: 80,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(width: 80),
                        title: Text(article.title),
                        subtitle: Text(
                          article.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

