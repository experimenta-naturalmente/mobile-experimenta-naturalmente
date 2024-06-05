import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Wrap(
            spacing: 8.0,
            children: tabs
                .map(
                  (category) => ChoiceChip(
                    padding: const EdgeInsets.all(8.0),
                    label: Text(category.name),
                    selected: category == selectedCategory,
                    onSelected: (selected) {
                      onCategorySelected(category);
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
