import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/tag.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_state.dart';

class TagSelectionBloc extends Bloc<TagSelectionEvent, TagSelectionState> {
  final ITagRepository tagRepository;

  TagSelectionBloc({required this.tagRepository})
      : super(const TagSelectionState(selectedTags: {}, availableTags: {})) {
    on<ToggleTag>(_onToggleTag);
    on<ToggleTagInitialization>(_onToggleTagInitialization);
  }

  Future<void> _onToggleTag(
    ToggleTag event,
    Emitter<TagSelectionState> emit,
  ) async {
    final toggledTag = event.tag;
    final selectedTags = Map<int, bool>.from(state.selectedTags);
    selectedTags.update(
      toggledTag.id,
      (value) => !value,
      ifAbsent: () => false,
    );

    emit(state.copyWith(selectedTags: selectedTags));
  }

  Future<void> _onToggleTagInitialization(
    ToggleTagInitialization event,
    Emitter<TagSelectionState> emit,
  ) async {
    try {
      final Set<Tag> availableTags = await tagRepository.fetchAllTags();
      final Map<int, bool> selectedTags = {};

      // Agrupa as tags por categoria
      final Map<ExperienceCategory, Set<Tag>> groupedTags = {};
      for (final tag in availableTags) {
        if (!groupedTags.containsKey(tag.type)) {
          groupedTags[tag.type] = {};
        }
        groupedTags[tag.type]!.add(tag);
        selectedTags[tag.id] = false;
      }

      emit(
        TagSelectionState(
          selectedTags: selectedTags,
          availableTags: groupedTags,
        ),
      );
    } catch (e) {
      print('Erro ao buscar as tags: $e');
    }
  }
}
