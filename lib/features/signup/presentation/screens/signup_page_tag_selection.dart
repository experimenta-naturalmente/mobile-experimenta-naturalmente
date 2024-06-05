import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/empty_list.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/widgets/tag_selection_group.dart';

class SignUpTagSelection extends StatelessWidget {
  final ITagRepository tagRepository = TagRepository();
  final SignUpPageTagSelectionState state;
  SignUpTagSelection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final filteredTags = context.read<SignUpBloc>().filteredTags;
    final selectedTags = state.selectedTags;
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 36.0,
            ),
            child: Text(
              'Selecione algumas tags para o seu negócio:',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            children: [
              _buildTagGroup(
                context,
                filteredTags.isNotEmpty
                    ? filteredTags.first.type.first.name
                    : '',
                filteredTags,
                selectedTags,
              ),
              const SizedBox(height: 36),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTagGroup(
    BuildContext context,
    String tagType,
    Set<Tag> tags,
    Map<int, bool> selectedTags,
  ) {
    if (tagType != '' && tags.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              tagType,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TagSelectionGroup(
            tags: tags,
            selectedTags: selectedTags,
            onSelected: (Tag tag) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpToggleTag(tag, selectedTags));
            },
          ),
        ],
      );
    } else {
      return EmptyList();
    }
  }
}
