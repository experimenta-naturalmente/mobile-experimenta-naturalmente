import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_initial_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // preferencialmente manter o tratamento de todos os estados direto no método de build,
  // evitar fazer tratamento de estado em outras widgets.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        if (state is LoginSubmitLoading) {
          return const LoadingIndicator();
        }
        if (state is LoginError) {
          return ErrorHandler(error: state.error, onRetry: () => {});
        }
        if (state is LoginInitial) {
          return Scaffold(
            body: Container(
              width: 500,
              margin: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ), //simular a appbar
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    _welcomeText(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    _discoverConnectShareText(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Form(
                      child: Column(
                        children: [
                          _usernameField(context),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          _passwordField(context, state.obscuredPassword),
                          _forgotPasswordButton(context),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          _loginButton(context),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _createAccountButton(context),
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

  Widget _welcomeText(BuildContext context) {
    return Text(
      "Olá, \nseja bem-vindo!",
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _discoverConnectShareText(BuildContext context) {
    return Text(
      "Descubra. Conecte. Divulgue.",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _usernameField(BuildContext context) {
    /// AJEITAAAAAA
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
          style:
              Theme.of(context).textTheme.bodyMedium, //não está na cor do figma
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity, // Largura total
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUpInitialPage(),
            ),
          );
        },
        child: const Text(
          'Entrar',
          textScaler: TextScaler.linear(1.2),
        ),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ainda não tem uma conta?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Cadastre-se aqui',
            style: Theme.of(context)
                .textTheme
                .bodyMedium, //não está na cor do figma
          ),
        ),
      ],
    );
  }
}
