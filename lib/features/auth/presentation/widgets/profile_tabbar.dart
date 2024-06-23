import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_details.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_my_business.dart';

class ProfileTabbar extends StatelessWidget {
  final User user;
  const ProfileTabbar({super.key, required this.user});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Informações'),
    Tab(text: 'Minhas Empresas'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Column(
        children: [
          const TabBar(
            tabs: myTabs,
          ),
          Expanded(
            child: TabBarView(
              children: [
                ProfileDetails(
                  user: user,
                ),
                const ProfileBusiness(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
