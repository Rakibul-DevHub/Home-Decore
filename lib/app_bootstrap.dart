//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// /// One-time process setup before [runApp].
// ///
// /// This class owns **process-level** concerns only:
// ///   • Error handling
// ///   • Preferred orientation
// ///
// /// It does NOT manage system-bar visibility or icon colors — those are
// /// owned by [KolekSystemUi] (visibility) and [ThemedStatusBar] (style).
// abstract final class AppBootstrap {
//   static Future<void> init() async {
//     FlutterError.onError = (details) {
//       FlutterError.presentError(details);
//       if (kReleaseMode) {
//         // Hook crash reporting (Firebase Crashlytics / Sentry) here.
//         debugPrint(details.exceptionAsString());
//       }
//     };
//
//     PlatformDispatcher.instance.onError = (error, stack) {
//       if (kReleaseMode) {
//         debugPrint('$error\n$stack');
//       }
//       return true;
//     };
//
//     await SystemChrome.setPreferredOrientations(const [
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }
// }











import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// One-time process setup before [runApp].
abstract final class AppBootstrap {
  static Future<void> init() async {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      if (kReleaseMode) {
        debugPrint(details.exceptionAsString());
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      if (kReleaseMode) {
        debugPrint('$error\n$stack');
      }
      return true;
    };

    await SystemChrome.setPreferredOrientations(const [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
