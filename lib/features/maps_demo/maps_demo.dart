import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/core/services/maps/models/marker.dart';

class MapsDemo extends StatelessWidget {
  const MapsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final IMapsService mapService =
        Provider.of<IMapsService>(context, listen: false);
    final Set<Marker> markers = <Marker>{
      Marker(
        id: 'ChIJmSj5GY_bGJURAEMs_vnDqi8',
        lat: -29.4513165,
        lng: -50.5698692,
        display: 'Parque das 8 Cascatas',
      ),
      Marker(
        id: 'ChIJ8dFblOvbGJURgllGNMxb980',
        lat: -29.4465135,
        lng: -50.5794128,
        display: 'Rissul',
      ),
    };

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 3,
            ),
          ),
          child: mapService.buildMap(markers),
        ),
      ),
    );
  }
}
