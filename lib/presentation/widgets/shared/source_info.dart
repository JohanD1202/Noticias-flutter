import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/domain/domain.dart';


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
        Expanded(
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