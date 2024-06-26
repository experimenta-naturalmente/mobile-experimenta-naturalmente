import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/core/services/maps/models/marker.dart'
    as m;

class GoogleMapsService implements IMapsService {
  Marker _createMarker(m.MapMarker marker) {
    return Marker(
      markerId: MarkerId(marker.id),
      position: LatLng(marker.lat, marker.lng),
      infoWindow: InfoWindow(title: marker.display),
    );
  }

  @override
  Future<Widget> buildMap(Set<m.MapMarker> markers) async {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-29.454732297364615, -50.561069918049974),
        zoom: 16.0,
      ),
      markers: markers.map(_createMarker).toSet(),
    );
  }
}
