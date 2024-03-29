import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class LoadExperiences extends ExperienceEvent {
  final ExperienceType type;

  const LoadExperiences(this.type);

  @override
  List<Object> get props => [type];
}
