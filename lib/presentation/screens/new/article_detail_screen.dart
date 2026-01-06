import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/domain/domain.dart';
import '/presentation/widgets/widgets.dart';


class ArticleDetailScreen extends StatelessWidget {
  static const name = 'detail-screen';

  final Article article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bookmark),
            onPressed: () {
              // guardar
            },
          ),
          IconButton(
            icon: const Icon(LucideIcons.share2),
            onPressed: () {
              // compartir texto
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(article.urlToImage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Hero(
                  tag: article.url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SourceInfo(article: article),
                  const SizedBox(height: 8),

                  Text(
                    article.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    article.description,
                    style: textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        // abrir url externa
                      },
                      icon: const Icon(LucideIcons.externalLink),
                      label: const Text('Leer en el sitio original'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
