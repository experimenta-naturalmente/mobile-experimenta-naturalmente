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

  final _lightTypography = Typography.blackCupertino.apply(
    fontFamily: 'JosefinSans',
  );
  ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
        ),
        textTheme: _lightTypography.copyWith(
          bodySmall:
              _lightTypography.bodySmall!.copyWith(fontFamily: 'JosefinSans'),
          bodyMedium:
              _lightTypography.bodyMedium!.copyWith(fontFamily: 'JosefinSans'),
          bodyLarge:
              _lightTypography.bodyLarge!.copyWith(fontFamily: 'JosefinSans'),
          headlineSmall: _lightTypography.headlineSmall!
              .copyWith(fontFamily: 'JosefinSans'),
          headlineMedium: _lightTypography.headlineMedium!
              .copyWith(fontFamily: 'JosefinSans'),
          headlineLarge: _lightTypography.headlineLarge!
              .copyWith(fontFamily: 'JosefinSans'),
          displayLarge: _lightTypography.displayLarge!
              .copyWith(fontWeight: FontWeight.bold),
          displayMedium: _lightTypography.displayMedium!
              .copyWith(fontWeight: FontWeight.bold),
          displaySmall: _lightTypography.displaySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        chipTheme: chipTheme,
        searchBarTheme: searchBarTheme,
      );

  final _darkTypography = Typography.whiteCupertino.apply(
    fontFamily: 'JosefinSans',
  );
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        textTheme: _darkTypography.copyWith(
          bodySmall:
              _darkTypography.bodySmall!.copyWith(fontFamily: 'JosefinSans'),
          bodyMedium:
              _darkTypography.bodyMedium!.copyWith(fontFamily: 'JosefinSans'),
          bodyLarge:
              _darkTypography.bodyLarge!.copyWith(fontFamily: 'JosefinSans'),
          titleSmall:
              _darkTypography.titleSmall!.copyWith(fontFamily: 'JosefinSans'),
          titleMedium:
              _darkTypography.titleMedium!.copyWith(fontFamily: 'JosefinSans'),
          titleLarge:
              _darkTypography.titleLarge!.copyWith(fontFamily: 'JosefinSans'),
          displayLarge: _darkTypography.displayLarge!
              .copyWith(fontWeight: FontWeight.bold),
          displayMedium: _darkTypography.displayMedium!
              .copyWith(fontWeight: FontWeight.bold),
          displaySmall: _darkTypography.displaySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        chipTheme: chipTheme,
        searchBarTheme: searchBarTheme,
      );
}
