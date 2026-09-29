import 'package:flutter/material.dart';
import 'app_bootstrap.dart';
import 'routes/app_routes.dart';
import 'screens/appearance/appearance_page.dart';
import 'theme/kolek_colors.dart';
import 'widgets/kolek_fit_layout.dart';

Future<void> main() async {
  await AppBootstrap.init();
  runApp(const KolekApp());
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kolek',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: AppearancePage.themeMode,
      builder: (context, child) {
        return KolekFitLayout(child: child ?? const SizedBox.shrink());
      },
      initialRoute: AppRoutes.mainShell,
      routes: AppRoutes.routes,
      onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
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
