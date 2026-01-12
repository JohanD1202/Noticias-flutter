import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';


class SecondaryArticleWidget extends ConsumerWidget {
  final Article article;
  final VoidCallback? onTap;

  const SecondaryArticleWidget({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(
      isArticleSavedProvider(article),
    );

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 22,
          right: 22,
          top: 16,
          bottom: 6,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InfoNew(article),
                ),
                const SizedBox(width: 10),
                Hero(
                  tag: article.url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: article.urlToImage.isNotEmpty
                        ? Image.network(
                            article.urlToImage,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            // Muestra CircularProgressIndicator mientras carga
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (_, _, _) => const _ImageFallbackSecondaryArticle(),
                          )
                        : const _ImageFallbackSecondaryArticle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ArticleCardOptions(
              article: article,
              isSaved: isSaved,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoNew extends StatelessWidget {
  final Article article;

  const _InfoNew(this.article);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SourceInfo(article: article),
        const SizedBox(height: 6),
        Text(
          article.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}

class _ImageFallbackSecondaryArticle extends StatelessWidget {
  const _ImageFallbackSecondaryArticle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(
        LucideIcons.imageOff,
        size: 32,
      ),
    );
  }
}
