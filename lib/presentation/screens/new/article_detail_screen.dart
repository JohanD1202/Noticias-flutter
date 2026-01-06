import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/domain/domain.dart';
import '/presentation/providers/providers.dart';

class ArticleDetailScreen extends ConsumerStatefulWidget {
  static const name = 'detail-screen';

  final Article article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  ConsumerState<ArticleDetailScreen> createState() =>
      _ArticleDetailScreenState();
}

class _ArticleDetailScreenState
    extends ConsumerState<ArticleDetailScreen> {

  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.article.url));
  }

  void _toggleSave(BuildContext context, bool isSaved) {
    final actions = ref.read(savedArticleActionsProvider);
    final theme = Theme.of(context);

    actions.toggleSave(widget.article);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSaved ? 'Removed from saved' : 'Saved to later',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
    );
  }

  void _shareArticle() {
    SharePlus.instance.share(
      ShareParams(
        text: '${widget.article.title}\n\n${widget.article.url}',
        subject: widget.article.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final isSaved = ref.watch(
      isArticleSavedProvider(widget.article),
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: Icon(
              isSaved
                  ? Icons.bookmark
                  : Icons.bookmark_border_rounded,
              color: Colors.amber,
            ),
            onPressed: () => _toggleSave(context, isSaved),
          ),
          IconButton(
            icon: const Icon(LucideIcons.share2),
            onPressed: _shareArticle,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
