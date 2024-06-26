import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/bloc/experience_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';

class SignUpPageFinish extends StatelessWidget {
  const SignUpPageFinish({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeBloc>(context).add(HomeLoadData());
    Provider.of<ExperienceBloc>(context).add(LoadExperienceCategories());
    Provider.of<LoginBloc>(context).add(LoginLoadExperiences());
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.lime,
            size: 100,
          ),
          const SizedBox(height: 16),
          Text(
            'Cadastro concluído!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
