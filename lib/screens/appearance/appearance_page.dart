import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/kolek_colors.dart';

/// Theme source until an appearance screen exists.
///
/// Change [themeMode], then hot restart:
/// [ThemeMode.light], [ThemeMode.dark], or [ThemeMode.system].
abstract final class AppearancePage {
  static const themeMode = ThemeMode.light;

  static const lightCanvas = KolekColors.neutral50;
  static const darkCanvas = KolekColors.neutral900;
  static const lightForeground = KolekColors.neutral900;
  static const darkForeground = KolekColors.neutral50;

  static bool isDark(BuildContext context) {
    return switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };
  }

  static Color background(BuildContext context) {
    return isDark(context) ? darkCanvas : lightCanvas;
  }

  static Color foreground(BuildContext context) {
    return isDark(context) ? darkForeground : lightForeground;
  }

  static Color muted(BuildContext context) {
    return isDark(context) ? KolekColors.neutral400 : KolekColors.neutral500;
  }

  static Color secondary(BuildContext context) {
    return isDark(context) ? KolekColors.neutral300 : KolekColors.neutral600;
  }

  static Color icon(BuildContext context) {
    return isDark(context) ? KolekColors.neutral200 : KolekColors.neutral700;
  }

  static Color field(BuildContext context) {
    return isDark(context) ? KolekColors.neutral800 : KolekColors.neutral100;
  }

  static Color line(BuildContext context) {
    return isDark(context) ? KolekColors.neutral800 : KolekColors.neutral200;
  }

  static Color menu(BuildContext context) {
    return isDark(context) ? KolekColors.neutral800 : const Color(0xFFF4F4F4);
  }

  static SystemUiOverlayStyle overlay(BuildContext context) {
    return overlayFor(isDark(context));
  }

  static SystemUiOverlayStyle overlayFor(bool dark) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: dark ? Brightness.light : Brightness.dark,
      statusBarBrightness: dark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    );
  }

  static ColorFilter iconFilter(BuildContext context) {
    return ColorFilter.mode(icon(context), BlendMode.srcIn);
  }

  static ColorFilter textFilter(BuildContext context) {
    return ColorFilter.mode(foreground(context), BlendMode.srcIn);
  }
}
