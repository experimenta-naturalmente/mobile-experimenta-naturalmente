
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IExperienceRepository experienceRepository;

  HomeBloc({
    required this.experienceRepository,
  }) : super(HomeInitial()) {
    on<HomeLoadData>(_onLoadData);
  }

  Future<void> _onLoadData(
    HomeLoadData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final events = experienceRepository.fetchEvents();
      final spots = experienceRepository.fetchSpots();
      emit(
        HomeLoaded(
          events: await events,
          spots: await spots,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
