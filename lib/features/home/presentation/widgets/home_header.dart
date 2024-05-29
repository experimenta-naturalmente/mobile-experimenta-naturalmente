import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Image.asset('assets/logo/logo.png'),
      ),
      title: const Text(
        'Turismo Rural',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        'São Francisco de Paula',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
