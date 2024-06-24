import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class TagRepository implements ITagRepository {
  @override
  Future<Set<Tag>> fetchAllTags() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return {
      const Tag(
        tagId: 30,
        name: 'Meia Entrada',
        type: [ExperienceCategory(categoryId: 6, name: 'Evento')],
      ),
      const Tag(
        tagId: 29,
        name: 'Comida Caseira',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 28,
        name: 'Gastronomia Local',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 27,
        name: 'Comida Internacional',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 26,
        name: 'Pet Friendly',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 25,
        name: 'Buffet Livre',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 24,
        name: 'Rodízio',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 23,
        name: 'Comida Japonesa',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 22,
        name: 'Vegano',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 21,
        name: 'Pizza',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 20,
        name: 'Fast-food',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 19,
        name: 'Wi-fi',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 18,
        name: 'Piscina',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 17,
        name: 'Café da Manhã Incluso',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 16,
        name: 'SPA',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 15,
        name: 'Academia',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 14,
        name: 'Estacionamento Gratuito',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 13,
        name: 'Ar-condicionado',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 12,
        name: 'Banheiro privativo',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 11,
        name: 'Wi-fi',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 10,
        name: 'Fazenda',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 9,
        name: 'Plantio Orgânico',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 8,
        name: 'Queijos Artesanais',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 7,
        name: 'Cervejaria Artesanal',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 6,
        name: 'Vinhedo',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 5,
        name: 'Museu',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 4,
        name: 'Parque Natural',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 3,
        name: 'Centro Histórico',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 2,
        name: 'Mirante',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 1,
        name: 'Aquário',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
    };
  }

  @override
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    // Simulando a busca de tags de uma categoria específica
    await Future.delayed(const Duration(milliseconds: 250));
    return {
      const Tag(
        tagId: 29,
        name: 'Comida Caseira',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 28,
        name: 'Gastronomia Local',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 27,
        name: 'Comida Internacional',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 26,
        name: 'Pet Friendly',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 25,
        name: 'Buffet Livre',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 24,
        name: 'Rodízio',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 23,
        name: 'Comida Japonesa',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 22,
        name: 'Vegano',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 21,
        name: 'Pizza',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 20,
        name: 'Fast-food',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 19,
        name: 'Wi-fi',
        type: [ExperienceCategory(categoryId: 2, name: 'Restaurante')],
      ),
      const Tag(
        tagId: 18,
        name: 'Piscina',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 17,
        name: 'Café da Manhã Incluso',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 16,
        name: 'SPA',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 15,
        name: 'Academia',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 14,
        name: 'Estacionamento Gratuito',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 13,
        name: 'Ar-condicionado',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 12,
        name: 'Banheiro privativo',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 11,
        name: 'Wi-fi',
        type: [ExperienceCategory(categoryId: 1, name: 'Hotel')],
      ),
      const Tag(
        tagId: 10,
        name: 'Fazenda',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 9,
        name: 'Plantio Orgânico',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 8,
        name: 'Queijos Artesanais',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 7,
        name: 'Cervejaria Artesanal',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 6,
        name: 'Vinhedo',
        type: [ExperienceCategory(categoryId: 4, name: 'Produtor rural')],
      ),
      const Tag(
        tagId: 5,
        name: 'Museu',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 4,
        name: 'Parque Natural',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 3,
        name: 'Centro Histórico',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 2,
        name: 'Mirante',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
      const Tag(
        tagId: 1,
        name: 'Aquário',
        type: [ExperienceCategory(categoryId: 5, name: 'Atração turística')],
      ),
    };
  }
}
