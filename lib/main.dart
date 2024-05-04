import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/core/services/maps/cubits.dart';
import 'package:turismo_rural_frontend/core/services/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_bloc.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_event.dart';
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
        Provider<ITagRepository>(
          create: (context) => TagRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) {
              final experienceBloc = ExperienceBloc(
                experienceRepository: context.read<IExperienceRepository>(),
              );
              experienceBloc.add(LoadExperienceCategories());
              return experienceBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final spotBloc = SpotsBloc(
                experienceRepository: context.read<IExperienceRepository>(),
              );
              spotBloc.add(LoadSpotsCategories());
              return spotBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final signUpBloc = SignUpBloc(
                experienceRepository: context.read<IExperienceRepository>(),
                tagRepository: context.read<ITagRepository>(),
              );
              signUpBloc.add(LoadSignUp());
              return signUpBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final loginBloc = LoginBloc();
              return loginBloc;
            },
          ),
          BlocProvider(
            create: (context) {
              final homeBloc = HomeBloc(
                experienceRepository: context.read<IExperienceRepository>(),
              );
              homeBloc.add(HomeLoadData());
              return homeBloc;
            },
          ),
        ],
        child: MaterialApp(
          locale: const Locale('pt', 'BR'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
          title: 'São Chico Turismo',
          theme: _appThemes.lightTheme,
          home: MainScreen(),
        ),
      ),
    );
  }
}
