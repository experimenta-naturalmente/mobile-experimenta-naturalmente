import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

abstract class SpotsState extends Equatable {
  const SpotsState();

  @override
  List<Object> get props => [];
}

class SpotsFilterInitial extends SpotsState {}

class SpotsCategoriesLoading extends SpotsState {}

class SpotsCategoriesLoaded extends SpotsState {
  final Set<ExperienceCategory> categories;

  const SpotsCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class SpotsExperienceLoaded extends SpotsState {
  final Set<ExperienceListItem> experienceList;

  const SpotsExperienceLoaded(this.experienceList);

  @override
  List<Object> get props => [experienceList];
}

class SpotsError extends SpotsState {
  final String error;

  const SpotsError(this.error);

  @override
  List<Object> get props => [error];
}
