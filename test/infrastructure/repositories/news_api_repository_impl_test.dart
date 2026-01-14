import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noticias/domain/domain.dart';
import 'package:noticias/infrastructure/infrastructure.dart';
import 'package:noticias/config/config.dart';

class MockDatasource extends Mock implements NewsRemoteDatasource {}

void main() {
  late MockDatasource mockDatasource;
  late NewsApiRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockDatasource();
    repository = NewsApiRepositoryImpl(mockDatasource);
  });

  test('getArticlesByCategory llama al datasource y devuelve artículos', () async {
    final articles = [Article(id: '1', title: 'Test', author: '', description: '', content: '', url: '', urlToImage: '', publishedAt: DateTime.now(), source: const Source(id: '', name: ''))];
    when(() => mockDatasource.getArticlesByCategory(NewsCategory.science))
        .thenAnswer((_) async => articles);

    final result = await repository.getArticlesByCategory(NewsCategory.science);

    expect(result, articles);
    verify(() => mockDatasource.getArticlesByCategory(NewsCategory.science)).called(1);
  });
}
