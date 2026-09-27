import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/appearance/appearance_page.dart';

/// Light/dark choice for splash, auth, and onboarding.
abstract final class KolekScheme {
  static bool isDark(BuildContext context) {
    return switch (AppearancePage.themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };
  }

  static const darkBackground = Color(0xFF000000);
  static const darkText = Color(0xFFFFFFFF);

  static Color text(BuildContext context, Color light) {
    return isDark(context) ? darkText : light;
  }

  /// Keeps size and weight. In dark mode the color becomes white.
  static TextStyle textStyle(BuildContext context, TextStyle style) {
    if (!isDark(context)) return style;
    return style.copyWith(
      color: darkText,
      decorationColor: style.decoration == null ? null : darkText,
    );
  }

  static SystemUiOverlayStyle overlay(BuildContext context) {
    final dark = isDark(context);
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness:
          dark ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }
}
