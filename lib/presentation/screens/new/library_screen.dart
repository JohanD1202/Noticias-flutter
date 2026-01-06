import 'package:flutter/material.dart';
import 'package:noticias/domain/domain.dart';
import '/presentation/widgets/widgets.dart';


class LibraryScreen extends StatelessWidget {
  static const name = "library-screen";

  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 20
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Library", style: styleTitle),
      ),
      body: const _LibraryView(),
    );
  }
}

class _LibraryView extends StatelessWidget {
  const _LibraryView();

  @override
  Widget build(BuildContext context) {

    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text("Saved News", style: styleTitle),
            ),
            const SizedBox(height: 10),
            ArticleWidget(article: Article(id: '', title: 'Hola mundo', author: 'author', description: 'new description', content: '', url: '123', urlToImage: '', publishedAt: DateTime(2026, 1, 5, 10, 30), source: Source(id: '', name: 'BBC'))),
            ArticleWidget(article: Article(id: '', title: 'Hola mundo', author: 'author', description: 'new description', content: '', url: '321', urlToImage: '', publishedAt: DateTime(2026, 1, 5, 10, 30), source: Source(id: '', name: 'BBC'))),
            const _ManageSavedNews()
          ],
        ),
      ),
    );
  }
}

class _ManageSavedNews extends StatelessWidget {
  const _ManageSavedNews();

  @override
  Widget build(BuildContext context) {

    final styleText = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text("View all and manage", style: styleText)
      )
    );
  }
}