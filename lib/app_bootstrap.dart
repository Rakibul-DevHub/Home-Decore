import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One-time process setup before [runApp].
abstract final class AppBootstrap {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

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

    await applySystemUi();

    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Hides system nav (and status) bars until the user swipes from the edge.
  static Future<void> applySystemUi() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }

  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );
}
