import 'package:flutter/material.dart';

/// One selectable theme option shown on the Appearance screen.
class ThemeOption {
  const ThemeOption({
    required this.mode,
    required this.label,
  });

  final ThemeMode mode;
  final String label;
}

abstract final class AppearanceData {
  static const title = 'Appearance';

  /// The options shown as radio rows. Order matters — Light on top,
  /// Dark below, matching the design.
  static const options = <ThemeOption>[
    ThemeOption(mode: ThemeMode.light, label: 'Light'),
    ThemeOption(mode: ThemeMode.dark, label: 'Dark'),
  ];
}