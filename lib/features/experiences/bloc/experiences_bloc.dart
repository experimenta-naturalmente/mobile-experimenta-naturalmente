import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/attractions/data/interfaces/i_attraction_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_state.dart';
import 'package:turismo_rural_frontend/features/experiences/data/experience.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final IAttractionRepository attractionRepository;

  ExperienceBloc({required this.attractionRepository})
      : super(ExperienceInitial()) {
    on<LoadExperiences>(_onLoadExperiences);
  }

  Future<void> _onLoadExperiences(
    LoadExperiences event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());
    try {
      final List<Experience> experiences;
      switch (event.type) {
        case ExperienceType.attraction:
          experiences = await attractionRepository.fetchAttractions();
      }
      emit(ExperienceLoadSuccess(experiences));
    } catch (e) {
      emit(ExperienceLoadError(e.toString()));
    }
  }
}
