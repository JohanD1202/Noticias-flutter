import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/presentation/widgets/widgets.dart';
import '/presentation/providers/providers.dart';


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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Library", style: styleTitle),
      ),
      body: const _SavedNewsWidget(),
    );
  }
}

class _SavedNewsWidget extends ConsumerWidget {
  const _SavedNewsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final styleTitle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 18
    );
    final savedArticles = ref.watch(savedArticlesProvider);

    if(savedArticles.isEmpty) {
      return const Center(
        child: Text("No saved news yet"),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text("Saved News", style: styleTitle),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: savedArticles.length,
              itemBuilder: (_, index) {
                return ArticleWidget(article: savedArticles[index]);
              },
              separatorBuilder: (context, index) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: const Divider(
                      height: 1,
                      thickness: 0.8,
                    ),
                  ),
                );
              },
            ),
          ),
          const _ManageSavedNews()
        ],
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