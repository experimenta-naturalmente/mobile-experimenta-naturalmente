import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';

class ExperienceCategoryTabView extends StatelessWidget {
  final Set<ExperienceCategory> tabs;
  final ExperienceCategory selectedCategory;
  final Function(ExperienceCategory) onCategorySelected;

  const ExperienceCategoryTabView({
    super.key,
    required this.tabs,
    required this.selectedCategory,
    required this.onCategorySelected,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: tabs
          .map(
            (category) => ChoiceChip(
              label: Text(category.name),
              selected: category == selectedCategory,
              onSelected: (selected) {
                if (selected) {
                  onCategorySelected(category);
                }
              },
            ),
          )
          .toList(),
    );
  }
}
