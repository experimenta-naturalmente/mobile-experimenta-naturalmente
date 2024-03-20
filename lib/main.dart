import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/core/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/maps/maps.dart';
import 'package:turismo_rural_frontend/features/home/presentation/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<IMapsService>(
          create: (_) => GoogleMapsService(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter app',
        home: HomePage(
          title: 'Hello, world',
        ),
      ),
    );
  }
}
