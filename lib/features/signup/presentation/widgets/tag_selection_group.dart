import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/tag.dart';

class TagSelectionGroup extends StatelessWidget {
  final Set<Tag> tags;
  final Map<int, bool> selectedTags;
  final Function(Tag) onSelected;

  const TagSelectionGroup({
    super.key,
    required this.tags,
    required this.selectedTags,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 16,
        runSpacing: 4,
        children: tags.map((tag) {
          final isSelected = selectedTags[tag.id] ?? false;
          return ChoiceChip(
            label: Text(
              tag.name,
              style: _getTagTextStyle(tag.name, context),
            ),
            selected: isSelected,
            onSelected: (_) {
              onSelected(tag);
            },
          );
        }).toList(),
      ),
    );
  }

  TextStyle _getTagTextStyle(String tagName, BuildContext context) {
    if (tagName.length < 10) {
      return Theme.of(context).textTheme.labelLarge!;
    } else if (tagName.length < 20) {
      return Theme.of(context).textTheme.labelMedium!;
    } else {
      return Theme.of(context).textTheme.labelSmall!;
    }
  }
}
