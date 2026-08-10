import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/auth/create_account/cubit/create_account_cubit.dart';
import '../screens/auth/create_account/view/create_account_screen.dart';
import '../screens/auth/forgot_password/cubit/forgot_password_cubit.dart';
import '../screens/auth/forgot_password/view/forgot_password_screen.dart';
import '../screens/auth/new_password/cubit/new_password_cubit.dart';
import '../screens/auth/new_password/view/new_password_screen.dart';
import '../screens/auth/otp_verification/cubit/otp_verification_cubit.dart';
import '../screens/auth/otp_verification/view/otp_verification_screen.dart';
import '../screens/auth/set_password/cubit/set_password_cubit.dart';
import '../screens/auth/set_password/view/set_password_screen.dart';
import '../screens/auth/welcome/cubit/welcome_cubit.dart';
import '../screens/auth/welcome/view/welcome_screen.dart';
import '../screens/onboarding/cubit/onboarding_cubit.dart';
import '../screens/onboarding/view/onboarding_screen.dart';
import '../screens/cart/cubit/cart_cubit.dart';
import '../screens/cart/view/cart_screen.dart';
import '../screens/filter/cubit/filter_cubit.dart';
import '../screens/filter/view/filter_screen.dart';
import '../screens/home/cubit/home_cubit.dart';
import '../screens/main_shell/cubit/main_shell_cubit.dart';
import '../screens/main_shell/view/main_shell_screen.dart';
import '../screens/product_details/cubit/product_details_cubit.dart';
import '../screens/product_details/view/product_details_screen.dart';
import '../screens/search/cubit/search_cubit.dart';
import '../screens/shop/cubit/shop_cubit.dart';
import '../screens/shop/view/shop_screen.dart';
import '../screens/splash/cubit/splash_cubit.dart';
import '../screens/splash/view/splash_screen.dart';
import 'app_route.dart';

class AppRouter {
  const AppRouter({this.splashDuration = const Duration(milliseconds: 1600)});

  final Duration splashDuration;

  Route<void> onGenerateRoute(RouteSettings settings) {
    final child = switch (settings.name) {
      AppRoute.splash => BlocProvider(
        create: (_) => SplashCubit(duration: splashDuration)..start(),
        child: const SplashScreen(),
      ),
      AppRoute.onboarding => BlocProvider(
        create: (_) => OnboardingCubit(),
        child: const OnboardingScreen(),
      ),
      AppRoute.signIn => BlocProvider(
        create: (_) => WelcomeCubit(),
        child: const WelcomeScreen(),
      ),
      AppRoute.createAccount => BlocProvider(
        create: (_) => CreateAccountCubit(),
        child: const CreateAccountScreen(),
      ),
      AppRoute.forgotPassword => BlocProvider(
        create: (_) => ForgotPasswordCubit(),
        child: const ForgotPasswordScreen(),
      ),
      AppRoute.otpVerification => BlocProvider(
        create: (_) => OtpVerificationCubit(),
        child: const OtpVerificationScreen(),
      ),
      AppRoute.newPassword => BlocProvider(
        create: (_) => NewPasswordCubit(),
        child: const NewPasswordScreen(),
      ),
      AppRoute.setPassword => BlocProvider(
        create: (_) => SetPasswordCubit(),
        child: const SetPasswordScreen(),
      ),
      AppRoute.mainShell => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MainShellCubit()),
          BlocProvider(create: (_) => HomeCubit()),
          BlocProvider(create: (_) => SearchCubit()),
        ],
        child: const MainShellScreen(),
      ),
      AppRoute.shop => BlocProvider(
        create: (_) => ShopCubit(),
        child: const ShopScreen(),
      ),
      AppRoute.filter => BlocProvider(
        create: (_) => FilterCubit(),
        child: const FilterScreen(),
      ),
      AppRoute.productDetails => BlocProvider(
        create: (_) => ProductDetailsCubit(),
        child: const ProductDetailsScreen(),
      ),
      AppRoute.cart => BlocProvider(
        create: (_) => CartCubit(),
        child: const CartScreen(),
      ),
      _ => throw FlutterError('Unknown route: ${settings.name}'),
    };

    return MaterialPageRoute<void>(settings: settings, builder: (_) => child);
  }
}
