// // import 'package:flutter/material.dart';
// // import 'app_bootstrap.dart';
// // import 'routes/app_routes.dart';
// // import 'screens/appearance/appearance_page.dart';
// // import 'theme/kolek_colors.dart';
// // import 'widgets/kolek_fit_layout.dart';
// //
// // Future<void> main() async {
// //   await AppBootstrap.init();
// //   runApp(const KolekApp());
// // }
// //
// // class KolekApp extends StatefulWidget {
// //   const KolekApp({super.key});
// //
// //   @override
// //   State<KolekApp> createState() => _KolekAppState();
// // }
// //
// // class _KolekAppState extends State<KolekApp> with WidgetsBindingObserver {
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //   }
// //
// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     super.dispose();
// //   }
// //
// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     if (state == AppLifecycleState.resumed) {
// //       AppBootstrap.applySystemUi();
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Kolek',
// //       debugShowCheckedModeBanner: false,
// //       theme: _buildTheme(Brightness.light),
// //       darkTheme: _buildTheme(Brightness.dark),
// //       themeMode: AppearancePage.themeMode,
// //       builder: (context, child) {
// //         return KolekFitLayout(child: child ?? const SizedBox.shrink());
// //       },
// //       initialRoute: AppRoutes.mainShell,
// //       routes: AppRoutes.routes,
// //       onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
// //     );
// //   }
// //
// //   static ThemeData _buildTheme(Brightness brightness) {
// //     final colorScheme = ColorScheme.fromSeed(
// //       seedColor: KolekColors.blue600,
// //       brightness: brightness,
// //     );
// //     final dark = brightness == Brightness.dark;
// //
// //     return ThemeData(
// //       colorScheme: colorScheme,
// //       scaffoldBackgroundColor: dark
// //           ? AppearancePage.darkCanvas
// //           : AppearancePage.lightCanvas,
// //       useMaterial3: true,
// //       visualDensity: VisualDensity.standard,
// //       splashFactory: InkSparkle.splashFactory,
// //       appBarTheme: AppBarTheme(
// //         elevation: 0,
// //         scrolledUnderElevation: 0,
// //         backgroundColor: Colors.transparent,
// //         foregroundColor: dark
// //             ? AppearancePage.darkForeground
// //             : AppearancePage.lightForeground,
// //         systemOverlayStyle: AppearancePage.overlayFor(dark),
// //       ),
// //     );
// //   }
// // }
//
//
//
// ///
// ///
// ///
// ///
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'app_bootstrap.dart';
// import 'routes/app_routes.dart';
// import 'screens/appearance/appearance_page.dart';
// import 'theme/kolek_colors.dart';
// import 'widgets/kolek_fit_layout.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppBootstrap.init();
//
//   // Apply the app's system UI styling first (status bar icon brightness etc.)
//   await AppBootstrap.applySystemUi();
//
//   // Then hide the system bars. Immersive sticky keeps them hidden; the user
//   // reveals them by swiping from the screen edge, and they auto-hide again.
//   await KolekSystemUi.enterImmersive();
//
//   runApp(const KolekApp());
// }
//
// /// Small helper that owns the visibility of the device system bars.
// class KolekSystemUi {
//   const KolekSystemUi._();
//
//   /// Hides the status + navigation bars.
//   ///
//   /// `immersiveSticky` is the key mode: the bars stay off-screen and only
//   /// appear when the user swipes from the edge, then slide away again.
//   static Future<void> enterImmersive() {
//     return SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }
//
//   /// Brings the system bars back permanently (e.g. from a settings toggle).
//   static Future<void> showSystemBars() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//   }
//
//   /// Shows the bars for [duration] and then returns to the immersive state.
//   /// Handy for a "reveal navigation bar" button in settings.
//   static Future<void> peekSystemBars({
//     Duration duration = const Duration(seconds: 3),
//   }) async {
//     await showSystemBars();
//     await Future<void>.delayed(duration);
//     await enterImmersive();
//   }
// }
//
// class KolekApp extends StatefulWidget {
//   const KolekApp({super.key});
//
//   @override
//   State<KolekApp> createState() => _KolekAppState();
// }
//
// class _KolekAppState extends State<KolekApp> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     // Re-assert immersive mode once the first frame is up.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       KolekSystemUi.enterImmersive();
//     });
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       AppBootstrap.applySystemUi();
//
//       // Android resets the system UI flags when returning to the foreground,
//       // so hide the navigation bar again.
//       KolekSystemUi.enterImmersive();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kolek',
//       debugShowCheckedModeBanner: false,
//       theme: _buildTheme(Brightness.light),
//       darkTheme: _buildTheme(Brightness.dark),
//       themeMode: AppearancePage.themeMode,
//       builder: (context, child) {
//         return KolekFitLayout(child: child ?? const SizedBox.shrink());
//       },
//       initialRoute: AppRoutes.mainShell,
//       routes: AppRoutes.routes,
//       onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
//     );
//   }
//
//   static ThemeData _buildTheme(Brightness brightness) {
//     final colorScheme = ColorScheme.fromSeed(
//       seedColor: KolekColors.blue600,
//       brightness: brightness,
//     );
//     final dark = brightness == Brightness.dark;
//
//     return ThemeData(
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: dark
//           ? AppearancePage.darkCanvas
//           : AppearancePage.lightCanvas,
//       useMaterial3: true,
//       visualDensity: VisualDensity.standard,
//       splashFactory: InkSparkle.splashFactory,
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: dark
//             ? AppearancePage.darkForeground
//             : AppearancePage.lightForeground,
//         systemOverlayStyle: AppearancePage.overlayFor(dark),
//       ),
//     );
//   }
// }





///
///
///
/// todo:: just adding theme toggle button
///
///
///



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'app_bootstrap.dart';
// import 'routes/app_routes.dart';
// import 'screens/appearance/appearance_page.dart';
// import 'theme/kolek_colors.dart';
// import 'widgets/kolek_fit_layout.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppBootstrap.init();
//
//   // Apply the app's system UI styling first (status bar icon brightness etc.)
//   await AppBootstrap.applySystemUi();
//
//   // Then hide the system bars. Immersive sticky keeps them hidden; the user
//   // reveals them by swiping from the screen edge, and they auto-hide again.
//   await KolekSystemUi.enterImmersive();
//
//   runApp(const KolekApp());
// }
//
// /// Small helper that owns the visibility of the device system bars.
// class KolekSystemUi {
//   const KolekSystemUi._();
//
//   /// Hides the status + navigation bars.
//   ///
//   /// `immersiveSticky` is the key mode: the bars stay off-screen and only
//   /// appear when the user swipes from the edge, then slide away again.
//   static Future<void> enterImmersive() {
//     return SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }
//
//   /// Brings the system bars back permanently (e.g. from a settings toggle).
//   static Future<void> showSystemBars() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//   }
//
//   /// Shows the bars for [duration] and then returns to the immersive state.
//   /// Handy for a "reveal navigation bar" button in settings.
//   static Future<void> peekSystemBars({
//     Duration duration = const Duration(seconds: 3),
//   }) async {
//     await showSystemBars();
//     await Future<void>.delayed(duration);
//     await enterImmersive();
//   }
// }
//
// class KolekApp extends StatefulWidget {
//   const KolekApp({super.key});
//
//   @override
//   State<KolekApp> createState() => _KolekAppState();
// }
//
// class _KolekAppState extends State<KolekApp> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//
//     // Re-assert immersive mode once the first frame is up.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       KolekSystemUi.enterImmersive();
//     });
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       AppBootstrap.applySystemUi();
//
//       // Android resets the system UI flags when returning to the foreground,
//       // so hide the navigation bar again.
//       KolekSystemUi.enterImmersive();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Rebuilds MaterialApp whenever the active theme mode changes.
//     // Without this, toggling the theme would not repaint the tree.
//     return ValueListenableBuilder<ThemeMode>(
//       valueListenable: AppearancePage.themeModeNotifier,
//       builder: (context, mode, _) {
//         return MaterialApp(
//           title: 'Kolek',
//           debugShowCheckedModeBanner: false,
//           theme: _buildTheme(Brightness.light),
//           darkTheme: _buildTheme(Brightness.dark),
//           themeMode: mode,
//           builder: (context, child) {
//             return KolekFitLayout(child: child ?? const SizedBox.shrink());
//           },
//           initialRoute: AppRoutes.mainShell,
//           routes: AppRoutes.routes,
//           onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
//         );
//       },
//     );
//   }
//
//   static ThemeData _buildTheme(Brightness brightness) {
//     final colorScheme = ColorScheme.fromSeed(
//       seedColor: KolekColors.blue600,
//       brightness: brightness,
//     );
//     final dark = brightness == Brightness.dark;
//
//     return ThemeData(
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: dark
//           ? AppearancePage.darkCanvas
//           : AppearancePage.lightCanvas,
//       useMaterial3: true,
//       visualDensity: VisualDensity.standard,
//       splashFactory: InkSparkle.splashFactory,
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         backgroundColor: Colors.transparent,
//         foregroundColor: dark
//             ? AppearancePage.darkForeground
//             : AppearancePage.lightForeground,
//         systemOverlayStyle: AppearancePage.overlayFor(dark),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_bootstrap.dart';
import 'routes/app_routes.dart';
import 'screens/appearance/appearance_page.dart';
import 'theme/kolek_colors.dart';
import 'widgets/kolek_fit_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init();

  // Apply the app's system UI styling first (status bar icon brightness etc.)
  await AppBootstrap.applySystemUi();

  // Then hide the system bars. Immersive sticky keeps them hidden; the user
  // reveals them by swiping from the screen edge, and they auto-hide again.
  await KolekSystemUi.enterImmersive();

  runApp(const KolekApp());
}

/// Small helper that owns the visibility of the device system bars.
class KolekSystemUi {
  const KolekSystemUi._();

  /// Hides the status + navigation bars.
  ///
  /// `immersiveSticky` is the key mode: the bars stay off-screen and only
  /// appear when the user swipes from the edge, then slide away again.
  static Future<void> enterImmersive() {
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// Brings the system bars back permanently (e.g. from a settings toggle).
  static Future<void> showSystemBars() {
    return SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// Shows the bars for [duration] and then returns to the immersive state.
  /// Handy for a "reveal navigation bar" button in settings.
  static Future<void> peekSystemBars({
    Duration duration = const Duration(seconds: 3),
  }) async {
    await showSystemBars();
    await Future<void>.delayed(duration);
    await enterImmersive();
  }
}

class KolekApp extends StatefulWidget {
  const KolekApp({super.key});

  @override
  State<KolekApp> createState() => _KolekAppState();
}

class _KolekAppState extends State<KolekApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Re-assert immersive mode once the first frame is up.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      KolekSystemUi.enterImmersive();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppBootstrap.applySystemUi();

      // Android resets the system UI flags when returning to the foreground,
      // so hide the navigation bar again.
      KolekSystemUi.enterImmersive();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilds MaterialApp whenever the active theme mode changes.
    // Without this, toggling the theme would not repaint the tree.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppearancePage.themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'Kolek',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(Brightness.light),
          darkTheme: _buildTheme(Brightness.dark),
          themeMode: mode,
          builder: (context, child) {
            return KolekFitLayout(child: child ?? const SizedBox.shrink());
          },
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
          onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
        );
      },
    );
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: KolekColors.blue600,
      brightness: brightness,
    );
    final dark = brightness == Brightness.dark;

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: dark
          ? AppearancePage.darkCanvas
          : AppearancePage.lightCanvas,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: dark
            ? AppearancePage.darkForeground
            : AppearancePage.lightForeground,
        systemOverlayStyle: AppearancePage.overlayFor(dark),
      ),
    );
  }
}