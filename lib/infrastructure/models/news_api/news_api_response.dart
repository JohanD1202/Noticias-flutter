class ArticleModel {
    final SourceModel source;
    final String? author;
    final String title;
    final String description;
    final String url;
    final String? urlToImage;
    final DateTime? publishedAt;
    final String? content;

    ArticleModel({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromJson(json["source"]),
        author: json["author"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.tryParse(json["publishedAt"] ?? '') 
          ?? DateTime.now(),
        content: json["content"] ?? '',
    );
}

class SourceModel {
    final String? id;
    final String name;

    SourceModel({
        required this.id,
        required this.name,
    });

    factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"] ?? 'Unknown',
    );
}
