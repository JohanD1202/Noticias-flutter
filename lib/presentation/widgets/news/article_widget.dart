import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';


class ArticleWidget extends ConsumerWidget {

  final Article article;
  final VoidCallback? onTap;

  const ArticleWidget({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final isSaved = ref.watch(isArticleSavedProvider(article),
);


    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Hero(
                    tag: article.url,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: article.urlToImage.isNotEmpty
                          ? Image.network(
                              article.urlToImage,
                              height: 180,
                              width: MediaQuery.of(context).size.width * 0.9,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) {
                                return const _ImageFallbackArticle();
                              },
                            )
                          : const _ImageFallbackArticle(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SourceInfo(article: article),
                      const SizedBox(height: 6),

                      Text(
                        article.title,
                        style: theme.textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 4),
                      ArticleCardOptions(
                        article: article,
                        isSaved: isSaved,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageFallbackArticle extends StatelessWidget {
  const _ImageFallbackArticle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.grey.shade300,
      alignment: Alignment.center,
      child: const Icon(
        LucideIcons.imageOff,
        size: 32,
      ),
    );
  }
}
