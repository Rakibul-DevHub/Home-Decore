import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Single entry point used by `main`. Owns the entire startup sequence:
///
///   1. Bind Flutter to the platform.
///   2. Install global error hooks.
///   3. Set preferred orientation.
///   4. Hand system-UI layout control to native Kotlin.
///   5. Mount the app via [builder].
///
/// Kept separate from `main.dart` so the entry point stays a single
/// obvious line, and so new startup steps (storage, Firebase, deep links,
/// remote config) can be added here without ever touching UI files.
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Error hooks ────────────────────────────────────────────────────────
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) {
      // Hook crash reporting (Firebase Crashlytics / Sentry) here.
      debugPrint(details.exceptionAsString());
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kReleaseMode) {
      debugPrint('$error\n$stack');
    }
    return true;
  };

  // ── Orientation ────────────────────────────────────────────────────────
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── System UI ──────────────────────────────────────────────────────────
  // Hand system-UI layout control to MainActivity.kt. Native Kotlin pins
  // the status bar and auto-hides the nav bar with the transient-swipe
  // behavior Flutter's SystemUiMode enum cannot express.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // ── Mount ──────────────────────────────────────────────────────────────
  runApp(await builder());
}