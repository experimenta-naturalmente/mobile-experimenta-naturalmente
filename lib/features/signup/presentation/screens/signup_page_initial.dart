import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/data/models/experience_registration.dart';

class SignUpPageInitial extends StatelessWidget {
  const SignUpPageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    final ExperienceRegistration registration =
        context.read<SignUpBloc>().registration;
    final categories = context.read<SignUpBloc>().categoriesCache;
    final screenWidth = MediaQuery.of(context).size.width;
    return Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenWidth * 0.8,
            child: Text(
              'O que você deseja cadastrar?',
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 24),
          DropdownMenu<ExperienceCategory>(
            initialSelection: registration.category ?? categories.first,
            width: screenWidth * 0.7,
            textStyle: Theme.of(context).textTheme.titleLarge,
            onSelected: (value) => {
              registration.category = value,
            },
            dropdownMenuEntries: categories
                .map(
                  (category) => DropdownMenuEntry(
                    value: category,
                    label: category.name,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
