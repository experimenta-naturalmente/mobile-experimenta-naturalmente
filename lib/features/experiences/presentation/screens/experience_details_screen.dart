import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_carousel_slider.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_tabbar.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  const ExperienceDetailsScreen();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        OverflowBox(child: DoubleCircle()),
        BlocBuilder<ExperienceBloc, ExperienceState>(
          builder: (context, state) {
            if (state is ExperienceDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            final experience =
                (state as ExperienceDetailsLoadedState).experience;
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text(
                    experience.name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: getFontSize(context, experience.name),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  child: ExperienceCarouselSlider(experience: experience),
                ),
                Expanded(child: ExperienceTabBar(experience: experience)),
                // child: const ExperienceTabBar(),
              ],
            );
          },
        ),
      ],
    );
  }

  double getFontSize(BuildContext context, String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (text.length < 20 || screenWidth > 800) {
      return Theme.of(context).textTheme.headlineMedium!.fontSize!;
    } else if (text.length < 30 || screenWidth > 600) {
      return Theme.of(context).textTheme.headlineSmall!.fontSize!;
    } else if (text.length < 40 || screenWidth > 400) {
      return Theme.of(context).textTheme.titleLarge!.fontSize!;
    }
    return Theme.of(context).textTheme.titleMedium!.fontSize!;
  }
}
