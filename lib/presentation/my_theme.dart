import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  fontFamily: fontFamily,
  textTheme: textTheme,
);

// final fontFamily = GoogleFonts.cinzel().fontFamily;
final fontFamily = GoogleFonts.forum().fontFamily;

const defaultFontWeight = FontWeight.w600;

const textTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: defaultFontWeight),
  bodyMedium: TextStyle(fontWeight: defaultFontWeight),
  bodySmall: TextStyle(fontWeight: defaultFontWeight),
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
