enum NewsCategory {
  general,
  business,
  science,
  entertainment,
  sports,
  technology,
  health,
}

extension NewsCategoryX on NewsCategory {
  String get label {
    switch (this) {
      case NewsCategory.general:
        return 'General';
      case NewsCategory.business:
        return 'Business';
      case NewsCategory.science:
        return 'Science';
      case NewsCategory.entertainment:
        return 'Entertainment';
      case NewsCategory.sports:
        return 'Sports';
      case NewsCategory.technology:
        return 'Technology';
      case NewsCategory.health:
        return 'Health';
    }
  }
}
