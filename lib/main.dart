// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'app_bootstrap.dart';
// import 'routes/app_routes.dart';
// import 'screens/appearance/appearance_page.dart';
// import 'theme/kolek_colors.dart';
// import 'widgets/kolek_fit_layout.dart';
// import 'widgets/themed_status_bar.dart'; // Make sure this path matches your project structure
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppBootstrap.init();
//
//   // Apply the app's system UI styling first (status bar icon brightness etc.)
//   await AppBootstrap.applySystemUi();
//
//   // Keep the status bar visible; hide only the navigation bar.
//   await KolekSystemUi.enterImmersive();
//
//   runApp(const KolekApp());
// }
//
// /// Small helper that owns the visibility of the device system bars.
// class KolekSystemUi {
//   const KolekSystemUi._();
//
//   /// Shows the status bar, hides the navigation bar.
//   static Future<void> enterImmersive() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.top],
//     );
//   }
//
//   /// Brings both system bars back permanently.
//   static Future<void> showSystemBars() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//   }
//
//   /// Shows the navigation bar for [duration], then hides the nav bar again.
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
//       KolekSystemUi.enterImmersive();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//             // Apply ThemedStatusBar here so it acts as a global wrapper
//             // over every page rendered via the router.
//             return ThemedStatusBar(
//               child: KolekFitLayout(child: child ?? const SizedBox.shrink()),
//             );
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
//     final canvasColor = dark ? AppearancePage.darkCanvas : AppearancePage.lightCanvas;
//
//     return ThemeData(
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: canvasColor,
//       useMaterial3: true,
//       visualDensity: VisualDensity.standard,
//       splashFactory: InkSparkle.splashFactory,
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         // Match the scaffold background to keep visual seamlessness under the status bar
//         backgroundColor: canvasColor,
//         foregroundColor: dark ? AppearancePage.darkForeground : AppearancePage.lightForeground,
//         systemOverlayStyle: AppearancePage.overlayFor(dark),
//       ),
//     );
//   }
// }





//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'app_bootstrap.dart';
// import 'routes/app_routes.dart';
// import 'screens/appearance/appearance_page.dart';
// import 'theme/kolek_colors.dart';
// import 'widgets/kolek_fit_layout.dart';
// import 'widgets/themed_status_bar.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppBootstrap.init();
//
//   // Keep the status bar visible; hide only the navigation bar.
//   // The user can still swipe from the bottom edge to reveal the nav bar
//   // temporarily, and it slides away again on its own.
//   await KolekSystemUi.enterImmersive();
//
//   runApp(const KolekApp());
// }
//
// /// Small helper that owns the visibility of the device system bars.
// ///
// /// This class manages **visibility only** (which bars are shown).
// /// Styling (icon brightness, background color) is handled per-screen
// /// by [ThemedStatusBar] via `AnnotatedRegion`.
// class KolekSystemUi {
//   const KolekSystemUi._();
//
//   /// Shows the status bar, hides the navigation bar.
//   ///
//   /// `SystemUiMode.manual` with only [SystemUiOverlay.top] is the mode that
//   /// lets us pick per-bar visibility: status bar stays on, nav bar stays off.
//   static Future<void> enterImmersive() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.top],
//     );
//   }
//
//   /// Brings both system bars back permanently (e.g. from a settings toggle).
//   static Future<void> showSystemBars() {
//     return SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//   }
//
//   /// Shows the navigation bar (status bar stays put) for [duration],
//   /// then hides the nav bar again.
//   ///
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
//     // Re-assert bar visibility once the first frame is up.
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
//       // Android may reset system UI flags when returning to the foreground,
//       // so re-assert the visibility mode. Styling is handled per-screen by
//       // ThemedStatusBar via AnnotatedRegion — nothing to reapply here.
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
//             // ThemedStatusBar paints a theme-aware background behind the
//             // status bar and sets the correct icon brightness per theme.
//             return ThemedStatusBar(
//               child: KolekFitLayout(child: child ?? const SizedBox.shrink()),
//             );
//           },
//           initialRoute: AppRoutes.splash,
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
//     final canvasColor =
//     dark ? AppearancePage.darkCanvas : AppearancePage.lightCanvas;
//
//     return ThemeData(
//       colorScheme: colorScheme,
//       scaffoldBackgroundColor: canvasColor,
//       useMaterial3: true,
//       visualDensity: VisualDensity.standard,
//       splashFactory: InkSparkle.splashFactory,
//       appBarTheme: AppBarTheme(
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         // Match the scaffold background so the AppBar blends with the
//         // status bar area painted by ThemedStatusBar.
//         backgroundColor: canvasColor,
//         foregroundColor: dark
//             ? AppearancePage.darkForeground
//             : AppearancePage.lightForeground,
//         systemOverlayStyle: AppearancePage.overlayFor(dark),
//       ),
//     );
//   }
// }










/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_bootstrap.dart';
import 'routes/app_routes.dart';
import 'screens/appearance/appearance_page.dart';
import 'theme/kolek_colors.dart';
import 'widgets/kolek_fit_layout.dart';
import 'widgets/themed_status_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init();

  // Enforce manual mode with only the status bar visible at startup
  await KolekSystemUi.enterImmersive();

  runApp(const KolekApp());
}

/// Small helper that owns the visibility of the device system bars.
class KolekSystemUi {
  const KolekSystemUi._();

  /// Pins the status bar to be permanently visible while hiding the navigation bar.
  static Future<void> enterImmersive() {
    return SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top], // Keeps status bar fixed at the top
    );
  }

  /// Brings both system bars back permanently if needed.
  static Future<void> showSystemBars() {
    return SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
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

    // Initial configuration check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      KolekSystemUi.enterImmersive();
    });

    // Detects when the user swipes to bring up the hidden navigation bar
    SystemChrome.setSystemUIChangeCallback((bool visible) async {
      if (visible) {
        // If the system overlay flags changed (user swiped navigation bar open),
        // wait exactly 2 seconds and then hide it automatically.
        await Future<void>.delayed(const Duration(seconds: 2));
        KolekSystemUi.enterImmersive();
      }
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
      // Re-assert structural rules when application transitions back to foreground
      KolekSystemUi.enterImmersive();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            return ThemedStatusBar(
              child: KolekFitLayout(child: child ?? const SizedBox.shrink()),
            );
          },
          initialRoute: AppRoutes.mainShell,
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
    final canvasColor = dark ? AppearancePage.darkCanvas : AppearancePage.lightCanvas;

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvasColor,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: canvasColor,
        foregroundColor: dark ? AppearancePage.darkForeground : AppearancePage.lightForeground,
        systemOverlayStyle: AppearancePage.overlayFor(dark),
      ),
    );
  }
}*/




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_bootstrap.dart';
import 'routes/app_routes.dart';
import 'screens/appearance/appearance_page.dart';
import 'theme/kolek_colors.dart';
import 'widgets/kolek_fit_layout.dart';
import 'widgets/themed_status_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init();

  // Hand system UI layout control entirely to your custom MainActivity.kt layer.
  // This allows native Kotlin to pin the status bar and auto-hide the nav bar.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const KolekApp());
}

class KolekApp extends StatefulWidget {
  const KolekApp({super.key});

  @override
  State<KolekApp> createState() => _KolekAppState();
}

class _KolekAppState extends State<KolekApp> {
  @override
  Widget build(BuildContext context) {
    // Rebuilds MaterialApp whenever the active theme mode changes.
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
            // ThemedStatusBar paints a theme-aware background behind the
            // permanently visible status bar.
            return ThemedStatusBar(
              child: KolekFitLayout(child: child ?? const SizedBox.shrink()),
            );
          },
          initialRoute: AppRoutes.mainShell,
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
    final canvasColor = dark ? AppearancePage.darkCanvas : AppearancePage.lightCanvas;

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: canvasColor,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        // Match the scaffold background so the AppBar blends seamlessly
        // with the top status bar area.
        backgroundColor: canvasColor,
        foregroundColor: dark
            ? AppearancePage.darkForeground
            : AppearancePage.lightForeground,
        systemOverlayStyle: AppearancePage.overlayFor(dark),
      ),
    );
  }
}
