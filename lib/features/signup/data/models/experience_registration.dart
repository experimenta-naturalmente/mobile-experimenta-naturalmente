import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/tag.dart';

class ExperienceRegistration {
  ExperienceCategory? category;
  String? name;
  String? description;
  Set<Tag>? tags;

  ExperienceRegistration({
    this.category,
    this.name,
    this.description,
    this.tags,
  });
}
