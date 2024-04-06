import 'dart:math';

import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/spots/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';

class TagRepository implements ITagRepository {
  @override
  Future<List<Tag>> fetchAllTags() async {
    // Simulando a busca de todas as tags
    await Future.delayed(const Duration(milliseconds: 250));
    final rand = Random();
    return List.generate(
      20,
      (index) => Tag(
        id: index,
        name: 'Tag ${index + 1}',
        type: ExperienceCategory(
          id: rand.nextInt(4) + 1,
          name: 'Categoria ${rand.nextInt(4) + 1}',
        ),
      ),
    );
  }

  @override
  Future<List<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    // Simulando a busca de tags de uma categoria específica
    await Future.delayed(const Duration(milliseconds: 250));
    return List.generate(
      10,
      (index) => Tag(
        id: index,
        name: 'Tag ${index + 1} - ${category.name}',
        type: category,
      ),
    );
  }
}
