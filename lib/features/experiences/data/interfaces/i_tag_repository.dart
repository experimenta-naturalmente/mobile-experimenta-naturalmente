import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/tag.dart';

abstract class ITagRepository<TTag> {
  Future<Set<Tag>> fetchAllTags();
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category);
}
