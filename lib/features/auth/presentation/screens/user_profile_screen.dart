import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_tabbar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        OverflowBox(child: DoubleCircle()),
        Column(
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              width: double.infinity,
              child: CircleAvatar(
                child: Image.asset('assets/logo/logo_small.png'),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: AlignmentDirectional.center,
              child: Text(
                'José Osvaldo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Expanded(
              child: ProfileTabbar(),
            ),
          ],
        ),
      ],
    );
  }
}
