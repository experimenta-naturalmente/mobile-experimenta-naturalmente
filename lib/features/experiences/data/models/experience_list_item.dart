import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

class ExperienceListItem extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final ExperienceCategory category;

  const ExperienceListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl];
}
