import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import '/presentation/providers/providers.dart';
import '/domain/domain.dart';
import '/config/config.dart';


class ArticleCardOptions extends ConsumerWidget {
  final Article article;
  final bool isSaved;

  const ArticleCardOptions({
    super.key,
    required this.article,
    required this.isSaved,
  });

  Future<void> _toggleSave({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final actions = ref.read(savedArticleActionsProvider);
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);

    await actions.toggleSave(article);

    final message = isSaved ? 'Removed from saved' : 'Saved for later';

    messenger
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final styleIcon = theme.iconTheme.color;
    final styleText = theme.textTheme.bodySmall;

    return Row(
      children: [
        Text(
          article.publishedAt.timeAgo(),
          style: styleText,
        ),
        const Spacer(),
        PopupMenuButton<_ArticleOption>(
          icon: Icon(
            LucideIcons.moreVertical,
            color: styleIcon,
          ),
          onSelected: (option) {
            switch (option) {
              case _ArticleOption.save:
                _toggleSave(
                  context: context,
                  ref: ref,
                );
                break;

              case _ArticleOption.share:
                SharePlus.instance.share(
                  ShareParams(
                    text: '${article.title}\n\n${article.url}',
                    subject: article.title,
                  ),
                );
                break;
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: _ArticleOption.save,
              child: Row(
                children: [
                  Icon(
                    isSaved
                        ? Icons.bookmark
                        : Icons.bookmark_border_rounded,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isSaved
                        ? 'Remove from saved'
                        : 'Save for later',
                    style: styleText,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: _ArticleOption.share,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.share2,
                    color: styleIcon,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Share',
                    style: styleText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum _ArticleOption { save, share }
