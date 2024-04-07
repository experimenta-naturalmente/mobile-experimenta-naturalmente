import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    required this.text,
    this.isHeadline = false,
    super.key,
  });

  final String text;
  final bool isHeadline;

  @override
  Widget build(BuildContext context) {
    final r = Theme.of(context).colorScheme.primaryContainer.red;
    final g = Theme.of(context).colorScheme.primaryContainer.green;
    final b = Theme.of(context).colorScheme.primaryContainer.blue;
    final f1 = Theme.of(context).brightness == Brightness.light ? 0.45 : 1.5;
    final f2 = Theme.of(context).brightness == Brightness.light ? 0.75 : 2.4;
    final startGradient = Color.fromARGB(
      255,
      (r * f1).floor(),
      (g * f1).floor(),
      (b * f1).floor(),
    );
    final finishGradient = Color.fromARGB(
      255,
      (r * f2).floor(),
      (g * f2).floor(),
      (b * f2).floor(),
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          startGradient,
          finishGradient,
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: isHeadline
            ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.black,
                )
            : Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black,
                ),
      ),
    );
  }
}
