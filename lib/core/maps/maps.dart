import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/maps/domain/marker.dart';

abstract class IMapsService {
  Widget buildMap(Set<Marker> markers);
}
