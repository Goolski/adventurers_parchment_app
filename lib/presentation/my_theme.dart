import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  fontFamily: fontFamily,
  textTheme: textTheme,
);

// final fontFamily = GoogleFonts.cinzel().fontFamily;
final fontFamily = GoogleFonts.forum().fontFamily;
final titleFont = GoogleFonts.unifrakturMaguntia().fontFamily;
final spellDescription = GoogleFonts.meddon().fontFamily;

const defaultFontWeight = FontWeight.w600;

final textTheme = TextTheme(
  bodyLarge: TextStyle(fontWeight: defaultFontWeight),
  bodyMedium: TextStyle(
    fontFamily: spellDescription,
    fontWeight: defaultFontWeight,
  ),
  bodySmall: TextStyle(fontWeight: defaultFontWeight),
  displayLarge: TextStyle(fontWeight: defaultFontWeight),
  displayMedium: TextStyle(fontWeight: defaultFontWeight),
  displaySmall: TextStyle(fontWeight: defaultFontWeight),
  headlineLarge: TextStyle(fontWeight: defaultFontWeight),
  headlineMedium: TextStyle(fontWeight: defaultFontWeight),
  headlineSmall:
      TextStyle(fontWeight: defaultFontWeight, fontFamily: titleFont),
  labelLarge: TextStyle(fontWeight: defaultFontWeight),
  labelMedium: TextStyle(fontWeight: defaultFontWeight),
  labelSmall: TextStyle(fontWeight: defaultFontWeight),
  titleLarge: TextStyle(fontWeight: defaultFontWeight),
  titleMedium: TextStyle(fontWeight: defaultFontWeight),
  titleSmall: TextStyle(fontWeight: defaultFontWeight),
);
