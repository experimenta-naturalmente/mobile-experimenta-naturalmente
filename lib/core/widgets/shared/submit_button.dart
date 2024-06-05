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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 200,
      ),
      child: SizedBox(
        height: 46,
        child: OutlinedButton(
          onPressed: onPressed,
          child: Text(
            text,
            textScaler: const TextScaler.linear(1.3),
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
