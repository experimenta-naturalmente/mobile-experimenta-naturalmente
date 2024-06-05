import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_carousel_slider.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_tabbar.dart';

class ExperienceDetailsScreen extends StatelessWidget {
  final ExperienceListItem experience;

  const ExperienceDetailsScreen({required this.experience});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  experience.name,
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
                experienceListItem: experience,
              ),
            ),
            // child: const ExperienceTabBar(),
          ],
        ),
      ],
    );
  }
}
