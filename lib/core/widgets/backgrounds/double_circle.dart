import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoubleCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.3,
          ),
          SizedBox(
            height: screenHeight,
            child: Stack(
              children: [
                OverflowBox(
                  child: SizedBox(
                    width: screenWidth,
                    child: Row(
                      children: [
                        Expanded(
                          child: SvgPicture.asset(
                            'assets/backgrounds/circle2.svg',
                            alignment: Alignment.bottomLeft,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                                  .withOpacity(0.8),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.2),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: SvgPicture.asset(
                    'assets/backgrounds/circle1.svg',
                    alignment: Alignment.topRight,
                    fit: BoxFit.fitHeight,
                    height: double.infinity,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.4),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
