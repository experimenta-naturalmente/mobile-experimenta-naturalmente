import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final brightTheme = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      height: 65,
      width: screenWidth * 0.6,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return brightTheme ? Colors.grey[400] : Colors.grey[800];
            }
            return Theme.of(context).colorScheme.secondary;
          }),
        ),
        child: Text(
          text,
          textScaler: const TextScaler.linear(2),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: MaterialStateColor.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Theme.of(context).disabledColor;
                    }
                    return Theme.of(context).colorScheme.onSecondary;
                  },
                ),
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
