import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/business_card.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';

class ProfileBusiness extends StatelessWidget {
  final Set<Spot> spotsBusiness;

  const ProfileBusiness({super.key, required this.spotsBusiness});

  @override
  Widget build(BuildContext context) {
    return spotsBusiness.isEmpty
        ? _buildEmptyState(context)
        : _buildSpotsList(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Você não possui cadastros!",
            style: screenHeight > 700
                ? Theme.of(context).textTheme.headlineMedium
                : Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              "Caso você tenha alguma empresa ou atração em São Francisco de Paula, basta clicar no botão de Cadastrar Experiência abaixo!",
              textAlign: TextAlign.center,
              style: screenWidth > 800
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 12),
          _buildAddBusinessButton(context),
        ],
      ),
    );
  }

  Widget _buildSpotsList(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          alignment: orientation == Orientation.portrait
              ? Alignment.center
              : Alignment.centerRight,
          padding: EdgeInsets.only(
            bottom: 4,
            top: 4,
            right: orientation == Orientation.portrait ? 0 : 16,
          ),
          child: _buildAddBusinessButton(context),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: spotsBusiness.length,
            itemBuilder: (context, index) {
              final spot = spotsBusiness.elementAt(index);
              return BusinessCard(
                imageUrl: spot.attachments.firstOrNull,
                name: spot.name,
                cnpj: spot.cnpj,
                onTap: () {
                  context.read<NavigationCubit>().navigateTo(
                        appPage: AppPage.experiences,
                        item: spotsBusiness.elementAt(index),
                      );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddBusinessButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () {
        context.read<SignUpBloc>().add(LoadSignUp());
        context.read<NavigationCubit>().navigateTo(appPage: AppPage.register);
      },
      child: const Text(
        'Cadastrar Experiência',
      ),
    );
  }
}
