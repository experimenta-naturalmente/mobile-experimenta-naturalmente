import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/screens/experience_screen.dart';
import 'package:turismo_rural_frontend/features/home/presentation/home.dart';

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
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Experience',
          ),
        ],
      ),
      body: const <Widget>[
        HomeScreen(title: "aaaaa"),
        ExperiencesScreen(),
      ][currentPageIndex],
    );
  }
}
