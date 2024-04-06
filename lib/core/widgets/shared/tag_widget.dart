import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';

class TagWidget extends StatelessWidget {
  final Tag tag;
  final ExperienceCategory tagType;
  final double fontSize;
  final bool isSelected;
  final VoidCallback onPressed;

  const TagWidget({
    required this.tag,
    required this.tagType,
    required this.fontSize,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip.elevated(
      backgroundColor: Colors.transparent,
      label: Text(
        tag.name,
        style: TextStyle(fontSize: fontSize),
      ),
      selected: isSelected,
      onSelected: (_) {
        onPressed();
      },
      selectedColor: Colors.lightGreen.withOpacity(0.3),
    );
  }
}
