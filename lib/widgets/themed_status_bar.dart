import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/appearance/appearance_page.dart';

/// Paints a solid, theme-aware background behind the device status bar
/// and keeps the status-bar icons legible in both light and dark modes.
///
/// Use this instead of relying on `SystemUiOverlayStyle.statusBarColor`,
/// which is ignored on Android 15+ (edge-to-edge enforcement).
class ThemedStatusBar extends StatelessWidget {
  const ThemedStatusBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = AppearancePage.isDark(context);
    final barColor = AppearancePage.background(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Still set brightness so the clock/battery icons flip correctly.
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        // Keep the nav bar transparent; we hide it anyway.
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
      child: ColoredBox(
        color: barColor,
        // Using SafeArea (top: true) ensures your main app content
        // sits cleanly right below the system status bar frame.
        child: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: false,
          child: child,
        ),
      ),
    );
  }
}
