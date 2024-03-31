import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/services/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/features/experiences/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AppTheme _appThemes = AppTheme();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMapsService>(
          create: (context) => GoogleMapsService(),
        ),
        Provider<IExperienceRepository>(
          create: (context) => ExperienceRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) {
          final experienceBloc = ExperienceBloc(
            experienceRepository: context.read<IExperienceRepository>(),
          );
          experienceBloc.add(LoadExperienceCategories());
          return experienceBloc;
        },
        child: MaterialApp(
          title: 'São Chico Turismo',
          theme: _appThemes.lightTheme,
          home: const MainScreen(),
        ),
      ),
    );
  }
}
