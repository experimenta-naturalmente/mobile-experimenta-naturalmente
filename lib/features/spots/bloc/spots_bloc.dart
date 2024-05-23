import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_state.dart';

class SpotsBloc extends Bloc<SpotsEvent, SpotsState> {
  final IExperienceRepository experienceRepository;
  Set<ExperienceCategory> categoriesCache = {};

  SpotsBloc({required this.experienceRepository})
      : super(SpotsFilterInitial()) {
    on<LoadSpotsCategories>(_onLoadSpotsCategories);
  }

  Future<void> _onLoadSpotsCategories(
    LoadSpotsCategories event,
    Emitter<SpotsState> emit,
  ) async {
    emit(SpotsCategoriesLoading());
    try {
      categoriesCache = await experienceRepository.fetchExperienceCategories();
      emit(SpotsCategoriesLoaded(categoriesCache));
      for (final category in categoriesCache) {
        final experiences =
            await experienceRepository.fetchExperiencesFromCategory(category);
        final experienceList = experiences.map((e) {
          return ExperienceListItem(
            id: e.id,
            name: e.name,
            description: e.description,
            category: e.category,
            imageUrl: 'https://picsum.photos/300/400?random=${e.id}',
          );
        }).toSet();
        emit(SpotsExperienceLoaded(experienceList));
      }
    } catch (e) {
      emit(SpotsError(e.toString()));
    }
  }
}
