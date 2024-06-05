import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        if (state is LoginSubmitLoading) {
          return const LoadingIndicator();
        }
        if (state is LoginError) {
          return ErrorHandler(error: state.error, onRetry: () => {});
        }
        if (state is LoginInitial) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.1,
                      left: screenWidth * 0.02,
                    ),
                    child: _welcomeText(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 12),
                    child: _discoverConnectShareText(context),
                  ),
                  Form(
                    child: Column(
                      children: [
                        _usernameField(context),
                        SizedBox(height: screenHeight * 0.01),
                        _passwordField(context, state.obscuredPassword),
                        _forgotPasswordButton(context),
                        SizedBox(height: screenHeight * 0.01),
                        SubmitButton(
                          text: 'Entrar',
                          onPressed: () => {
                            context
                                .read<NavigationCubit>()
                                .navigateTo(appPage: AppPage.register),
                          },
                        ),
                      ],
                    ),
                  ),
                  _createAccountButton(context),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Text(
      "Olá, \nseja bem-vindo!",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _discoverConnectShareText(BuildContext context) {
    return Text(
      "Descubra. Conecte. Divulgue.",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _usernameField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Usuário',
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _passwordField(BuildContext context, bool obscureText) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: 'Senha',
        filled: true,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () {
            context.read<LoginBloc>().add(LoginToggleObscuredText(obscureText));
          },
        ),
      ),
    );
  }

  Widget _forgotPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Esqueci minha senha',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Text(
            'Ainda não tem uma conta?',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Cadastre-se aqui',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
