import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:noticias/presentation/widgets/widgets.dart';
import '/domain/domain.dart';


class ArticleWidget extends StatelessWidget {

  final Article article;
  final VoidCallback? onTap;

  const ArticleWidget({
    super.key,
    required this.article,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

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
                              return _ImageFallbackArticle();
                            },
                          )
                        : _ImageFallbackArticle()  
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 5,
                    ),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SourceInfo(article: article),
                      const SizedBox(height: 5),
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ArticleCardOptions(article: article),
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
