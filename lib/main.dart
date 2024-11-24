import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/route_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';
import 'package:turismo_rural_frontend/core/services/file/file_service.dart';
import 'package:turismo_rural_frontend/core/services/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/firebase_options.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

void main() async {
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(MainApp(firestore: firestore));
}

class MainApp extends StatelessWidget {
  final FirebaseFirestore firestore;
  final AppTheme _appThemes = AppTheme();

  MainApp({super.key, required this.firestore});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMapsService>(
          create: (_) => GoogleMapsService(),
        ),
        Provider<AwsS3Service>(
          create: (_) {
            return AwsS3Service(
              accessKey: dotenv.env['AWS_ACCESS_KEY'] ?? '',
              secretKey: dotenv.env['AWS_SECRET_KEY'] ?? '',
              region: dotenv.env['AWS_REGION'] ?? '',
              bucketName: dotenv.env['AWS_BUCKET'] ?? '',
              destDir: 'uploads',
            );
          },
        ),
        Provider<TagRepository>(
          create: (_) => TagRepository(
            firestore: firestore,
          ),
        ),
        ProxyProvider2<AwsS3Service, TagRepository, ExperienceRepository>(
          update: (_, awsS3Service, tagRepository, __) => ExperienceRepository(
            awsS3Service: awsS3Service,
            firestore: firestore,
            tagRepository: tagRepository,
          ),
        ),
        Provider<FileService>(
          create: (_) => FileService(),
        ),
        Provider<RouteRepository>(
          create: (_) => RouteRepository(
            firestore: firestore,
          ),
        ),
      ],
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NavigationCubit(),
            ),
            BlocProvider(
              create: (context) => ExperienceBloc(
                experienceRepository:
                    Provider.of<ExperienceRepository>(context, listen: false),
              ),
            ),
            BlocProvider(
              create: (context) => RouteBloc(
                routeRepository:
                    Provider.of<RouteRepository>(context, listen: false),
              ),
            ),
            BlocProvider(
              create: (context) => HomeBloc(
                experienceRepository:
                    Provider.of<ExperienceRepository>(context, listen: false),
                routeRepository:
                    Provider.of<RouteRepository>(context, listen: false),
              )..add(HomeLoadData()),
            ),
          ],
          child: MaterialApp(
            title: 'São Chico Turismo',
            theme: _appThemes.lightTheme,
            home: MainScreen(),
          ),
        );
      },
    );
  }
}
