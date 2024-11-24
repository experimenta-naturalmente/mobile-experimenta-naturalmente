import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Set<Experience> featuredExperiences;
  final Set<TouristicRoute> featuredRoutes;

  const HomeLoaded({
    required this.featuredExperiences,
    required this.featuredRoutes,
  });

  @override
  List<Object> get props =>
      [featuredExperiences, featuredRoutes];
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
