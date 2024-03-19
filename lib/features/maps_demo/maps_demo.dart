import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/core/maps/domain/marker.dart';
import 'package:turismo_rural_frontend/core/maps/maps.dart';

class MapsDemo extends StatelessWidget {
  const MapsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final IMapsService mapService =
        Provider.of<IMapsService>(context, listen: false);
    Set<Marker> markers = <Marker>{
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Demo'),
      ),
      body: Container(
        child: mapService.buildMap(markers),
      ),
    );
  }
}
