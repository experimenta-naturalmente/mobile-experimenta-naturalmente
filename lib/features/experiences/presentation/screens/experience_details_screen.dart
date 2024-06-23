import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_carousel_slider.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_tabbar.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  final Experience experience;

  const ExperienceDetailsScreen({required this.experience});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        OverflowBox(child: DoubleCircle()),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: AlignmentDirectional.bottomStart,
              child: Text(
                experience.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.3,
              width: double.infinity,
              child: ExperienceCarouselSlider(
                experience: experience,
              ),
            ),

            Expanded(
              child: ExperienceTabBar(
                experience: experience,
              ),
            ),
            // child: const ExperienceTabBar(),
          ],
        ),
      ],
    );
  }
}
