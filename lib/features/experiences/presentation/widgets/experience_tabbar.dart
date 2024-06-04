import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/event_details.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_about.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_location_tab.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/spot_details.dart';

class ExperienceTabBar extends StatelessWidget {
  final ExperienceListItem experienceListItem;
  const ExperienceTabBar({super.key, required this.experienceListItem});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Sobre o lugar'),
    Tab(text: 'Localização'),
    Tab(text: 'Detalhes'),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                ExperienceAbout(
                  experienceListItem: experienceListItem,
                ),
                const ExperienceLocationTab(),
                if (experienceListItem.category.name == "Evento")
                  EventDetails(
                    experienceListItem: experienceListItem,
                  )
                else
                  SpotDetails(
                    experienceListItem: experienceListItem,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // TODO: implement createState
}
