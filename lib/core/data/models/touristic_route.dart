import 'package:turismo_rural_frontend/core/data/models/route_item.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class TouristicRoute {
  final int routeId;
  final String name;
  final String description;
  final List<RouteItem> experienceList;

  TouristicRoute({
    required this.routeId,
    required this.name,
    required this.description,
    required this.experienceList,
  });

  factory TouristicRoute.fromJson(Map<String, dynamic> json) {
    final experienceJsonList = json['experiences'] as List? ?? [];

    final experienceList = experienceJsonList
        .map((json) => RouteItem.fromJson(json as Map<String, dynamic>))
        .toList();

    return TouristicRoute(
      routeId: json['id'] as int,
      name: decodeUtf8(json['name'] as String),
      description: decodeUtf8(json['description'] as String),
      experienceList: experienceList,
    );
  }

  List<Object?> get props => [
        routeId,
        name,
        description,
        experienceList,
      ];
}
