import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_route_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

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
    final querySnapshot = await firestore.collection(routesCollection).get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return TouristicRoute.fromJson(data);
    }).toSet();
  }
}
