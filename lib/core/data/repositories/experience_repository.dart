import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/opening_hours.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/address.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class ExperienceRepository implements IExperienceRepository {
  @override
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  ) async {
    // Simulando uma lista de experiências fictícias
    return {
      Spot(
        id: '1',
        type: ExperienceType.spot,
        cnpj: '12345678000123',
        name: 'Parque da Cachoeira',
        email: 'parquedacachoeira@hotmail.com',
        phone: '1234-5678',
        description:
            'Situado entre os rios Cará e Santa Cruz, junto a histórica “Ponte de Ferro”, local que antigamente era conhecido como “Passo do Inferno”, por onde as caravanas de viajantes atravessavam o rio Santa Cruz. O Parque abrange florestas nativas, campos, vales, animais silvestres, cursos de água e a magnífica cachoeira do rio Cará. Um local ideal para caminhadas, piqueniques e passeios junto à natureza.',
        category: category,
        socialNetworks: const ['facebook.com/ParqueDaCachoeira'],
        tags: {
          Tag(id: '1', name: 'Natureza', type: [category]),
        },
        attachments: {
          const Attachment(
            url:
                'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/7c/92/a9/entrada-pela-ponte-de.jpg?w=1400&h=1400&s=1',
          ),
        },
        address: const Address(
          street: 'Rua Exemplo',
          number: 10,
          zipCode: '90560030',
        ),
        openingHours: [
          OpeningHours(
            dayOfWeek: 'Segunda-feira',
            openingHour: '08:00',
            closingHour: '17:00',
          ),
        ],
      ),
      Event(
        details: 'evento legal em São Chico',
        eventStart: '21/02',
        eventEnd: '22/02',
        id: '2',
        type: ExperienceType.event,
        cnpj: '98765432000198',
        name: 'Lago São Bernardo',
        email: 'evento2@exemplo.com',
        phone: '8765-4321',
        description: 'Descrição do Evento 2',
        category: category,
        socialNetworks: const ['twitter.com/evento2'],
        tags: {
          Tag(id: '2', name: 'Cultura', type: [category]),
        },
        attachments: {
          const Attachment(
            url:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-PSmnE775bruXl5cxiSSOnHXQGHDx3sGdrg&s',
          ),
        },
        address: const Address(
          street: 'Rua Exemplo 2',
          number: 1,
          zipCode: '9000000',
        ),
      ),
    };
  }

  @override
  Future<Set<ExperienceCategory>> fetchExperienceCategories() async {
    // Simulando categorias de experiência fictícias
    return {
      const ExperienceCategory(id: '1', name: 'Aventura'),
      const ExperienceCategory(id: '2', name: 'Relaxamento'),
    };
  }

  @override
  Future<Set<Experience>> fetchFeaturedExperiences() async {
    // Retornando as experiências fictícias
    return {
      Spot(
        id: '1',
        type: ExperienceType.spot,
        cnpj: '12345678000123',
        name: 'Rafting em Cachoeira',
        email: 'montanhas@exemplo.com',
        phone: '1234-5678',
        description:
            'O percurso é de aproximadamente 04 quilometros, realizado em tempo média de 1:30h, a duração do passeio pode variar conforme o volume de água do rio, baixo, normal ou cheio. Durante a descida ocorrem paradas para aproveitar as piscinas naturais, que o rio proporciona',
        category: const ExperienceCategory(id: '1', name: 'Aventura'),
        socialNetworks: const ['facebook.com/spot1'],
        tags: {
          const Tag(
            id: '1',
            name: 'Aventura',
            type: [ExperienceCategory(id: '1', name: 'Aventura')],
          ),
        },
        attachments: {
          const Attachment(
            url:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMI8Npe7IgJaV5vdDEdr23FtOtie9L-m5saA&s',
          ),
        },
        address: const Address(
          street: 'Rua das Montanhas',
          number: 390,
          zipCode: '1111112',
        ),
        openingHours: [
          OpeningHours(
            dayOfWeek: 'Segunda-feira',
            openingHour: '08:00',
            closingHour: '17:00',
          ),
        ],
      ),
    };
  }

  @override
  Future<Spot?> fetchExperienceById(String id) async {
    // Simulando um spot específico
    return Spot(
      id: id,
      type: ExperienceType.spot,
      cnpj: '12345678000123',
      name: 'Cachoeira',
      email: 'spot@exemplo.com',
      phone: '1234-5678',
      description: 'Descrição do spot',
      category: const ExperienceCategory(id: '1', name: 'Aventura'),
      socialNetworks: const ['instagram.com/spot'],
      tags: {
        const Tag(
          id: '1',
          name: 'Natureza',
          type: [ExperienceCategory(id: '1', name: 'Aventura')],
        ),
      },
      attachments: {
        const Attachment(
          url:
              'https://gramadoreceptivo.com.br/images/produto/cidade/fotos/cidade-6/saochico-cascata.jpg',
        ),
      },
      address:
          const Address(street: 'Rua do Spot', number: 81, zipCode: '11111111'),
      openingHours: [
        OpeningHours(
          dayOfWeek: 'Segunda-feira',
          openingHour: '08:00',
          closingHour: '17:00',
        ),
        OpeningHours(
          dayOfWeek: 'Terça-feira',
          openingHour: '08:00',
          closingHour: '17:00',
        ),
      ],
    );
  }

  @override
  Future<String?> uploadImage(XFile file, Function(int) onProgress) async {
    // Simulando o upload de imagem
    return 'mocked-upload-url';
  }
}
