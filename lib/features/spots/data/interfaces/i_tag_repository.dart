import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';

abstract class ITagRepository<TTag> {
  Future<List<Tag>> fetchAllTags();

  Future<List<Tag>> fetchTagsFromCategory(ExperienceCategory category);
}
