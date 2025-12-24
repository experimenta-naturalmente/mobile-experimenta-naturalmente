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
      routeId: json['routeExperienceId'] is int
          ? json['routeExperienceId'] as int
          : int.tryParse(json['routeExperienceId']?.toString() ?? '') ?? 0,
      experienceId: json['experienceId'] is int
          ? json['experienceId'] as int
          : int.tryParse(json['experienceId']?.toString() ?? '') ?? 0,
      title: json['title'] != null ? decodeUtf8(json['title'] as String) : '',
      description: json['description'] != null
          ? decodeUtf8(json['description'] as String)
          : '',
      order: json['orderIndex'] is int
          ? json['orderIndex'] as int
          : int.tryParse(json['orderIndex']?.toString() ?? '') ?? 0,
      image: json['image']?.toString() ?? '',
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
