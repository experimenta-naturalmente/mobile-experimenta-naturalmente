import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_details_screen.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_list_screen.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: BlocBuilder<ExperienceBloc, ExperienceState>(
        builder: (BuildContext context, ExperienceState state) {
          if (state is ExperienceErrorState) {
            return ErrorHandler(
              error: state.error,
              onRetry: () => context.read<ExperienceBloc>().add(
                    LoadExperienceCategories(),
                  ),
            );
          }
          if (state is ExperienceListState) {
            return const ExperienceListScreen();
          }
          if (state is ExperienceDetailsState) {
            return const ExperienceDetailsScreen();
          }
          return Container();
        },
      ),
    );
  }
}
