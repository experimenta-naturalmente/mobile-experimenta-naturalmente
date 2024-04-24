import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Set<Experience> spots;
  final Set<Experience> events;

  const HomeLoaded(this.spots, this.events);

  @override
  List<Object> get props => [spots, events];
}

class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);

  @override
  List<Object> get props => [error];
}
