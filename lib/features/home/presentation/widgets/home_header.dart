import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            width: 2.0,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          bottom: 2.0,
          top: 16.0,
          right: 8.0,
          left: 8.0,
        ),
        tileColor: Theme.of(context).colorScheme.surfaceContainerLow,
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
      ),
    );
  }
}
