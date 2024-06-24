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
    final ScrollController scrollController = ScrollController();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: Stack(
        children: [
          Center(
            child: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tabs
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(
                            right: 4,
                            left: 4,
                            bottom: 8,
                          ),
                          child: ChoiceChip(
                            padding: const EdgeInsets.all(8.0),
                            label: Text(category.name),
                            selected: category == selectedCategory,
                            onSelected: (selected) {
                              onCategorySelected(category);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
