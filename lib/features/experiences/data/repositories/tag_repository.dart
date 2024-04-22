import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/tag.dart';

class TagRepository implements ITagRepository {
  @override
  Future<Set<Tag>> fetchAllTags() async {
    // Simulando a busca de todas as tags
    await Future.delayed(const Duration(milliseconds: 250));
    return {
      const Tag(
        id: 30,
        name: 'Meia Entrada',
        type: ExperienceCategory(id: 6, name: 'Evento'),
      ),
      const Tag(
        id: 29,
        name: 'Comida Caseira',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 28,
        name: 'Gastronomia Local',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 27,
        name: 'Comida Internacional',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 26,
        name: 'Pet Friendly',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 25,
        name: 'Buffet Livre',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 24,
        name: 'Rodízio',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 23,
        name: 'Comida Japonesa',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 22,
        name: 'Vegano',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 21,
        name: 'Pizza',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 20,
        name: 'Fast-food',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 19,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 18,
        name: 'Piscina',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 17,
        name: 'Café da Manhã Incluso',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 16,
        name: 'SPA',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 15,
        name: 'Academia',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 14,
        name: 'Estacionamento Gratuito',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 13,
        name: 'Ar-condicionado',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 12,
        name: 'Banheiro privativo',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 11,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 10,
        name: 'Fazenda',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 9,
        name: 'Plantio Orgânico',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 8,
        name: 'Queijos Artesanais',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 7,
        name: 'Cervejaria Artesanal',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 6,
        name: 'Vinhedo',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 5,
        name: 'Museu',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 4,
        name: 'Parque Natural',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 3,
        name: 'Centro Histórico',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 2,
        name: 'Mirante',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 1,
        name: 'Aquário',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
    };
  }

  @override
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    // Simulando a busca de tags de uma categoria específica
    await Future.delayed(const Duration(milliseconds: 250));
    return {
      const Tag(
        id: 29,
        name: 'Comida Caseira',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 28,
        name: 'Gastronomia Local',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 27,
        name: 'Comida Internacional',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 26,
        name: 'Pet Friendly',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 25,
        name: 'Buffet Livre',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 24,
        name: 'Rodízio',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 23,
        name: 'Comida Japonesa',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 22,
        name: 'Vegano',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 21,
        name: 'Pizza',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 20,
        name: 'Fast-food',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 19,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 2, name: 'Restaurante'),
      ),
      const Tag(
        id: 18,
        name: 'Piscina',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 17,
        name: 'Café da Manhã Incluso',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 16,
        name: 'SPA',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 15,
        name: 'Academia',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 14,
        name: 'Estacionamento Gratuito',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 13,
        name: 'Ar-condicionado',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 12,
        name: 'Banheiro privativo',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 11,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 1, name: 'Hotel'),
      ),
      const Tag(
        id: 10,
        name: 'Fazenda',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 9,
        name: 'Plantio Orgânico',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 8,
        name: 'Queijos Artesanais',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 7,
        name: 'Cervejaria Artesanal',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 6,
        name: 'Vinhedo',
        type: ExperienceCategory(id: 4, name: 'Produtor rural'),
      ),
      const Tag(
        id: 5,
        name: 'Museu',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 4,
        name: 'Parque Natural',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 3,
        name: 'Centro Histórico',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 2,
        name: 'Mirante',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
      const Tag(
        id: 1,
        name: 'Aquário',
        type: ExperienceCategory(id: 5, name: 'Atração turística'),
      ),
    };
  }
}
