import 'package:flutter/material.dart';
import '/presentation/widgets/widgets.dart';
import '/domain/domain.dart';


class SecondaryArticleWidget extends StatelessWidget {

  final Article article;
  final VoidCallback? onTap;

  const SecondaryArticleWidget({
    super.key,
    required this.article,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 22, top: 16, bottom: 6),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _InfoNew(article)
                ),
                const SizedBox(width: 10),
                if(article.urlToImage.isNotEmpty)
                Hero(
                  tag: article.url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            ArticleCardOptions(article: article)
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