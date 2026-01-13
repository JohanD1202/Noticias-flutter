import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';


final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'apiKey': Environment.newsApiKey,
      },
    ),
  );
});
