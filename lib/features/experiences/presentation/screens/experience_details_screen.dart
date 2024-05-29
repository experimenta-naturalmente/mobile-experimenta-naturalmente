import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_state.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_carousel_slider.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_tabbar.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  const ExperienceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final state = context.read<ExperienceBloc>().state as ExperienceDetails;
    return Stack(
      children: [
        OverflowBox(child: DoubleCircle()),
        Column(
          children: [
            SizedBox(
              height: screenHeight * 0.15,
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                alignment: AlignmentDirectional.bottomStart,
                child: Text(
                  state.experienceListItem.name,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.3,
              width: double.infinity,
              child: const ExperienceCarouselSlider(),
            ),

            Expanded(
              child: ExperienceTabBar(
                experienceListItem: state.experienceListItem,
              ),
            ),
            // child: const ExperienceTabBar(),
          ],
        ),
      ],
    );
  }
}
