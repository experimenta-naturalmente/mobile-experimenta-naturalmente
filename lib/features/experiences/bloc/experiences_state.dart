import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/experience.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceLoadSuccess extends ExperienceState {
  final List<Experience> experiences;

  const ExperienceLoadSuccess(this.experiences);

  @override
  List<Object> get props => [experiences];
}

class ExperienceLoadError extends ExperienceState {
  final String error;

  const ExperienceLoadError(this.error);

  @override
  List<Object> get props => [error];
}
