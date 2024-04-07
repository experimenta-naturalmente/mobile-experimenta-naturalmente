import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/empty_list.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_category_tabview.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_list_item_widget.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});
  // preferencialmente manter o tratamento de todos os estados direto no método de build,
  // evitar fazer tratamento de estado em outras widgets.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (BuildContext context, ExperienceState state) {
        if (state is ExperienceCategoriesLoading) {
          return const LoadingIndicator();
        }
        if (state is ExperienceError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () => context.read<ExperienceBloc>().add(
                  LoadExperienceCategories(),
                ),
          );
        }
        if (state is ExperienceListLoading) {
          return Stack(
            children: [
              OverflowBox(child: DoubleCircle()),
              Column(
                children: [
                  _buildExperienceListHeader(
                    state.categories,
                    state.selectedCategory,
                    context,
                  ),
                  const LoadingIndicator(),
                ],
              ),
            ],
          );
        }
        // testar com "is" faz com o que o dart faça type promote (eg ExperienceState -> ExperienceListLoadSuccess),
        // por isso nao precisa de nenhum cast pra acessar as propriedades que tem dentro de alguns estados
        if (state is ExperienceListLoadSuccess) {
          return Stack(
            children: [
              DoubleCircle(),
              Column(
                children: [
                  _buildExperienceListHeader(
                    state.categories,
                    state.selectedCategory,
                    context,
                  ),
                  Expanded(
                    child: _buildExperiencesList(state.experiences),
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildExperienceListHeader(
    Set<ExperienceCategory> tabs,
    ExperienceCategory selectedCategory,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 36, left: 16, right: 16),
      child: Column(
        children: [
          const SearchBar(
            leading: Icon(
              Icons.search,
            ),
            hintText: 'O que você deseja buscar?',
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ExperienceCategoryTabView(
              tabs: tabs,
              selectedCategory: selectedCategory,
              onCategorySelected: (category) {
                context.read<ExperienceBloc>().add(
                      ExperienceCategoryChanged(category, tabs),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperiencesList(Set<ExperienceListItem> experiences) {
    if (experiences.isEmpty) {
      return EmptyList();
    }
    return ListView.builder(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      itemCount: experiences.length,
      itemBuilder: (BuildContext context, int index) {
        return ExperienceListItemWidget(
          experience: experiences.elementAt(index),
          onTap: () => {
            context.read<ExperienceBloc>().add(
                  ExperienceSelected(experiences.elementAt(index)),
                ),
          },
        );
      },
    );
  }
}
