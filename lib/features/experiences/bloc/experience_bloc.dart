import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final IExperienceRepository experienceRepository;

  ExperienceBloc({
    required this.experienceRepository,
  }) : super(ExperienceInitialState()) {
    on<ExperienceCategoryChanged>(_onExperienceCategoryChanged);
    on<LoadExperienceCategories>(_onLoadExperienceCategories);
    on<ExperienceSelected>(_onExperienceSelected);
    on<LoadExperienceDetails>(_onLoadExperienceDetails);
  }

  Future<void> _onLoadExperienceCategories(
    LoadExperienceCategories event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceCategoriesLoadingState());
    try {
      final Set<ExperienceCategory> categories =
          await experienceRepository.fetchExperienceCategories();
      add(ExperienceCategoryChanged(categories.first, categories));
    } catch (e) {
      emit(ExperienceErrorState(e.toString()));
    }
  }

  Future<void> _onExperienceCategoryChanged(
    ExperienceCategoryChanged event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceListLoadingState(event.selectedCategory, event.categories));
    try {
      final Set<Experience> experiences = await experienceRepository
          .fetchExperiencesFromCategory(event.selectedCategory);

      emit(
        ExperienceListLoadSuccessState(
          experiences,
          event.selectedCategory,
          event.categories,
        ),
      );
    } catch (e) {
      emit(ExperienceErrorState(e.toString()));
    }
  }

  Future<void> _onExperienceSelected(
    ExperienceSelected event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceDetailsLoadedState(event.selectedItem));
  }

  Future<void> _onLoadExperienceDetails(
    LoadExperienceDetails event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceDetailsLoadingState(event.experienceId));
    try {
      final experience = await experienceRepository.fetchExperienceById(
        event.experienceId,
      );
      if (experience == null) {
        emit(const ExperienceErrorState('Experience not found'));
        return;
      }
      emit(ExperienceDetailsLoadedState(experience));
    } catch (e) {
      emit(ExperienceErrorState(e.toString()));
    }
  }
}
