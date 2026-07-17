import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChangePasswordEmailScreen();
  }
}

class ChangePasswordEmailScreen extends StatefulWidget {
  const ChangePasswordEmailScreen({super.key});

  @override
  State<ChangePasswordEmailScreen> createState() =>
      _ChangePasswordEmailScreenState();
}

class _ChangePasswordEmailScreenState extends State<ChangePasswordEmailScreen> {
  final _emailController = TextEditingController();
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    final email = firebase_auth.FirebaseAuth.instance.currentUser?.email;
    _emailController.text = email ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    final email = _emailController.text.trim();
    final authUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (email.isEmpty) {
      _show('Informe o email.');
      return;
    }

    if (authUser == null || authUser.email == null) {
      _show('Usuario nao autenticado.');
      return;
    }

    if (authUser.email != email) {
      _show('O email deve ser o mesmo da conta logada.');
      return;
    }

    final smtpUser = dotenv.env['SMTP_GMAIL_USER'];
    final smtpPass = dotenv.env['SMTP_GMAIL_APP_PASSWORD'];
    if (smtpUser == null || smtpPass == null) {
      _show('Configure SMTP_GMAIL_USER e SMTP_GMAIL_APP_PASSWORD no .env');
      return;
    }

    setState(() {
      _sending = true;
    });

    try {
      final random = Random();
      final sentCode = (100000 + random.nextInt(900000)).toString();

      final server = gmail(smtpUser, smtpPass);
      final message = Message()
        ..from = Address(smtpUser, 'Turismo Rural')
        ..recipients.add(email)
        ..subject = 'Codigo de confirmacao para troca de senha'
        ..text = 'Seu codigo de 6 digitos para troca de senha e: $sentCode';

      await send(message, server);

      if (!mounted) {
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangePasswordCodeScreen(
            email: email,
            expectedCode: sentCode,
          ),
        ),
      );
    } catch (_) {
      _show('Falha ao enviar codigo por email.');
    } finally {
      if (mounted) {
        setState(() {
          _sending = false;
        });
      }
    }
  }

  void _show(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trocar senha - 1/3')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sending ? null : _sendCode,
              child: _sending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Enviar codigo por email'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordCodeScreen extends StatefulWidget {
  final String email;
  final String expectedCode;

  const ChangePasswordCodeScreen({
    super.key,
    required this.email,
    required this.expectedCode,
  });

  @override
  State<ChangePasswordCodeScreen> createState() =>
      _ChangePasswordCodeScreenState();
}

class _ChangePasswordCodeScreenState extends State<ChangePasswordCodeScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _confirmCode() {
    final typed = _controllers.map((e) => e.text.trim()).join();
    if (typed.length != 6) {
      _show('Informe os 6 digitos.');
      return;
    }

    if (typed != widget.expectedCode) {
      _show('Codigo invalido.');
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangePasswordNewPasswordScreen(email: widget.email),
      ),
    );
  }

  void _show(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trocar senha - 2/3')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Digite o codigo de 6 digitos enviado para o email.'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 44,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmCode,
              child: const Text('Confirmar codigo'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordNewPasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordNewPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ChangePasswordNewPasswordScreen> createState() =>
      _ChangePasswordNewPasswordScreenState();
}

class _ChangePasswordNewPasswordScreenState
    extends State<ChangePasswordNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (_passwordController.text.length < 6) {
      _show('A senha deve ter pelo menos 6 caracteres.');
      return;
    }

    if (_passwordController.text != _confirmController.text) {
      _show('As senhas nao sao iguais.');
      return;
    }

    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser == null || currentUser.email != widget.email) {
      _show('Sessao invalida. Faca login novamente.');
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await currentUser.updatePassword(_passwordController.text);

      await firebase_auth.FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', false);

      if (!mounted) {
        return;
      }

      context.read<LoginBloc>().add(LoginClear());
      context.read<NavigationCubit>().navigateTo(appPage: AppPage.login);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha alterada com sucesso!')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _show('Por seguranca, faca login novamente e tente outra vez.');
      } else {
        _show('Falha ao alterar a senha.');
      }
    } catch (_) {
      _show('Falha ao alterar a senha.');
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  void _show(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trocar senha - 3/3')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nova senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar nova senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saving ? null : _changePassword,
              child: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Alterar senha'),
            ),
          ],
        ),
      ),
    );
  }
}
