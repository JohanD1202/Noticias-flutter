import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import '/domain/domain.dart';
import '/config/config.dart';

class ArticleCardOptions extends StatelessWidget {

  final Article article;

  const ArticleCardOptions({
    super.key,
    required this.article
  });

  @override
  Widget build(BuildContext context) {

    final styleIcon = Theme.of(context).iconTheme.color;
    final styleText = Theme.of(context).textTheme.bodySmall;

    return Row(
      children: [
        Text(
          article.publishedAt.timeAgo(),
          style: styleText,
        ),
        const Spacer(),
        PopupMenuButton<String>(
          icon: Icon(
            LucideIcons.moreVertical,
            color: styleIcon,
          ),
          onSelected: (value) {
            if (value == 'save') {
              // guardar para más tarde
            } else if (value == 'share') {
              SharePlus.instance.share(
                ShareParams(
                  text: '${article.title}\n\n${article.url}',
                  subject: article.title
                )
              );
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'save',
              child: Row(
                children: [
                  Icon(LucideIcons.bookmark, color: styleIcon),
                  const SizedBox(width: 8),
                  Text('Save for later', style: styleText),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(LucideIcons.share2, color: styleIcon),
                  const SizedBox(width: 8),
                  Text("Share", style: styleText)
                ],
              )
            ),
          ],
        ),
      ],
    );
  }
}
