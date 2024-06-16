import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_details.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_location_tab.dart';

class ProfileTabbar extends StatelessWidget {
  const ProfileTabbar({super.key});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Informações'),
    Tab(text: 'Minhas Empresas'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: const Column(
        children: [
          TabBar(
            tabs: myTabs,
          ),
          Expanded(
            child: TabBarView(
              children: [
                ProfileDetails(),
                ExperienceLocationTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
