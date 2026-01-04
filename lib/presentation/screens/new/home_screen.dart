import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noticias/config/constants/news_category.dart';
import 'package:noticias/presentation/providers/news/article_provider.dart';

class HomeScreen extends ConsumerWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Puedes cambiar la categoría aquí
    final category = NewsCategory.entertainment;
    final articlesAsync = ref.watch(articleProvider(category));

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: articlesAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No hay noticias disponibles.'));
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Image.network(article.urlToImage, width: 80, fit: BoxFit.cover),
                  title: Text(article.title),
                  subtitle: Text(
                    article.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    // Aquí podrías navegar al detalle
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
