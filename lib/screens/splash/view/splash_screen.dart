import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';
import '../data/splash_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _enterController;
  late final Animation<double> _logoSlide;
  late final Animation<double> _textSlide;
  late final Animation<double> _fade;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _enterController = AnimationController(
      vsync: this,
      duration: SplashData.enterDuration,
    );

    final curve = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeOutCubic,
    );

    // Logo comes from above (negative offset) to center.
    _logoSlide = Tween<double>(begin: -140, end: 0).animate(curve);
    // Text comes from below (positive offset) to center.
    _textSlide = Tween<double>(begin: 140, end: 0).animate(curve);
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);

    _enterController.forward();
  }

  void _goNext() {
    if (_navigated || !mounted) return;
    _navigated = true;
    Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          !previous.isReady && current.isReady,
      listener: (_, _) => _goNext(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: AnimatedBuilder(
              animation: _enterController,
              builder: (context, _) {
                return Center(
                  child: Opacity(
                    opacity: _fade.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _logoSlide.value),
                          child: SvgPicture.asset(
                            SplashData.logoAsset,
                            width: SplashData.logoSize,
                            height: SplashData.logoSize,
                            fit: BoxFit.contain,
                            semanticsLabel: SplashData.logoSemanticsLabel,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Transform.translate(
                          offset: Offset(0, _textSlide.value),
                          child: const Text(
                            SplashData.brandName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'GeneralSans-Semibold',
                              fontSize: 68,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: 0,
                              color: KolekColors.blue600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
