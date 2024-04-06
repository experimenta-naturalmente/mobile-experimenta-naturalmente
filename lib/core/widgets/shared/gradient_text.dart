import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    const Color startGradient = Color.fromARGB(255, 83, 99, 60);
    const Color finishGradient = Color.fromARGB(255, 176, 209, 130);

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          startGradient,
          finishGradient,
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
