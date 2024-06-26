import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

abstract class RouteState extends Equatable {
  const RouteState();
  @override
  List<Object> get props => [];
}

abstract class RouteListState extends RouteState {}

class RouteListInitial extends RouteListState {}

class RouteListLoading extends RouteListState {}

class RouteListLoaded extends RouteListState {
  final Set<TouristicRoute> routes;

  RouteListLoaded({required this.routes});

  @override
  List<Object> get props => [routes];
}

abstract class RouteDetailsState extends RouteState {
  final int routeId;

  const RouteDetailsState({required this.routeId});
}

class RouteDetailsInitial extends RouteDetailsState {
  const RouteDetailsInitial({required super.routeId});
}

class RouteDetailsLoading extends RouteDetailsState {
  const RouteDetailsLoading({required super.routeId});
}

class RouteDetailsLoaded extends RouteDetailsState {
  final TouristicRoute route;

  RouteDetailsLoaded({required this.route}) : super(routeId: route.routeId);

  @override
  List<Object> get props => [route];
}

class RouteError extends RouteDetailsState {
  final String error;

  const RouteError({required this.error, required super.routeId});

  @override
  List<Object> get props => [error];
}
