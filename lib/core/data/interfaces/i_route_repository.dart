import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

abstract class IRouteRepository {
  Future<TouristicRoute?> fetchRouteDetails(int routeId);
  Future<Set<TouristicRoute>> fetchRoutes();
}
