import 'package:flutter/material.dart';
import '/core/maps/domain/entities/marker.dart';

abstract class IMapsService {
  Widget buildMap(Set<Marker> markers);
}
