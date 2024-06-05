import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class LoadExperienceCategories extends ExperienceEvent {}

class ExperienceCategoryChanged extends ExperienceEvent {
  final ExperienceCategory selectedCategory;
  final Set<ExperienceCategory> categories;

  const ExperienceCategoryChanged(this.selectedCategory, this.categories);

  @override
  List<Object> get props => [selectedCategory];
}

class ExperienceSelected extends ExperienceEvent {
  final Experience selectedItem;

  const ExperienceSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}
