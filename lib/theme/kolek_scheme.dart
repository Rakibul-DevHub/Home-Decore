import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/appearance/appearance_page.dart';

/// Light/dark choice for splash, auth, and onboarding.
abstract final class KolekScheme {
  static bool isDark(BuildContext context) => AppearancePage.isDark(context);

  static const darkBackground = AppearancePage.darkCanvas;
  static const darkText = AppearancePage.darkForeground;

  static Color text(BuildContext context, Color light) {
    return isDark(context) ? AppearancePage.darkForeground : light;
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
    return AppearancePage.overlay(context);
  }
}
