import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IExperienceRepository experienceRepository;
  final IRouteRepository routeRepository;

  HomeBloc({
    required this.experienceRepository,
    required this.routeRepository,
  }) : super(HomeInitial()) {
    on<HomeLoadData>(_onLoadData);
  }

  Future<void> _onLoadData(
    HomeLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final eventsFuture = experienceRepository.fetchEvents();
      final spotsFuture = experienceRepository.fetchAllSpots();
      final routesFuture = routeRepository.fetchRoutes();
      final events = await eventsFuture;
      final spots = await spotsFuture;
      final routes = await routesFuture;
      final categories = spots.map((e) => e.category).toSet();

      emit(
        HomeLoaded(
          featuredEvents: events.toSet(),
          featuredSpots: spots,
          featuredRoutes: routes,
          spotCategories: categories,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
