import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/tag.dart';

class TagSelectionState extends Equatable {
  final Map<int, bool> selectedTags;
  final Map<ExperienceCategory, Set<Tag>> availableTags;

  const TagSelectionState({
    required this.selectedTags,
    required this.availableTags,
  });

  @override
  List<Object?> get props => [selectedTags, availableTags];

  TagSelectionState copyWith({
    Map<int, bool>? selectedTags,
    Map<ExperienceCategory, Set<Tag>>? availableTags,
  }) {
    return TagSelectionState(
      selectedTags: selectedTags ?? this.selectedTags,
      availableTags: availableTags ?? this.availableTags,
    );
  }
}
