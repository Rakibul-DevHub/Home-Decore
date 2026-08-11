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
import '../screens/create/cubit/create_cubit.dart';
import '../screens/create/view/create_screen.dart';
import '../screens/create_post/cubit/new_post_cubit.dart';
import '../screens/create_post/view/new_post_media_screen.dart';
import '../screens/filter/cubit/filter_cubit.dart';
import '../screens/filter/view/filter_screen.dart';
import '../screens/home/cubit/home_cubit.dart';
import '../screens/inbox/cubit/inbox_cubit.dart';
import '../screens/inbox/view/inbox_screen.dart';
import '../screens/main_shell/cubit/main_shell_cubit.dart';
import '../screens/main_shell/view/main_shell_screen.dart';
import '../screens/messages/cubit/messages_cubit.dart';
import '../screens/messages/data/messages_data.dart';
import '../screens/product_details/cubit/product_details_cubit.dart';
import '../screens/product_details/view/product_details_screen.dart';
import '../screens/search/cubit/search_cubit.dart';
import '../screens/search/view/search_screen.dart';
import '../screens/shop/cubit/shop_cubit.dart';
import '../screens/shop/view/shop_screen.dart';
import '../screens/splash/cubit/splash_cubit.dart';
import '../screens/splash/view/splash_screen.dart';

/// App route names + route table (Tag-style `AppRoutes`).
abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const createAccount = '/create-account';
  static const forgotPassword = '/forgot-password';
  static const otpVerification = '/otp-verification';
  static const newPassword = '/new-password';
  static const setPassword = '/set-password';
  static const mainShell = '/main';
  static const search = '/search';
  static const shop = '/shop';
  static const filter = '/filter';
  static const productDetails = '/product-details';
  static const cart = '/cart';
  static const create = '/create';
  static const newPost = '/new-post';
  static const newPostDetails = '/new-post-details';
  static const inbox = '/inbox';

  /// Override in tests before pumping [KolekApp].
  static Duration splashDuration = const Duration(milliseconds: 1600);

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => BlocProvider(
      create: (_) => SplashCubit(duration: splashDuration)..start(),
      child: const SplashScreen(),
    ),
    onboarding: (_) => BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const OnboardingScreen(),
    ),
    signIn: (_) => BlocProvider(
      create: (_) => WelcomeCubit(),
      child: const WelcomeScreen(),
    ),
    createAccount: (_) => BlocProvider(
      create: (_) => CreateAccountCubit(),
      child: const CreateAccountScreen(),
    ),
    forgotPassword: (_) => BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: const ForgotPasswordScreen(),
    ),
    otpVerification: (_) => BlocProvider(
      create: (_) => OtpVerificationCubit(),
      child: const OtpVerificationScreen(),
    ),
    newPassword: (_) => BlocProvider(
      create: (_) => NewPasswordCubit(),
      child: const NewPasswordScreen(),
    ),
    setPassword: (_) => BlocProvider(
      create: (_) => SetPasswordCubit(),
      child: const SetPasswordScreen(),
    ),
    mainShell: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainShellCubit()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ShopCubit()),
        BlocProvider(create: (_) => MessagesCubit()),
      ],
      child: const MainShellScreen(),
    ),
    inbox: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final thread = args is MessageThread
          ? args
          : MessagesData.threads.first;
      return BlocProvider(
        create: (_) => InboxCubit(thread: thread),
        child: const InboxScreen(),
      );
    },
    search: (_) => BlocProvider(
      create: (_) => SearchCubit(),
      child: const SearchScreen(),
    ),
    shop: (_) => BlocProvider(
      create: (_) => ShopCubit(),
      child: const ShopScreen(),
    ),
    filter: (_) => BlocProvider(
      create: (_) => FilterCubit(),
      child: const FilterScreen(),
    ),
    productDetails: (_) => BlocProvider(
      create: (_) => ProductDetailsCubit(),
      child: const ProductDetailsScreen(),
    ),
    cart: (_) => BlocProvider(
      create: (_) => CartCubit(),
      child: const CartScreen(),
    ),
    create: (_) => BlocProvider(
      create: (_) => CreateCubit(),
      child: const CreateScreen(),
    ),
    newPost: (_) => BlocProvider(
      create: (_) => NewPostCubit(),
      child: const NewPostMediaScreen(),
    ),
  };

  /// Opens only [initialRoute] (so `/main` does not also push `/`).
  static List<Route<dynamic>> onGenerateInitialRoutes(String initialRoute) {
    final builder = routes[initialRoute];
    if (builder == null) {
      throw FlutterError('Unknown route: $initialRoute');
    }
    return [
      MaterialPageRoute<void>(
        settings: RouteSettings(name: initialRoute),
        builder: builder,
      ),
    ];
  }
}

/// Backward-compatible alias used by older call sites.
typedef AppRoute = AppRoutes;
