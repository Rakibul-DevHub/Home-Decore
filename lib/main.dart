import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/app_routes.dart';
import 'theme/kolek_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const KolekApp());
}

class KolekApp extends StatelessWidget {
  const KolekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kolek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: KolekColors.blue600,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: KolekColors.neutral50,
        useMaterial3: true,
      ),
      // Change to AppRoutes.mainShell to skip splash while developing.
      initialRoute: AppRoutes.mainShell,
      routes: AppRoutes.routes,
      onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoutes,
    );
  }
}
