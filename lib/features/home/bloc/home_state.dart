import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Set<Spot> featuredSpots;
  final Set<Event> featuredEvents;
  final Set<ExperienceCategory> spotCategories;

  const HomeLoaded({
    required this.featuredSpots,
    required this.featuredEvents,
    required this.spotCategories,
  });

  @override
  List<Object> get props => [featuredSpots, featuredEvents, spotCategories];
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
