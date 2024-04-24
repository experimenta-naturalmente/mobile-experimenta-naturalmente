import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/services/maps/cubits.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/gradient_text.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/login.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_screen.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_handler.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationCubit>().state;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          navigatorReturn(context);
        }
      },
      child: Scaffold(
        appBar: _getAppBar(context, currentIndex),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            context.read<NavigationCubit>().navigateTo(index);
          },
          selectedIndex: currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Menu',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.grass_outlined)),
              label: 'Experiências',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.map_outlined)),
              label: 'Mapa',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.favorite_outline_outlined)),
              label: 'Favoritos',
            ),
            NavigationDestination(
              icon: Badge(child: Icon(Icons.person_outlined)),
              label: 'Perfil',
            ),
          ],
        ),
        body: [
          const ExperiencesScreen(),
          const ExperiencesScreen(),
          const ExperiencesScreen(),
          const SignUpHandler(),
          const LoginScreen(),
        ][currentIndex],
      ),
    );
  }

  void navigatorReturn(BuildContext context) {
    final currPage = context.read<NavigationCubit>().state;
    if (currPage == 0) {
      Navigator.pop(context);
    } else if (currPage == 3) {
      final bool onInitial =
          context.read<SignUpBloc>().state is SignUpPageInitialState;
      if (onInitial) {
        context.read<NavigationCubit>().navigateTo(0);
      } else {
        context.read<SignUpBloc>().add(const SignUpChangePage(previous: true));
      }
    } else {
      context.read<NavigationCubit>().navigateTo(0);
    }
  }

  PreferredSizeWidget? _getAppBar(BuildContext context, currPage) {
    switch (currPage) {
      case 3:
        return AppBar(
          centerTitle: true,
          title: const GradientText(text: "Cadastro"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigatorReturn(context);
            },
          ),
        );
      default:
        return null;
    }
  }
}
