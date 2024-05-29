import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final IExperienceRepository experienceRepository;

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
      final Set<Experience> experiences = await experienceRepository
          .fetchExperiencesFromCategory(event.selectedCategory);
      final Set<ExperienceListItem> experienceItems = experiences
          .map(
            (e) => ExperienceListItem(
              id: e.id,
              name: e.name,
              description: e.description,
              category: e.category,
              imageUrl: 'https://picsum.photos/300/400?random=$e.id',
              timeDetails: e.timeDetails,
              socialNetworks: e.socialNetworks,
              tags: e.tags,
            ),
          )
          .toSet();

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
    emit(ExperienceDetails(event.selectedItem));
  }
}
