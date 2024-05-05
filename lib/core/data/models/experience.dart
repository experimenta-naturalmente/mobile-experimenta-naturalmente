import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

abstract class Experience extends Equatable {
  final int id;
  final String name;
  final String description;
  final ExperienceCategory category;

  const Experience({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });
}
