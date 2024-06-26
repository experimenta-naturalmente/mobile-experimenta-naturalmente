import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();

  @override
  List<Object> get props => [];
}

class LoadRouteList extends RouteEvent {}

class LoadRoute extends RouteEvent {
  final int routeId;

  const LoadRoute(this.routeId);

  @override
  List<Object> get props => [routeId];
}

class RouteSelected extends RouteEvent {
  final TouristicRoute route;

  const RouteSelected(this.route);

  @override
  List<Object> get props => [route];
}

class LoadRouteDetails extends RouteEvent {
  final int routeId;

  const LoadRouteDetails(this.routeId);

  @override
  List<Object> get props => [routeId];
}
