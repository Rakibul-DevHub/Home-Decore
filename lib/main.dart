import 'package:flutter/material.dart';

import 'app_bootstrap.dart';
import 'routes/app_routes.dart';
import 'theme/kolek_colors.dart';

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
      theme: _buildTheme(),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            // Keep layout stable on extreme accessibility text scales.
            textScaler: media.textScaler.clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.25,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
    );
  }

  static ThemeData _buildTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: KolekColors.blue600,
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: KolekColors.neutral50,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: KolekColors.neutral950,
        systemOverlayStyle: AppBootstrap.overlayStyle,
      ),
    );
  }
}
