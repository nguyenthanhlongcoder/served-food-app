import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';

class AppThemes {
  static final Color _focusColor = Colors.black.withOpacity(0.12);

  static ThemeData myThemeData = themeData(colorScheme, _focusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        color: colorScheme.primary,
        elevation: 0,
        brightness: colorScheme.brightness,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
    );
  }

  static const ColorScheme colorScheme = ColorScheme(
    primary: kBtnColorStart,
    primaryVariant: Color(0xFF640AFF),
    secondary: Color(0xFF03DAC5),
    secondaryVariant: Color(0xFF0AE1C5),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
}
