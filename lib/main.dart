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
//   // Hand system UI layout control entirely to your custom MainActivity.kt layer.
//   // This allows native Kotlin to pin the status bar and auto-hide the nav bar.
//   await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//
//   runApp(const KolekApp());
// }
//
// class KolekApp extends StatefulWidget {
//   const KolekApp({super.key});
//
//   @override
//   State<KolekApp> createState() => _KolekAppState();
// }
//
// class _KolekAppState extends State<KolekApp> {
//   @override
//   Widget build(BuildContext context) {
//     // Rebuilds MaterialApp whenever the active theme mode changes.
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
//             // permanently visible status bar.
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
//         // Match the scaffold background so the AppBar blends seamlessly
//         // with the top status bar area.
//         backgroundColor: canvasColor,
//         foregroundColor: dark
//             ? AppearancePage.darkForeground
//             : AppearancePage.lightForeground,
//         systemOverlayStyle: AppearancePage.overlayFor(dark),
//       ),
//     );
//   }
// }





import 'app.dart';
import 'bootstrap.dart';

void main() {
  bootstrap(() => const KolekApp());
}