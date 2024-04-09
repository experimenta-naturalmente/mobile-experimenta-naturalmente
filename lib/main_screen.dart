import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/login.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
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
            label: 'Signup',
          ),
        ],
      ),
      body: [
        const ExperiencesScreen(),
        const ExperiencesScreen(),
        const ExperiencesScreen(),
        const ExperiencesScreen(),
        const LoginScreen(),
      ][currentPageIndex],
    );
  }
}
