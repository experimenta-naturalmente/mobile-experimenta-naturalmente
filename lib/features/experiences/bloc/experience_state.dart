import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceInitialState extends ExperienceState {}

class ExperienceErrorState extends ExperienceState {
  final String error;

  const ExperienceErrorState(this.error);

  @override
  List<Object> get props => [error];
}

abstract class ExperienceDetailsState extends ExperienceState {}

class ExperienceDetailsLoadingState extends ExperienceDetailsState {
  final String experienceId;

  ExperienceDetailsLoadingState(this.experienceId);
}

class ExperienceDetailsLoadedState extends ExperienceDetailsState {
  final Experience experience;
  ExperienceDetailsLoadedState(this.experience);

  @override
  List<Object> get props => [experience];
}

abstract class ExperienceListState extends ExperienceState {}

class ExperienceCategoriesLoadingState extends ExperienceListState {}

class ExperienceListLoadingState extends ExperienceListState {
  final ExperienceCategory selectedCategory;
  final Set<ExperienceCategory> categories;

  ExperienceListLoadingState(this.selectedCategory, this.categories);
}

class ExperienceListLoadSuccessState extends ExperienceListState {
  final Set<Experience> experiences;
  final ExperienceCategory selectedCategory;
  final Set<ExperienceCategory> categories;

  ExperienceListLoadSuccessState(
    this.experiences,
    this.selectedCategory,
    this.categories,
  );

  @override
  List<Object> get props => [experiences];
}
