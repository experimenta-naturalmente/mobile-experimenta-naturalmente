import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

class TagRepository implements ITagRepository {
  @override
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    // Simulando tags para a categoria
    return {
      Tag(id: '1', name: 'Natureza', type: [category]),
      Tag(id: '2', name: 'Aventura', type: [category]),
      Tag(id: '3', name: 'Cultura', type: [category]),
    };
  }
}
