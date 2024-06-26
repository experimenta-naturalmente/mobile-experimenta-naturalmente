import 'package:turismo_rural_frontend/core/utils/common.dart';

class RouteItem {
  final int routeId;
  final int experienceId;
  final String title;
  final String description;
  final int order;
  final String image;

  RouteItem({
    required this.routeId,
    required this.experienceId,
    required this.title,
    required this.description,
    required this.order,
    required this.image,
  });

  factory RouteItem.fromJson(Map<String, dynamic> json) {
    return RouteItem(
      routeId: json['routeExperienceId'] as int,
      experienceId: json['experienceId'] as int,
      title: decodeUtf8(json['title'] as String),
      description: decodeUtf8(json['description'] as String),
      order: json['orderIndex'] as int,
      image: json['image'] as String,
    );
  }

  List<Object?> get props => [
        routeId,
        experienceId,
        title,
        description,
        order,
        image,
      ];
}
