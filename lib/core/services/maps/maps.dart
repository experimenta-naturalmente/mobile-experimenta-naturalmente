import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/services/maps/models/marker.dart';

abstract class IMapsService {
   Future<Widget> buildMap(Set<MapMarker> markers);
}
