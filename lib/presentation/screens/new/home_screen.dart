import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/presentation/providers/providers.dart';
import '/presentation/widgets/widgets.dart';


class HomeScreen extends ConsumerWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    final articlesAsync = ref.watch(articleProvider(category));

    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20
    );
    final styleIcon = Theme.of(context).iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        titleTextStyle: styleTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                context.push('/settings');
              },
              child: Icon(
                LucideIcons.settings,
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
                if (articles.isEmpty) {
                  return const Center(
                    child: Text('No hay noticias disponibles.'),
                  );
                }

                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return ArticleCard(article: article);
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

