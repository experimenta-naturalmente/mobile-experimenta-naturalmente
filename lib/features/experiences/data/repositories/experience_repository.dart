import 'dart:math';

import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

class ExperienceRepository implements IExperienceRepository {
  @override
  Future<Set<ExperienceListItem>> fetchExperiencesfromCategory(
    ExperienceCategory category,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final rand = Random();
    return Set.from(
      List.generate(
        10,
        (index) => ExperienceListItem(
          id: index,
          name: LoremIpsumGenerator.generate(words: rand.nextInt(5) + 1),
          description: LoremIpsumGenerator.generate(
            paragraphs: rand.nextInt(2) + 1,
            wordsPerParagraph: rand.nextInt(30) + 10,
          ),
          imageUrl: 'https://picsum.photos/300/400?random=$index',
        ),
      ),
    );
  }

  @override
  Future<Set<ExperienceCategory>> fetchExperienceCategories() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return <ExperienceCategory>{
      const ExperienceCategory(
        id: 1,
        name: 'Hotel',
      ),
      const ExperienceCategory(
        id: 2,
        name: 'Restaurante',
      ),
      const ExperienceCategory(
        id: 3,
        name: 'Turismo',
      ),
      const ExperienceCategory(
        id: 4,
        name: 'Produtor rural',
      ),
      const ExperienceCategory(
        id: 5,
        name: 'Atração turística',
      ),
      const ExperienceCategory(
        id: 6,
        name: 'Evento',
      ),
    };
  }
}
