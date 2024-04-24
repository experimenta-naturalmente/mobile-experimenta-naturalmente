import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final IExperienceRepository experienceRepository;

  // na declaração do bloc, cada evento é associado a uma função
  ExperienceBloc({
    required this.experienceRepository,
  }) : super(ExperienceFilterInitial()) {
    on<ExperienceCategoryChanged>(_onExperienceCategoryChanged);
    on<LoadExperienceCategories>(_onLoadExperienceCategories);
    on<ExperienceSelected>(_onExperienceSelected);
  }

  Future<void> _onLoadExperienceCategories(
    LoadExperienceCategories event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceCategoriesLoading());
    try {
      final Set<ExperienceCategory> categories =
          await experienceRepository.fetchExperienceCategories();
      add(ExperienceCategoryChanged(categories.first, categories));
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }

  Future<void> _onExperienceCategoryChanged(
    ExperienceCategoryChanged event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceListLoading(event.selectedCategory, event.categories));
    try {
      final Set<ExperienceListItem> experienceItems = await experienceRepository
          .fetchExperiencesfromCategory(event.selectedCategory);
      emit(
        ExperienceListLoadSuccess(
          experienceItems,
          event.selectedCategory,
          event.categories,
        ),
      );
    } catch (e) {
      emit(ExperienceError(e.toString()));
    }
  }

  Future<void> _onExperienceSelected(
    ExperienceSelected event,
    Emitter<ExperienceState> emit,
  ) async {
    print('Experience selected: ${event.selectedItem.name}');
  }
}
