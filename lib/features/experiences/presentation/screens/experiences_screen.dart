import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_state.dart';

class ExperiencesScreen extends StatelessWidget {
  const ExperiencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<ExperienceBloc>()
        .add(const LoadExperiences(ExperienceType.attraction));

    return Stack(
      children: [
        Scaffold(
          body: Stack(
            children: [
              DoubleCircle(),
              BlocBuilder<ExperienceBloc, ExperienceState>(
                builder: (BuildContext context, ExperienceState state) {
                  if (state is ExperienceLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ExperienceLoadSuccess) {
                    return ListView.builder(
                      itemCount: state.experiences.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(state.experiences[index].name),
                          subtitle: Text(state.experiences[index].description),
                          onTap: () {},
                        );
                      },
                    );
                  } else if (state is ExperienceLoadError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
