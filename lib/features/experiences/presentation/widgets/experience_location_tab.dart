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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: const Icon(Icons.near_me_outlined),
                ),
                const Text(
                  "Endereço",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Rua Moinho Velho, 817",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
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
        ],
      ),
    );
  }
}
