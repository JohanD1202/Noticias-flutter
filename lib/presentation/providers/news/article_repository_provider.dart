import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noticias/config/config.dart';
import '/presentation/providers/providers.dart';
import '/infrastructure/infrastructure.dart';

final articleRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return NewsApiRepositoryImpl(NewsApiDatasourceImpl(dio, apiKey: Environment.newsApiKey));
});