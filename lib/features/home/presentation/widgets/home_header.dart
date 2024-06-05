import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        child: Image.asset('assets/logo/logo_small.png'),
      ),
      title: Text(
        'Turismo Rural',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        'São Francisco de Paula',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
