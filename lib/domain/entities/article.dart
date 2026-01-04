import '/domain/domain.dart';

class Article {
  final String id;
  final String title;
  final String author;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final Source source;

  const Article({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
  });
}
