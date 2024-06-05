import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/data/experience_registration.dart';

class SignUpPageInitial extends StatelessWidget {
  const SignUpPageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    final ExperienceRegistration registration =
        context.read<SignUpBloc>().registration;
    final categories = context.read<SignUpBloc>().categoriesCache;
    final screenWidth = MediaQuery.of(context).size.width;

    registration.category = registration.category ?? categories.first;

    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'O que você deseja cadastrar?',
            textAlign: TextAlign.center,
            softWrap: true,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          DropdownMenu<int>(
            initialSelection: registration.category?.id ?? categories.first.id,
            width: screenWidth * 0.7,
            textStyle: Theme.of(context).textTheme.titleLarge,
            onSelected: (value) => {
              registration.category =
                  categories.firstWhere((category) => category.id == value),
            },
            dropdownMenuEntries: categories
                .map(
                  (category) => DropdownMenuEntry(
                    value: category.id,
                    label: category.name,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
