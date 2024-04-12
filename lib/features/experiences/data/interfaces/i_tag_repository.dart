import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/tag.dart';

abstract class ITagRepository<TTag> {
  Future<Set<Tag>> fetchAllTags();
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category);
}
