import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';

class SignUpCategoriesPage extends StatefulWidget {
  const SignUpCategoriesPage({super.key});

  @override
  State<SignUpCategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<SignUpCategoriesPage> {
  String fontName = 'JosefinSans';
  Color startGradient = const Color.fromARGB(255, 83, 99, 60);
  Color finishGradient = const Color.fromARGB(255, 176, 209, 130);
  Color regularTextColor = const Color.fromARGB(1000, 58, 80, 44);
  late SignUpNextPage signUpNextPage;

  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        if (state is SignUpLoading) {
          return Column(
            children: [
              _buildSignUpHeader(),
              const LoadingIndicator(),
            ],
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
          return Align(
            child: SizedBox(
              width: screenWidth * 0.7,
              height: screenHeight * 0.8,
              child: Column(
                children: [
                  _buildSignUpHeader(),
                  Expanded(
                    child: _buildSignUpDropDownMenu(),
                  ),
                  _buildNextButton(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildSignUpHeader() {
    return Text(
      'Cadastro',
      style: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        fontFamily: fontName,
        foreground: Paint()
          ..shader = LinearGradient(
            colors: [
              startGradient,
              finishGradient,
            ],
          ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      ),
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            fontFamily: fontName,
            color: regularTextColor,
          ),
        ),
        const SizedBox(height: 8), // Espaço entre o texto e o menu suspenso
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

  Widget _buildNextButton() {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FilledButton(
        onPressed: () {},
        child: const Text(
          textScaler: TextScaler.linear(1.8),
          'Avançar',
        ),
      ),
    );
  }
}
