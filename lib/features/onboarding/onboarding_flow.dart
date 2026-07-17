import 'package:flutter/material.dart';

import 'welcome_screen.dart';
import 'info_screen.dart';
import 'preferences_screen.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentPage = 0;
  final int _totalPages = 3;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  Future<void> _savePreferences(List<String> preferences) async {
    // TODO: Salvar preferências do usuário no banco de dados
    // Exemplo: await context.read<UserRepository>().savePreferences(preferences);
    // Após salvar, navegue para a tela principal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if (_currentPage == 0) {
      page = WelcomeScreen(
        onNext: _nextPage,
        currentPage: _currentPage,
        totalPages: _totalPages,
      );
    } else if (_currentPage == 1) {
      page = InfoScreen(
        onNext: _nextPage,
        onBack: () => setState(() => _currentPage--),
        currentPage: _currentPage,
        totalPages: _totalPages,
      );
    } else if (_currentPage == 2) {
      page = PreferencesScreen(
        onBack: () => setState(() => _currentPage--),
        currentPage: _currentPage,
        totalPages: _totalPages,
        onFinish: _savePreferences,
      );
    } else {
      page = Container();
    }
    return page;
  }
}
