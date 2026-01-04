import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/infrastructure/infrastructure.dart';

final articleRepositoryProvider = Provider((ref) {
  return NewsApiRepositoryImpl(NewsApiDatasourceImpl());
});