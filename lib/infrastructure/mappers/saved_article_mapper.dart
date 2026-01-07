import '/domain/domain.dart';

class SavedArticleMapper {
  static SavedArticle fromArticle(Article article) {
    final saved = SavedArticle()
      ..title = article.title
      ..description = article.description
      ..url = article.url
      ..imageUrl = article.urlToImage
      ..sourceName = article.source.name
      ..publishedAt = article.publishedAt;

    return saved;
  }
  static Article toArticle(SavedArticle saved) {
    return Article(
      id: saved.url,
      title: saved.title,
      description: saved.description,
      author: '',
      content: '',
      url: saved.url,
      urlToImage: saved.imageUrl,
      publishedAt: saved.publishedAt,
      source: Source(
        id: '',
        name: saved.sourceName,
      ),
    );
  }
}
