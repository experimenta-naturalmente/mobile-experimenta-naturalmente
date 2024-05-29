import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class ExperienceListItem extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final ExperienceCategory category;
  final List<String> timeDetails;
  final List<String> socialNetworks;
  final Set<Tag> tags;

  const ExperienceListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.timeDetails,
    required this.socialNetworks,
    required this.tags,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        category,
        timeDetails,
        socialNetworks,
        tags,
      ];
}
