import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:noticias/presentation/widgets/widgets.dart';
import '/domain/domain.dart';


class ArticleCard extends StatelessWidget {

  final Article article;

  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(article.urlToImage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      article.urlToImage,
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover,
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
                    Row(
                      children: [
                        SourceInfo(article: article),
                      ],
                    ),
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
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: const Divider(
              height: 1,
              thickness: 0.8
            ),
          ),
        ),
      ],
    );
  }
}

class SourceInfo extends StatelessWidget {

  final Article article;

  const SourceInfo({
    super.key,
    required this.article
  });

  @override
  Widget build(BuildContext context) {

    final styleIcon = Theme.of(context).iconTheme.color;

    return Row(
      children: [
        Icon(LucideIcons.globe, color: styleIcon),
        const SizedBox(width: 5),
        SizedBox(
          width: 220,
          child: Text(
            article.source.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

