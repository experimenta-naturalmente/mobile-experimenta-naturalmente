import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';

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
  final List<ExperienceCategory> categories;

  const ExperienceListLoading(this.selectedCategory, this.categories);
}

class ExperienceListLoadSuccess extends ExperienceState {
  final List<ExperienceListItem> experiences;
  final ExperienceCategory selectedCategory;
  final List<ExperienceCategory> categories;

  const ExperienceListLoadSuccess(
    this.experiences,
    this.selectedCategory,
    this.categories,
  );

  @override
  List<Object> get props => [experiences];
}
