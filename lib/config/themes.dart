import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.white;
  static const Color _lightHintColor = Colors.green;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _lightOnPrimaryColor,
    primaryColor: _lightPrimaryColor,
    hintColor: _lightHintColor,
    fontFamily: 'Josefin Sans',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Josefin Sans',
      ),
      displayMedium: TextStyle(fontSize: 28.0, fontFamily: 'Josefin Sans'),
      displaySmall: TextStyle(fontSize: 20.0, fontFamily: 'Josefin Sans'),
      bodyLarge: TextStyle(fontSize: 18.0, fontFamily: 'Lekton'),
      bodyMedium: TextStyle(fontSize: 16.0, fontFamily: 'Lekton'),
      bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'Lekton'),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(color: _lightPrimaryColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightPrimaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightHintColor),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: _lightPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(
      color: _lightPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: _lightPrimaryColor,
      unselectedLabelColor: Colors.grey,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(_lightOnPrimaryColor),
      fillColor: MaterialStateProperty.all(_lightPrimaryColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
  );
}
