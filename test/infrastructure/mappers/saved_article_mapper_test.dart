import 'package:flutter_test/flutter_test.dart';
import 'package:noticias/domain/domain.dart';
import 'package:noticias/infrastructure/infrastructure.dart';

void main() {
  group('SavedArticleMapper', () {
    test('fromArticle debe mapear Article a SavedArticle correctamente', () {
      final article = Article(
        id: '1',
        title: 'Test title',
        description: 'Test description',
        author: 'Johan',
        content: 'Test content',
        url: 'https://test.com',
        urlToImage: 'https://image.com',
        publishedAt: DateTime(2025, 1, 1),
        source: const Source(
          id: 'cnn',
          name: 'CNN',
        ),
      );

      final saved = SavedArticleMapper.fromArticle(article);

      expect(saved.title, 'Test title');
      expect(saved.description, 'Test description');
      expect(saved.url, 'https://test.com');
      expect(saved.imageUrl, 'https://image.com');
      expect(saved.sourceName, 'CNN');
      expect(saved.publishedAt, DateTime(2025, 1, 1));
    });

    test('toArticle debe mapear SavedArticle a Article correctamente', () {
      final saved = SavedArticle()
        ..title = 'Saved title'
        ..description = 'Saved description'
        ..url = 'https://saved.com'
        ..imageUrl = 'https://image.com'
        ..sourceName = 'BBC'
        ..publishedAt = DateTime(2025, 1, 2);

      final article = SavedArticleMapper.toArticle(saved);

      expect(article.id, 'https://saved.com');
      expect(article.title, 'Saved title');
      expect(article.description, 'Saved description');
      expect(article.author, '');
      expect(article.content, '');
      expect(article.urlToImage, 'https://image.com');
      expect(article.source.name, 'BBC');
    });
  });
}
