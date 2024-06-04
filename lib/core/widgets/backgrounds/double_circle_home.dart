import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoubleCircleHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const circleScale = 1.1;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              bottom: AppBar().preferredSize.height,
              right: 0,
              child: Transform.scale(
                scale: circleScale,
                child: SvgPicture.asset(
                  'assets/backgrounds/circle3.svg',
                  alignment: Alignment.bottomRight,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.4),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Transform.scale(
                scale: circleScale,
                child: SvgPicture.asset(
                  'assets/backgrounds/circle4.svg',
                  alignment: Alignment.topLeft,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.25),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
