import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  fontFamily: fontFamily,
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
);

// final fontFamily = GoogleFonts.cinzel().fontFamily;
final fontFamily = GoogleFonts.fondamento().fontFamily;

const defaultFontWeight = FontWeight.w600;

final textTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: defaultFontWeight),
  bodyMedium: TextStyle(
    fontWeight: defaultFontWeight,
    fontSize: 20,
  ),
  bodySmall: TextStyle(
    fontWeight: defaultFontWeight,
    fontSize: 24,
  ),
  displayLarge: TextStyle(fontWeight: defaultFontWeight),
  displayMedium: TextStyle(fontWeight: defaultFontWeight),
  displaySmall: TextStyle(fontWeight: defaultFontWeight),
  headlineLarge: TextStyle(fontWeight: defaultFontWeight),
  headlineMedium: TextStyle(fontWeight: defaultFontWeight),
  headlineSmall: TextStyle(fontWeight: defaultFontWeight),
  labelLarge: TextStyle(fontWeight: defaultFontWeight),
  labelMedium: TextStyle(fontWeight: defaultFontWeight),
  labelSmall: TextStyle(fontWeight: defaultFontWeight),
  titleLarge: TextStyle(fontWeight: defaultFontWeight),
  titleMedium: TextStyle(fontWeight: defaultFontWeight),
  titleSmall: TextStyle(fontWeight: defaultFontWeight),
);
