import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class LoadExperienceCategories extends ExperienceEvent {}

class ExperienceCategoryChanged extends ExperienceEvent {
  final ExperienceCategory selectedCategory;
  final List<ExperienceCategory> categories;

  const ExperienceCategoryChanged(this.selectedCategory, this.categories);

  @override
  List<Object> get props => [selectedCategory];
}

class ExperienceSelected extends ExperienceEvent {
  final ExperienceListItem selectedItem;

  const ExperienceSelected(this.selectedItem);

  @override
  List<Object> get props => [selectedItem];
}
