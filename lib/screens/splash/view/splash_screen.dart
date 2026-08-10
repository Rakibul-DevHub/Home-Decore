import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../cubit/splash_cubit.dart';
import '../data/splash_data.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
      listenWhen: (previous, current) => !previous && current,
      listener: (context, _) {
        Navigator.of(context).pushReplacementNamed(AppRoute.onboarding);
      },
      child: const Scaffold(
        backgroundColor: KolekColors.neutral50,
        body: Center(
          child: Image(
            image: AssetImage(SplashData.logoAsset),
            width: SplashData.logoWidth,
            height: SplashData.logoHeight,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
