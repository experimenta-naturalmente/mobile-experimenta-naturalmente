import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/firestore_experience_repository.dart';
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
import 'package:turismo_rural_frontend/firebase_options.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          create: (_) => GoogleMapsService(),
        ),
        Provider<IExperienceRepository>(
          create: (_) =>
              FirestoreExperienceRepository(FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
          BlocProvider(
            create: (context) => ExperienceBloc(
              experienceRepository:
                  RepositoryProvider.of<IExperienceRepository>(context),
            )..add(LoadExperienceCategories()),
          ),
          BlocProvider(
            create: (context) => SpotsBloc(
              experienceRepository:
                  RepositoryProvider.of<IExperienceRepository>(context),
            )..add(LoadSpotsCategories()),
          ),
          BlocProvider(
            create: (context) => SignUpBloc(
              experienceRepository:
                  RepositoryProvider.of<IExperienceRepository>(context),
              tagRepository: TagRepository(),
            )..add(LoadSignUp()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              experienceRepository:
                  RepositoryProvider.of<IExperienceRepository>(context),
            )..add(HomeLoadData()),
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
