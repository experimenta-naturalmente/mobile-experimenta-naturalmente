import 'package:flutter/material.dart';

class FadedDivider extends StatelessWidget {
  final double width;

  const FadedDivider({this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Theme.of(context).dividerColor.withOpacity(0.25),
              Theme.of(context).dividerColor.withOpacity(0.25),
              Colors.transparent,
            ],
            stops: const [0.0, 0.2, 0.8, 1.0],
          ),
        ),
      ),
    );
  }
}
