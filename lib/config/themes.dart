import 'package:flutter/material.dart';

class AppTheme {
  final searchBarTheme = SearchBarThemeData(
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    padding: MaterialStateProperty.all(
      const EdgeInsets.only(left: 16),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  final chipTheme = ChipThemeData(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    showCheckmark: false,
  );
  ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
        ),
        textTheme: Typography.blackCupertino.apply(
          fontFamily: 'JosefinSans',
        ),
        chipTheme: chipTheme,
        searchBarTheme: searchBarTheme,
      );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        textTheme: Typography.whiteCupertino.apply(
          fontFamily: 'JosefinSans',
        ),
        chipTheme: chipTheme,
        searchBarTheme: searchBarTheme,
      );
}
