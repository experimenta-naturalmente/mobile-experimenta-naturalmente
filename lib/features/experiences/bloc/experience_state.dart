import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceFilterInitial extends ExperienceState {}

class ExperienceCategoriesLoading extends ExperienceState {}

class ExperienceError extends ExperienceState {
  final String error;

  const ExperienceError(this.error);

  @override
  List<Object> get props => [error];
}

class ExperienceListLoading extends ExperienceState {
  final ExperienceCategory selectedCategory;
  final Set<ExperienceCategory> categories;

  const ExperienceListLoading(this.selectedCategory, this.categories);
}

class ExperienceListLoadSuccess extends ExperienceState {
  final Set<ExperienceListItem> experiences;
  final ExperienceCategory selectedCategory;
  final Set<ExperienceCategory> categories;

  const ExperienceListLoadSuccess(
    this.experiences,
    this.selectedCategory,
    this.categories,
  );

  @override
  List<Object> get props => [experiences];
}
