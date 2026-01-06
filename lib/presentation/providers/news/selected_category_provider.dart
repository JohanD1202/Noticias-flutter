import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noticias/config/constants/news_category.dart';


class SelectedCategoryNotifier extends Notifier<NewsCategory> {
  @override
  NewsCategory build() {
    return NewsCategory.general;
  }

  void setCategory(NewsCategory category) {
    state = category;
  }
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, NewsCategory>(
  SelectedCategoryNotifier.new,
);


