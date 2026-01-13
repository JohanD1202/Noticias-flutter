import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
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
    'searchNews devuelve una lista vacía cuando query está vacío',
    () async {
      final result = await datasource.searchNews(query: '');

      expect(result, isEmpty);

      verifyNever(() => mockDio.get(any()));
    },
  );
}
