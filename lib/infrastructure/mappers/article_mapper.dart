import '/infrastructure/infrastructure.dart';
import '/domain/domain.dart';


class ArticleMapper {
  static Article newsApiToEntity(ArticleModel newsApi) => Article(
    id: newsApi.source.id ?? '',
    title: newsApi.title,
    author: newsApi.author ?? 'Unknown',
    description: newsApi.description,
    content: newsApi.content ?? '',
    url: newsApi.url,
    urlToImage: newsApi.urlToImage ?? '',
    publishedAt: newsApi.publishedAt ?? DateTime.now(),
    source: Source(
      id: newsApi.source.id ?? '',
      name: newsApi.source.name,
    ),
  );
}