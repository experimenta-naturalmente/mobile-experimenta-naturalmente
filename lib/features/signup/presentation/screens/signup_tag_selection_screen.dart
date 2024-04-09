import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/tag.dart';
import 'package:turismo_rural_frontend/features/experiences/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/tag_bloc/tag_selection_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/tag_bloc/tag_selection_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/tag_bloc/tag_selection_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_description.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/tag_selection_group.dart';

class TagSelectionScreen extends StatelessWidget {
  final ITagRepository tagRepository = TagRepository();
  TagSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagSelectionBloc, TagSelectionState>(
      builder: (context, state) {
        return Drawer(
          child: Stack(
            children: [
              DoubleCircle(),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.0),
                        child: GradientText(text: 'Cadastro'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36.0,
                          vertical: 18.0,
                        ),
                        child: Text(
                          'Selecione algumas TAGs para o seu negócio:',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          for (final category in state.availableTags.keys) ...[
                            _buildTagGroup(
                              context,
                              category,
                              state.availableTags[category] ?? {},
                              state.selectedTags,
                            ),
                            const SizedBox(height: 24),
                          ],
                          _getButton(context, state),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagGroup(
    BuildContext context,
    ExperienceCategory tagType,
    Set<Tag> tags,
    Map<int, bool> selectedTags,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            tagType.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        TagSelectionGroup(
          tags: tags,
          selectedTags: selectedTags,
          onSelected: (Tag tag) {
            context.read<TagSelectionBloc>().add(ToggleTag(tag));
          },
        ),
      ],
    );
  }

  Widget _getButton(BuildContext context, TagSelectionState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SubmitButton(
        text: 'Avançar',
        onPressed: () {
          final state = context.read<TagSelectionBloc>().state;
          if (state.selectedTags.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpDescription(),
              ),
            );
          }
        },
      ),
    );
  }
}
