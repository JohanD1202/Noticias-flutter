import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noticias/config/config.dart';
import 'package:noticias/domain/domain.dart';
import 'package:noticias/presentation/screens/screens.dart';
import 'package:noticias/presentation/providers/providers.dart';


class FakeSelectedCategoryNotifier extends SelectedCategoryNotifier {
  @override
  NewsCategory build() => NewsCategory.general;
}

class FakeArticlesNotifier extends Notifier<AsyncValue<List<Article>>> {
  @override
  AsyncValue<List<Article>> build() {
    return AsyncValue.data([
      Article(
        id: '1',
        title: 'Test News',
        author: '',
        description: 'Description',
        content: '',
        url: '',
        urlToImage: '',
        publishedAt: DateTime.now(),
        source: const Source(id: '', name: 'Test Source'),
      ),
    ]);
  }
}

void main() {
  testWidgets(
    'HomeScreen muestra lista de artículos cuando hay data',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            selectedCategoryProvider.overrideWith(
              FakeSelectedCategoryNotifier.new,
            ),
            articleProvider.overrideWith(
              (ref, category) async {
                return [
                  Article(
                    id: '1',
                    title: 'Test News',
                    author: '',
                    description: 'Description',
                    content: '',
                    url: '',
                    urlToImage: '',
                    publishedAt: DateTime.now(),
                    source: const Source(id: '', name: 'Test Source'),
                  ),
                ];
              },
            ),
          ],
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        )
      );

      await tester.pumpAndSettle();

      expect(find.text('Test News'), findsOneWidget);
    },
  );
}
