import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/config.dart';
import '/presentation/providers/providers.dart';


class CategorySelector extends ConsumerWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: NewsCategory.values.map((category) {
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ChoiceChip(
              label: Text(category.label),
              selected: isSelected,
              onSelected: (_) {
                ref
                    .read(selectedCategoryProvider.notifier)
                    .setCategory(category);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
