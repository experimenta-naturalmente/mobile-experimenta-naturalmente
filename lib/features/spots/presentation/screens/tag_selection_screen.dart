import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/tag_widget.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/gradient_text.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_bloc.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/tag_selection_state.dart';
import 'package:turismo_rural_frontend/features/spots/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/spots/data/model/tag.dart';
import 'package:turismo_rural_frontend/features/spots/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

class TagSelectionScreen extends StatelessWidget {
  final ITagRepository tagRepository = TagRepository();

  TagSelectionScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        title: GradientText(
          text: 'Cadastro',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF53633C), Colors.green],
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => TagSelectionBloc(tagRepository: tagRepository)
          ..add(ToggleTagInitialization()),
        child: TagSelectionBody(),
      ),
    );
  }
}

class TagSelectionBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ExperienceCategory> sampleTagTypes = [
      const ExperienceCategory(id: 1, name: 'Restaurante'),
      const ExperienceCategory(id: 2, name: 'Hotel'),
      const ExperienceCategory(id: 3, name: 'Produtor rural'),
      const ExperienceCategory(id: 4, name: 'Atração turística'),
    ];

    // Tags de sample
    final List<Tag> sampleTags = [
      const Tag(
        id: 1,
        name: 'Comida Caseira',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 2,
        name: 'Gastronomia Local',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 3,
        name: 'Comida Internacional',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 4,
        name: 'Pet Friendly',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 5,
        name: 'Buffet Livre',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 6,
        name: 'Rodízio',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 7,
        name: 'Comida Japonesa',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 8,
        name: 'Vegano',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 9,
        name: 'Pizza',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 10,
        name: 'Fast-food',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 11,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 1, name: 'Restaurante'),
      ),
      const Tag(
        id: 6,
        name: 'Piscina',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 7,
        name: 'Café da Manhã Incluso',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 8,
        name: 'SPA',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 9,
        name: 'Academia',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 10,
        name: 'Estacionamento Gratuito',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 11,
        name: 'Ar-condicionado',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 12,
        name: 'Banheiro privativo',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 13,
        name: 'Wi-fi',
        type: ExperienceCategory(id: 2, name: 'Hotel'),
      ),
      const Tag(
        id: 11,
        name: 'Fazenda',
        type: ExperienceCategory(id: 3, name: 'Produtor rural'),
      ),
      const Tag(
        id: 12,
        name: 'Plantio Orgânico',
        type: ExperienceCategory(id: 3, name: 'Produtor rural'),
      ),
      const Tag(
        id: 13,
        name: 'Queijos Artesanais',
        type: ExperienceCategory(id: 3, name: 'Produtor rural'),
      ),
      const Tag(
        id: 14,
        name: 'Cervejaria Artesanal',
        type: ExperienceCategory(id: 3, name: 'Produtor rural'),
      ),
      const Tag(
        id: 15,
        name: 'Vinhedo',
        type: ExperienceCategory(id: 3, name: 'Produtor rural'),
      ),
      const Tag(
        id: 16,
        name: 'Museu',
        type: ExperienceCategory(id: 4, name: 'Atração turística'),
      ),
      const Tag(
        id: 17,
        name: 'Parque Natural',
        type: ExperienceCategory(id: 4, name: 'Atração turística'),
      ),
      const Tag(
        id: 18,
        name: 'Centro Histórico',
        type: ExperienceCategory(id: 4, name: 'Atração turística'),
      ),
      const Tag(
        id: 19,
        name: 'Mirante',
        type: ExperienceCategory(id: 4, name: 'Atração turística'),
      ),
      const Tag(
        id: 20,
        name: 'Aquário',
        type: ExperienceCategory(id: 4, name: 'Atração turística'),
      ),
    ];

    return BlocBuilder<TagSelectionBloc, TagSelectionState>(
      builder: (context, state) {
        return Stack(
          children: [
            DoubleCircle(), // Imagem de fundo
            SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Selecione algumas TAGs para o seu negócio:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF53633C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final tagType in sampleTagTypes) ...[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              tagType.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF53633C),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 16,
                              children: sampleTags
                                  .where((tag) => tag.type == tagType)
                                  .map((tag) {
                                final isSelected =
                                    state.selectedTags.contains(tag);
                                return TagWidget(
                                  tag: tag,
                                  tagType: tagType,
                                  fontSize: _calculateFontSize(tag.name),
                                  isSelected: isSelected,
                                  onPressed: () {
                                    context
                                        .read<TagSelectionBloc>()
                                        .add(ToggleTag(tag));
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 15,
                            ),
                          ),
                        ),
                        onPressed: () {
                          final state = context.read<TagSelectionBloc>().state;
                          if (state.selectedTags.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Avançar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateFontSize(String tagName) {
    if (tagName.length < 10) {
      return 16.0;
    } else if (tagName.length < 20) {
      return 14.0;
    } else {
      return 12.0;
    }
  }
}

// run with: flutter run --dart-define-from-file=.env
