import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noticias/config/config.dart';
import 'package:noticias/infrastructure/infrastructure.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late NewsApiDatasourceImpl datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = NewsApiDatasourceImpl(mockDio, apiKey: 'fake_api_key');
  });

  test(
    'getArticlesByCategory devuelve una lista de artículos cuando se le pasa la categoría',
    () async {
      // Arrange
      final fakeResponse = {
        'articles': [
          {
            'title': 'Flutter News',
            'description': 'Desc',
            'url': 'https://test.com',
            'urlToImage': 'https://test.com/image.png',
            'publishedAt': '2024-01-01T10:00:00Z',
            'source': {
              'id': 'test',
              'name': 'Test Source',
            },
          },
        ],
      };
  
      when(
        () => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: fakeResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );
  
      final result = await datasource.getArticlesByCategory(NewsCategory.science);
  
      expect(result, isNotEmpty);
      expect(result.first.title, 'Flutter News');
      verify(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
          .called(1);
    },
  );
}