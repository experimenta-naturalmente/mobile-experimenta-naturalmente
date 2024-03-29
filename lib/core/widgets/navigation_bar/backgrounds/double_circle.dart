import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoubleCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.2,
        ),
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                width: screenWidth,
                child: Row(
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/backgrounds/circle2.svg',
                        alignment: Alignment.bottomLeft,
                        height: double.infinity,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor.withOpacity(0.35),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.4),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.55,
                child: SvgPicture.asset(
                  'assets/backgrounds/circle1.svg',
                  alignment: Alignment.topRight,
                  fit: BoxFit.fitHeight,
                  height: double.infinity,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
