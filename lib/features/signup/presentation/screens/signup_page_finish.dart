import 'package:flutter/material.dart';

class SignUpPageFinish extends StatelessWidget {
  const SignUpPageFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.lime,
            size: 100,
          ),
          const SizedBox(height: 16),
          Text(
            'Cadastro concluído!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
