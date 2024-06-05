import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExperienceLocationTab extends StatefulWidget {
  const ExperienceLocationTab({super.key});

  @override
  _ExperienceLocationTabState createState() => _ExperienceLocationTabState();
}

class _ExperienceLocationTabState extends State<ExperienceLocationTab> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-29.454732297364615, -50.561069918049974);

  // ignore: use_setters_to_change_properties
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.near_me_outlined),
                  ),
                  Text(
                    "Endereço",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Rua Moinho Velho, 817",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                height: screenHeight * 0.20,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('1'),
                      position: _center,
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
