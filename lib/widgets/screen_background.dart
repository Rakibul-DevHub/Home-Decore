import 'package:flutter/material.dart';

import '../routes/app_route.dart';

class ScreenBackgroundData {
  const ScreenBackgroundData({
    required this.assetPath,
    required this.width,
    required this.height,
    required this.top,
    this.right = 0,
  });

  final String assetPath;
  final double width;
  final double height;
  final double top;
  final double right;
}

abstract final class ScreenBackgrounds {
  static const Map<String, ScreenBackgroundData> _backgrounds = {
    AppRoute.signIn: ScreenBackgroundData(
      assetPath: 'assets/images/sign_in_art.png',
      width: 202,
      height: 349,
      top: 50,
      right: -1,
    ),
    AppRoute.createAccount: ScreenBackgroundData(
      assetPath: 'assets/images/create_account_art.png',
      width: 285,
      height: 331,
      top: 0,
    ),
  };

  static ScreenBackgroundData? forRoute(String routeName) {
    return _backgrounds[routeName];
  }
}

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({required this.routeName, super.key});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    final background = ScreenBackgrounds.forRoute(routeName);
    if (background == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      right: background.right,
      top: background.top,
      width: background.width,
      height: background.height,
      child: IgnorePointer(
        child: Image.asset(
          background.assetPath,
          width: background.width,
          height: background.height,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
