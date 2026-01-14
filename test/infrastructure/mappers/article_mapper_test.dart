import 'package:flutter_test/flutter_test.dart';
import 'package:noticias/infrastructure/infrastructure.dart';


void main() {
  group('ArticleMapper', () {
    test('debe mapear correctamente un ArticleModel completo', () {
      final model = ArticleModel(
        title: 'Test title',
        author: 'Johan',
        description: 'Test description',
        content: 'Test content',
        url: 'https://test.com',
        urlToImage: 'https://image.com',
        publishedAt: DateTime(2025, 1, 1),
        source: SourceModel(
          id: 'cnn',
          name: 'CNN',
        ),
      );

      final article = ArticleMapper.newsApiToEntity(model);

      expect(article.title, 'Test title');
      expect(article.author, 'Johan');
      expect(article.source.name, 'CNN');
      expect(article.id, 'cnn');
    });

    test('debe asignar valores por defecto cuando hay nulls', () {
      final model = ArticleModel(
        title: 'Test title',
        author: null,
        description: 'Test description',
        content: null,
        url: 'https://test.com',
        urlToImage: null,
        publishedAt: null,
        source: SourceModel(
          id: null,
          name: 'CNN',
        ),
      );

      final article = ArticleMapper.newsApiToEntity(model);

      expect(article.author, 'Unknown');
      expect(article.content, '');
      expect(article.urlToImage, '');
      expect(article.id, '');
      expect(article.publishedAt, isA<DateTime>());
    });
  });
}
