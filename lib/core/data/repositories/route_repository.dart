import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';
import 'package:turismo_rural_frontend/core/repositories_config.dart';

class RouteRepository implements IRouteRepository {
  final FirebaseFirestore firestore;
  final String routesCollection = 'routes';

  RouteRepository({required this.firestore});

  @override
  Future<TouristicRoute?> fetchRouteDetails(int routeId) async {
    final doc = await firestore
        .collection(routesCollection)
        .doc(routeId.toString())
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      return TouristicRoute.fromJson(data);
    }

    return null;
  }

  @override
  Future<Set<TouristicRoute>> fetchRoutes() async {
    try {
      final snapshot = await firestore.collection(routesCollection).get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // ensure id is present
        return TouristicRoute.fromJson(data);
      }).toSet();
    } catch (e) {
      print('Rotas não disponíveis: $e');
      return {};
    }
  }
}
