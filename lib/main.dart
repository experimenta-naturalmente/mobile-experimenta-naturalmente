import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/repositories/user_repository.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';
import 'package:turismo_rural_frontend/core/services/file/file_service.dart';
import 'package:turismo_rural_frontend/core/services/maps/data/google_maps_api.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/main_screen.dart';

void main() async {
  await dotenv.load();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AppTheme _appThemes = AppTheme();
  final apiUrl = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    if (apiUrl == null) {
      throw Exception('API_URL not found in .env file');
    }
    final apiUri = Uri.parse(apiUrl!);
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
        ProxyProvider<AwsS3Service, ExperienceRepository>(
          update: (_, awsS3Service, __) => ExperienceRepository(
            awsS3Service: awsS3Service,
            apiUri: apiUri,
          ),
        ),
        Provider<TagRepository>(
          create: (_) => TagRepository(),
        ),
        Provider<FileService>(
          create: (_) => FileService(),
        ),
        Provider<UserRepository>(
          create: (_) => UserRepository(apiUri: apiUri),
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
              create: (context) => SignUpBloc(
                experienceRepository:
                    Provider.of<ExperienceRepository>(context, listen: false),
                tagRepository:
                    Provider.of<TagRepository>(context, listen: false),
              )..add(LoadSignUp()),
            ),
            BlocProvider(
              create: (context) => LoginBloc(
                userRepository:
                    Provider.of<UserRepository>(context, listen: false),
                experienceRepository: 
                    Provider.of<ExperienceRepository>(context, listen: false),
              ),
            ),
            BlocProvider(
              create: (context) => HomeBloc(
                experienceRepository:
                    Provider.of<ExperienceRepository>(context, listen: false),
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
        );
      },
    );
  }
}
