import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_state.dart';
import 'package:turismo_rural_frontend/features/spots/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';

class TagSelectionBloc extends Bloc<TagSelectionEvent, TagSelectionState> {
  final ITagRepository tagRepository;

  TagSelectionBloc({required this.tagRepository})
      : super(const TagSelectionState(selectedTags: [], availableTags: {})) {
    on<ToggleTag>(_onToggleTag);
    on<ToggleTagInitialization>(_onToggleTagInitialization);
  }

  Future<void> _onToggleTag(
    ToggleTag event,
    Emitter<TagSelectionState> emit,
  ) async {
    final toggledTag = event.tag;
    final List<Tag> selectedTags = List.from(state.selectedTags);

    if (selectedTags.contains(toggledTag)) {
      selectedTags.remove(toggledTag);
    } else {
      selectedTags.add(toggledTag);
    }

    emit(state.copyWith(selectedTags: selectedTags));
  }

  Future<void> _onToggleTagInitialization(
    ToggleTagInitialization event,
    Emitter<TagSelectionState> emit,
  ) async {
    try {
      final List<Tag> availableTags = await tagRepository.fetchAllTags();

      // Agrupa as tags por categoria
      final Map<ExperienceCategory, List<Tag>> groupedTags = {};
      for (final tag in availableTags) {
        if (!groupedTags.containsKey(tag.type)) {
          groupedTags[tag.type] = [];
        }
        groupedTags[tag.type]!.add(tag);
      }

      emit(
        TagSelectionState(
          selectedTags: const [],
          availableTags: groupedTags,
        ),
      );
    } catch (e) {
      print('Erro ao buscar as tags: $e');
    }
  }
}
