import 'package:isar/isar.dart';

part 'saved_article.g.dart';

@collection
class SavedArticle {

  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String url;
  late String sourceName;
  late String imageUrl;
  late DateTime publishedAt;
}
  