import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/app_router.dart';
import 'routes/app_route.dart';
import 'theme/kolek_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const KolekApp());
}

class KolekApp extends StatelessWidget {
  const KolekApp({
    super.key,
    this.splashDuration = const Duration(milliseconds: 1600),
  });

  final Duration splashDuration;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(splashDuration: splashDuration);
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
      initialRoute: AppRoute.splash,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
