import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/event_details.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_about.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/experience_location_tab.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/widgets/spot_details.dart';

class ExperienceTabBar extends StatelessWidget {
  final Experience experience;
  const ExperienceTabBar({super.key, required this.experience});

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Sobre o lugar'),
    Tab(text: 'Localização'),
    Tab(text: 'Detalhes'),
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
                ExperienceAbout(
                  experience: experience,
                ),
                ExperienceLocationTab(
                  experience: experience,
                ),
                if (experience is Event)
                  EventDetails(
                    event: experience as Event,
                  )
                else if (experience is Spot)
                  SpotDetails(
                    spot: experience as Spot,
                  )
                else
                  const Center(
                    child: Text('Tipo de experiência não suportado'),
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
