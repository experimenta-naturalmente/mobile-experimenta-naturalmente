import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/empty_list.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_category_tabview.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_widget.dart';

class ExperienceListScreen extends StatelessWidget {
  const ExperienceListScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceBloc, ExperienceState>(
      builder: (BuildContext context, ExperienceState state) {
        if (state is ExperienceInitialState) {
          context.read<ExperienceBloc>().add(LoadExperienceCategories());
        }
        if (state is ExperienceCategoriesLoadingState) {
          return const LoadingIndicator();
        }
        if (state is ExperienceListLoadingState) {
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
                  const LoadingIndicator(),
                ],
              ),
            ],
          );
        }
        if (state is ExperienceListLoadSuccessState) {
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
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
      child: Column(
        children: [
          const SearchBar(
            leading: Icon(Icons.search),
            hintText: 'O que você deseja buscar?',
          ),
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

  Widget _buildExperiencesList(Set<Experience> experiences) {
    if (experiences.isEmpty) {
      return SizedBox(width: double.infinity, child: EmptyList());
    }
    return ListView.builder(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      itemCount: experiences.length,
      itemBuilder: (BuildContext context, int index) {
        return ExperienceWidget(
          experience: experiences.elementAt(index),
          onTap: () => {
            context.read<NavigationCubit>().navigateTo(
                  appPage: AppPage.experiences,
                  item: experiences.elementAt(index),
                ),
          },
        );
      },
    );
  }
}
