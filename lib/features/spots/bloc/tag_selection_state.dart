import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';

class TagSelectionState extends Equatable {
  final List<Tag> selectedTags;
  final Map<ExperienceCategory, List<Tag>> availableTags;

  const TagSelectionState({
    required this.selectedTags,
    required this.availableTags,
  });

  @override
  List<Object?> get props => [selectedTags, availableTags];

  TagSelectionState copyWith({
    List<Tag>? selectedTags,
    Map<ExperienceCategory, List<Tag>>? availableTags,
  }) {
    return TagSelectionState(
      selectedTags: selectedTags ?? this.selectedTags,
      availableTags: availableTags ?? this.availableTags,
    );
  }
}
