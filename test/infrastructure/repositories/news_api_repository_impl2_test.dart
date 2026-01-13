import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noticias/domain/domain.dart';
import 'package:noticias/infrastructure/infrastructure.dart';

class MockDatasource extends Mock implements NewsRemoteDatasource {}

void main() {
  late MockDatasource mockDatasource;
  late NewsApiRepositoryImpl repository;

  setUp(() {
    mockDatasource = MockDatasource();
    repository = NewsApiRepositoryImpl(mockDatasource);
  });

  test('searchNews llama al datasource y devuelve artículos', () async {
    final articles = [Article(id: '1', title: 'Test', author: '', description: '', content: '', url: '', urlToImage: '', publishedAt: DateTime.now(), source: const Source(id: '', name: ''))];
    when(() => mockDatasource.searchNews(query: 'Flutter'))
        .thenAnswer((_) async => articles);

    final result = await repository.searchNews(query: 'Flutter');

    expect(result, articles);
    verify(() => mockDatasource.searchNews(query: 'Flutter')).called(1);
  });
}
