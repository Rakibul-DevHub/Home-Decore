// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// /// One-time process setup before [runApp].
// abstract final class AppBootstrap {
//   static Future<void> init() async {
//     FlutterError.onError = (details) {
//       FlutterError.presentError(details);
//       if (kReleaseMode) {
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
