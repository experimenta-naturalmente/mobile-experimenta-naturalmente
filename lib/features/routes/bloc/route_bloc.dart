import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final IRouteRepository routeRepository;
  RouteBloc({required this.routeRepository}) : super(RouteListInitial()) {
    on<LoadRouteDetails>(_loadRouteDetails);
    on<LoadRouteList>(_loadRouteList);
    on<RouteSelected>(_routeSelected);
    on<LoadRoute>(_loadRoute);
  }

  Future<void> _loadRouteDetails(
    LoadRouteDetails event,
    Emitter<RouteState> emit,
  ) async {
    emit(RouteDetailsLoading(routeId: event.routeId));
    try {
      final route = await routeRepository.fetchRouteDetails(event.routeId);
      if (route == null) {
        emit(RouteError(error: 'Route not found', routeId: event.routeId));
        return;
      }
      emit(RouteDetailsLoaded(route: route));
    } catch (e) {
      emit(RouteError(error: e.toString(), routeId: event.routeId));
    }
  }

  Future<void> _loadRouteList(
    LoadRouteList event,
    Emitter<RouteState> emit,
  ) async {
    emit(RouteListLoading());
    try {
      final routes = await routeRepository.fetchRoutes();
      emit(RouteListLoaded(routes: routes));
    } catch (e) {
      emit(RouteError(error: e.toString(), routeId: 1));
    }
  }

  Future<void> _routeSelected(
    RouteSelected event,
    Emitter<RouteState> emit,
  ) async {
    emit(RouteDetailsInitial(routeId: event.route.routeId));
  }

  Future<void> _loadRoute(
    LoadRoute event,
    Emitter<RouteState> emit,
  ) async {
    emit(RouteDetailsLoading(routeId: event.routeId));
    try {
      final route = await routeRepository.fetchRouteDetails(event.routeId);
      if (route == null) {
        emit(
          RouteError(
            error: 'Rota Turística não encontrada',
            routeId: event.routeId,
          ),
        );
        return;
      }
      emit(RouteDetailsLoaded(route: route));
    } catch (e) {
      emit(RouteError(error: e.toString(), routeId: event.routeId));
    }
  }
}
