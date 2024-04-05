import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class LoadSignUp extends SignUpEvent {}

class SignUpNextPage extends SignUpEvent {
  final ExperienceCategory selectedCategory;

  const SignUpNextPage(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}
