import 'package:flutter/material.dart';

/// Theme source until an appearance screen exists.
///
/// Change [themeMode], then hot restart:
/// [ThemeMode.light], [ThemeMode.dark], or [ThemeMode.system].
abstract final class AppearancePage {
  static const themeMode = ThemeMode.light;
}
