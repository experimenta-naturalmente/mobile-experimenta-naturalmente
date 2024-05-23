import 'dart:math';

import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';

class ExperienceRepository implements IExperienceRepository {
  @override
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final rand = Random();
    final categories = await fetchExperienceCategories();
    final Set<Experience> generatedExperiences = Set.from(
      List.generate(10, (index) {
        final category = categories.elementAt(rand.nextInt(categories.length));
        if (category.name == 'Evento') {
          return Event(
            id: index,
            name: 'Experience $index',
            about: LoremIpsumGenerator.generate(words: rand.nextInt(5) + 1),
            description: LoremIpsumGenerator.generate(
              paragraphs: rand.nextInt(2) + 1,
              wordsPerParagraph: rand.nextInt(30) + 10,
            ),
            category: category,
          );
        } else {
          return Spot(
            id: index,
            name: 'Experience $index',
            description: LoremIpsumGenerator.generate(
              paragraphs: rand.nextInt(2) + 1,
              wordsPerParagraph: rand.nextInt(30) + 10,
            ),
            category: category,
            openingHours: '1',
          );
        }
      }),
    );

    return generatedExperiences
        .where((element) => element.category == category)
        .toSet();
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
        name: 'Produtor rural',
      ),
      const ExperienceCategory(
        id: 4,
        name: 'Atração turística',
      ),
      const ExperienceCategory(
        id: 5,
        name: 'Evento',
      ),
    };
  }

  @override
  Future<Set<Event>> fetchFeaturedEvents() async {
    await Future.delayed(const Duration(milliseconds: 250));
    final rand = Random();
    final categories = await fetchExperienceCategories();
    final list = List.generate(10, (index) {
      return Event(
        id: index,
        name: 'Event $index',
        about: LoremIpsumGenerator.generate(words: rand.nextInt(5) + 1),
        description: LoremIpsumGenerator.generate(
          paragraphs: rand.nextInt(2) + 1,
          wordsPerParagraph: rand.nextInt(30) + 10,
        ),
        category: categories.elementAt(rand.nextInt(categories.length)),
      );
    });
    return Set.from(list);
  }

  @override
  Future<Set<Spot>> fetchFeaturedSpots() async {
    await Future.delayed(const Duration(milliseconds: 250));
    final rand = Random();
    final categories = await fetchExperienceCategories();
    categories.removeWhere((element) => element.name == 'Evento');
    final list = List.generate(50, (index) {
      return Spot(
        id: index,
        name: 'Spot $index',
        description: LoremIpsumGenerator.generate(
          paragraphs: rand.nextInt(2) + 1,
          wordsPerParagraph: rand.nextInt(30) + 10,
        ),
        category: categories.elementAt(rand.nextInt(categories.length)),
        openingHours: '1',
      );
    });
    return Set.from(list);
  }
}
