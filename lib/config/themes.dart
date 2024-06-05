import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final searchBarTheme = SearchBarThemeData(
    shadowColor: WidgetStateProperty.all(Colors.transparent),
    padding: WidgetStateProperty.all(
      const EdgeInsets.only(left: 16),
    ),
    shape: WidgetStateProperty.all(
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

  final _baseFont = GoogleFonts.cantarell().fontFamily;

  final _lightTypography = Typography.blackCupertino;
  ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreenAccent,
        ),
        textTheme: _lightTypography.copyWith(
          bodySmall:
              _lightTypography.bodySmall!.copyWith(fontFamily: _baseFont),
          bodyMedium:
              _lightTypography.bodyMedium!.copyWith(fontFamily: _baseFont),
          bodyLarge:
              _lightTypography.bodyLarge!.copyWith(fontFamily: _baseFont),
          headlineSmall:
              _lightTypography.headlineSmall!.copyWith(fontFamily: _baseFont),
          headlineMedium:
              _lightTypography.headlineMedium!.copyWith(fontFamily: _baseFont),
          headlineLarge:
              _lightTypography.headlineLarge!.copyWith(fontFamily: _baseFont),
          displayLarge: _lightTypography.displayLarge!
              .copyWith(fontWeight: FontWeight.bold),
          displayMedium: _lightTypography.displayMedium!
              .copyWith(fontWeight: FontWeight.bold),
          displaySmall: _lightTypography.displaySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        chipTheme: chipTheme,
        searchBarTheme: searchBarTheme,
        primaryColor: const Color.fromARGB(255, 21, 133, 24),
      );

  final _darkTypography = Typography.whiteCupertino;
  ThemeData get darkTheme => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        textTheme: _darkTypography.copyWith(
          bodySmall: _darkTypography.bodySmall!.copyWith(fontFamily: _baseFont),
          bodyMedium:
              _darkTypography.bodyMedium!.copyWith(fontFamily: _baseFont),
          bodyLarge: _darkTypography.bodyLarge!.copyWith(fontFamily: _baseFont),
          titleSmall:
              _darkTypography.titleSmall!.copyWith(fontFamily: _baseFont),
          titleMedium:
              _darkTypography.titleMedium!.copyWith(fontFamily: _baseFont),
          titleLarge:
              _darkTypography.titleLarge!.copyWith(fontFamily: _baseFont),
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
