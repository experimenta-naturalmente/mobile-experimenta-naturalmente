import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../domain/i_maps_service.dart';
import '/core/maps/domain/entities/marker.dart' as m;

class GoogleMapsService implements IMapsService {
  Marker _createMarker(m.Marker marker) {
    return Marker(
      markerId: MarkerId(marker.id),
      position: LatLng(marker.lat, marker.lng),
      infoWindow: InfoWindow(title: marker.display),
    );
  }

  @override
  Widget buildMap(Set<m.Marker> markers) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-29.4418821, -50.595715),
        zoom: 14.0,
      ),
      markers: markers.map(_createMarker).toSet(),
    );
  }
}
