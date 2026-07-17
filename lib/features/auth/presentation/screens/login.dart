import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/user_profile_screen.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is LoginSubmitError) {
            _showErrorDialog(context, state.error, passwordController);
          }
          if (state is ProfileState) {
            await _saveLogin();
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
            if (state is ProfileState) {
              return UserProfileScreen(user: state.user);
            }
            if (state is LoginSubmitLoading) {
              return Stack(
                children: [
                  _buildLoginPage(
                    context,
                    usernameController,
                    passwordController,
                    true,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: ColoredBox(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  const LoadingIndicator(),
                ],
              );
            }
            var obscuredPassword = true;
            if (state is LoginInitial) {
              obscuredPassword = state.obscuredPassword;
            }
            return _buildLoginPage(
              context,
              usernameController,
              passwordController,
              obscuredPassword,
            );
          },
        ),
      ),
    );
  }

  void _showErrorDialog(
    BuildContext context,
    String error,
    TextEditingController passwordController,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Erro',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Falha na autenticação!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              passwordController.clear();
              Navigator.of(context).pop();
              context.read<LoginBloc>().add(LoginClear());
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPage(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController,
    bool obscuredPassword,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.1,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
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
                    _usernameField(
                      context,
                      usernameController,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    _passwordField(
                      context,
                      obscuredPassword,
                      passwordController,
                    ),
                    _forgotPasswordButton(context),
                    SizedBox(height: screenHeight * 0.01),
                    SubmitButton(
                      text: 'Entrar',
                      onPressed: () => {
                        context.read<LoginBloc>().add(
                              LoginSubmit(
                                usernameController.text,
                                passwordController.text,
                              ),
                            ),
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildSignupLink(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            ),
          );
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: 'Ainda não tem uma conta?\n',
              ),
              TextSpan(
                text: 'Cadastre-se aqui',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget _usernameField(
    BuildContext context,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _passwordField(
    BuildContext context,
    bool obscureText,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
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
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Esqueci minha senha',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
  /* Widget _createAccountButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
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
  } */
}
