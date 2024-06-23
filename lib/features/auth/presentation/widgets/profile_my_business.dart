import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/business_card.dart';

class ProfileBusiness extends StatelessWidget {
  const ProfileBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginBloc>().state as LoginSubmitSucess;
    final spotsBusiness = state.spotsBusiness;

    if (spotsBusiness.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Você não possui Empresas!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Caso você tenha alguma empresa ou atração em São Francisco de Paula, basta clicar no botão de Cadastrar Empresa abaixo!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  // Ação para cadastrar empresa
                },
                child: Text(
                  '+ Cadastrar Experiência',
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: spotsBusiness.length,
        itemBuilder: (context, index) {
          final spot = spotsBusiness.elementAt(index);
          return BusinessCard(
            imageUrl: spot.image!,
            name: spot.name,
            cnpj: spot.cnpj,
            onTap: () => {
              context.read<NavigationCubit>().navigateTo(
                    appPage: AppPage.experiences,
                    experience: spotsBusiness.elementAt(index),
                  ),
            }, // Ajuste para a data de criação correta
          );
        },
      );
    }
  }
}
