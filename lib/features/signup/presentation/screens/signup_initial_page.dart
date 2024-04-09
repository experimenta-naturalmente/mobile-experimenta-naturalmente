import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_form.dart';

class SignUpInitialPage extends StatefulWidget {
  const SignUpInitialPage({super.key});

  @override
  State<SignUpInitialPage> createState() => _SignUpInitialState();
}

class _SignUpInitialState extends State<SignUpInitialPage> {
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        if (state is SignUpLoading) {
          return const Drawer(
            child: Column(
              children: [
                GradientText(text: 'Cadastro'),
                LoadingIndicator(),
              ],
            ),
          );
        }
        if (state is SignUpError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () => context.read<SignUpBloc>().add(
                  LoadSignUp(),
                ),
          );
        }
        if (state is SignUpInitial) {
          return Drawer(
            child: Align(
              child: SizedBox(
                width: screenWidth * 0.7,
                height: screenHeight * 0.8,
                child: Column(
                  children: [
                    const GradientText(text: 'Cadastro'),
                    Expanded(
                      child: _buildSignUpDropDownMenu(),
                    ),
                    SubmitButton(
                      text: 'Avançar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpForm(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildSignUpDropDownMenu() {
    return Column(
      children: [
        const SizedBox(
          height: 70,
        ),
        Text(
          'O que você deseja cadastrar?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 32),
        DropdownMenu<String>(
          controller: categoryController,
          requestFocusOnTap: true,
          dropdownMenuEntries: const [
            DropdownMenuEntry<String>(
              label: 'Restaurante',
              value: '1',
            ),
            DropdownMenuEntry<String>(
              label: 'Hospedagem',
              value: '2',
            ),
            DropdownMenuEntry<String>(
              label: 'Produtor Rural',
              value: '3',
            ),
            DropdownMenuEntry<String>(
              label: 'Evento',
              value: '4',
            ),
          ],
          label: const Text('Selecione'),
          width: 160,
        ),
      ],
    );
  }
}
