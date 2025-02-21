import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/config/themes.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';
import 'package:turismo_rural_frontend/core/services/file/file_service.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart'; // Se precisar, pode ser removido também
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/main_screen.dart';
import 'package:turismo_rural_frontend/core/data/repositories/route_repository.dart'; // Mantenha ou use mock

class MainApp extends StatelessWidget {
  final AppTheme _appThemes = AppTheme();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repositórios
        Provider<ExperienceRepository>(
          create: (_) =>
              ExperienceRepository(), // Adicione sua lógica de inicialização aqui
        ),
        Provider<RouteRepository>(
          create: (_) =>
              RouteRepository(), // Adicione sua lógica de inicialização aqui
        ),

        // Serviços
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
      ],
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => NavigationCubit(),
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
            // Adicionando o ExperienceBloc
            BlocProvider(
              create: (context) => ExperienceBloc(
                experienceRepository:
                    Provider.of<ExperienceRepository>(context, listen: false),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'São Chico Turismo',
            theme: _appThemes.lightTheme,
            home: MainScreen(), // A tela principal sem Firebase
          ),
        );
      },
    );
  }
}

void main() async {
  await dotenv.load();
  runApp(MainApp());
}
