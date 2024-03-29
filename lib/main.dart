import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/services/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/features/attractions/data/interfaces/i_attraction_repository.dart';
import 'package:turismo_rural_frontend/features/attractions/data/repositories/attraction_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experiences_bloc.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMapsService>(
          create: (context) => GoogleMapsService(),
        ),
        Provider<IAttractionRepository>(
          create: (context) => AttractionRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => ExperienceBloc(
          attractionRepository: context.read<IAttractionRepository>(),
        ),
        child: MaterialApp(
          title: 'São Chico Turismo',
          theme: AppTheme.lightTheme,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
