import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
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
            timeDetails: const [
              "Segunda-Feira: 9am - 5pm",
              "Terça-Feira: 9am - 5pm",
              "Quarta-Feira: 9am - 5pm",
              "Quinta-Feira: 9am - 5pm",
              "Sexta-Feira: 9am - 5pm",
              "Sábado: 9am - 5pm",
              "Domingo: 9am - 5pm",
            ],
            socialNetworks: const [
              "https://www.instagram.com/parque8cachoeiras/",
              "https://www.parque8cachoeiras.com.br",
            ],
            tags: {
              const Tag(
                id: 29,
                name: 'Comida Caseira',
                type: [ExperienceCategory(id: 2, name: 'Restaurante')],
              ),
              const Tag(
                id: 26,
                name: 'Pet Friendly',
                type: [ExperienceCategory(id: 2, name: 'Restaurante')],
              ),
              const Tag(
                id: 14,
                name: 'Estacionamento Gratuito',
                type: [ExperienceCategory(id: 1, name: 'Hotel')],
              ),
              const Tag(
                id: 7,
                name: 'Cervejaria Artesanal',
                type: [ExperienceCategory(id: 4, name: 'Produtor rural')],
              ),
              const Tag(
                id: 2,
                name: 'Mirante',
                type: [ExperienceCategory(id: 5, name: 'Atração turística')],
              ),
            },
          );
        }).toSet();
        emit(SpotsExperienceLoaded(experienceList));
      }
    } catch (e) {
      emit(SpotsError(e.toString()));
    }
  }
}
