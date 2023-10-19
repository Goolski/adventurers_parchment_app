import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  fontFamily: fontFamily,
  textTheme: textTheme,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black).copyWith(
    primary: Colors.black,
  ),
  canvasColor: Colors.transparent,
  chipTheme: ChipThemeData(
    padding: EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    showCheckmark: false,
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.black,
        width: 1,
        style: BorderStyle.solid,
      ),
    ),
  ),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  pageTransitionsTheme: pageTransitionTheme,
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

final pageTransitionTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.iOS: FadePageTransitionsBuilder(),
    TargetPlatform.linux: FadePageTransitionsBuilder(),
    TargetPlatform.macOS: FadePageTransitionsBuilder(),
    TargetPlatform.android: FadePageTransitionsBuilder(),
    TargetPlatform.fuchsia: FadePageTransitionsBuilder(),
    TargetPlatform.windows: FadePageTransitionsBuilder(),
  },
);

class FadePageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Stack(
      children: [
        FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: FadeTransition(
            opacity:
                Tween<double>(begin: 1.0, end: 0.0).animate(secondaryAnimation),
            child: child,
          ),
        ),
      ],
    );
  }
}
