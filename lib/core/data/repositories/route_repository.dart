import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

class RouteRepository implements IRouteRepository {
  Uri apiUri;

  RouteRepository({required this.apiUri});

  @override
  Future<TouristicRoute?> fetchRouteDetails(int routeId) async {
    final response = await http.get(apiUri.replace(path: 'route/$routeId'));

    if (response.statusCode == 200) {
      final route = TouristicRoute.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      return route;
    } else {
      return null;
    }
  }

  @override
  Future<Set<TouristicRoute>> fetchRoutes() async {
    try {
      final response = await http.get(apiUri.replace(path: 'route'));
      if (response.statusCode != 200) {
        throw Exception('Falha ao carregar rotas (HTTP ${response.statusCode})');
      }

      final routes = json.decode(response.body) as List<dynamic>;
      return routes
          .map(
            (route) => TouristicRoute.fromJson(route as Map<String, dynamic>),
          )
          .toSet();
    } on SocketException {
      throw Exception('Sem conexão com a internet ao carregar rotas.');
    }
  }
}
