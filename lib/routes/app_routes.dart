import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolek/screens/create/bloc/create_bloc.dart';
import 'package:kolek/screens/create_post/bloc/new_post_bloc.dart';
import 'package:kolek/screens/messages/bloc/inbox_bloc.dart';
import 'package:kolek/screens/profile/bloc/profile_bloc.dart';
import 'package:kolek/screens/shop/bloc/filter_bloc.dart';
import 'package:kolek/screens/shop/bloc/shop_bloc.dart';
import '../screens/list_product/bloc/list_product_bloc.dart';
import '../screens/list_product/view/list_product_screen.dart';
import '../screens/auth/create_account/bloc/create_account_bloc.dart';
import '../screens/auth/create_account/view/create_account_screen.dart';
import '../screens/auth/forgot_password/bloc/forgot_password_bloc.dart';
import '../screens/auth/forgot_password/view/forgot_password_screen.dart';
import '../screens/auth/new_password/bloc/new_password_bloc.dart';
import '../screens/auth/new_password/view/new_password_screen.dart';
import '../screens/auth/otp_verification/bloc/otp_verification_bloc.dart';
import '../screens/auth/otp_verification/view/otp_verification_screen.dart';
import '../screens/auth/set_password/bloc/set_password_bloc.dart';
import '../screens/auth/set_password/view/set_password_screen.dart';
import '../screens/auth/welcome/bloc/welcome_bloc.dart';
import '../screens/auth/welcome/view/welcome_screen.dart';
import '../screens/messages/bloc/message_bloc.dart';
import '../screens/onboarding/bloc/onboarding_bloc.dart';
import '../screens/onboarding/view/onboarding_screen.dart';
import '../screens/cart/cubit/cart_cubit.dart';
import '../screens/cart/view/cart_screen.dart';
import '../screens/create/view/create_screen.dart';
import '../screens/create_post/view/new_post_media_screen.dart';
import '../screens/profile/bloc/menu_bloc.dart';
import '../screens/profile/view/menu_screen.dart';
import '../screens/settings/bloc/settings_bloc.dart';
import '../screens/settings/view/settings_screen.dart';
import '../screens/shop/view/shop_filter_screen.dart';
import '../screens/home/bloc/home_bloc.dart';
import '../screens/messages/view/inbox_screen.dart';
import '../screens/main_shell/cubit/main_shell_cubit.dart';
import '../screens/main_shell/view/main_shell_screen.dart';
import '../screens/messages/data/messages_data.dart';
import '../screens/notification/bloc/notification_bloc.dart';
import '../screens/notification/view/notification_screen.dart';
import '../screens/product_details/cubit/product_details_cubit.dart';
import '../screens/product_details/view/product_details_screen.dart';
import '../screens/search/bloc/search_bloc.dart';
import '../screens/search/view/search_screen.dart';
import '../screens/shop/view/shop_screen.dart';
import '../screens/splash/bloc/splash_bloc.dart';
import '../screens/splash/bloc/splash_event.dart';
import '../screens/splash/view/splash_screen.dart';
import '../screens/saved/bloc/saved_bloc.dart';
import '../screens/saved/view/saved_screen.dart';
import '../screens/orders/bloc/orders_bloc.dart';
import '../screens/orders/view/orders_screen.dart';
import '../screens/selling/bloc/selling_bloc.dart';
import '../screens/selling/view/selling_screen.dart';
import '../screens/bids_menu/bloc/bids_menu_bloc.dart';
import '../screens/bids_menu/view/bids_menu_screen.dart';
import '../screens/invite_friends/bloc/invite_friends_bloc.dart';
import '../screens/invite_friends/view/invite_friends_screen.dart';

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
  static const notifications = '/notifications';
  static const menu = '/menu';
  static const settings = '/settings';
  static const listProduct = '/list-product';
  static const saved = '/saved';
  static const orders = '/orders';
  static const selling = '/selling';
  static const bidsMenu = '/bids';
  static const inviteFriends = '/invite-friends';

  /// Override in tests before pumping [KolekApp].
  static Duration splashDuration = const Duration(milliseconds: 1600);

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => BlocProvider(
      create: (_) => SplashBloc(duration: splashDuration)
        ..add(const SplashStarted()),
      child: const SplashScreen(),
    ),
    onboarding: (_) => BlocProvider(
      create: (_) => OnboardingBloc(),
      child: const OnboardingScreen(),
    ),
    signIn: (_) => BlocProvider(
      create: (_) => WelcomeBloc(),
      child: const WelcomeScreen(),
    ),
    createAccount: (_) => BlocProvider(
      create: (_) => CreateAccountBloc(),
      child: const CreateAccountScreen(),
    ),
    forgotPassword: (_) => BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: const ForgotPasswordScreen(),
    ),
    otpVerification: (_) => BlocProvider(
      create: (_) => OtpVerificationBloc(),
      child: const OtpVerificationScreen(),
    ),
    newPassword: (_) => BlocProvider(
      create: (_) => NewPasswordBloc(),
      child: const NewPasswordScreen(),
    ),
    setPassword: (_) => BlocProvider(
      create: (_) => SetPasswordBloc(),
      child: const SetPasswordScreen(),
    ),
    mainShell: (_) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainShellCubit()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => ShopBloc()),
        BlocProvider(create: (_) => MessagesBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: const MainShellScreen(),
    ),
    inbox: (context) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final thread = args is MessageThread
          ? args
          : MessagesData.threads.first;
      return BlocProvider(
        create: (_) => InboxBloc(thread: thread),
        child: const InboxScreen(),
      );
    },
    search: (_) => BlocProvider(
      create: (_) => SearchBloc(),
      child: const SearchScreen(),
    ),
    shop: (_) => BlocProvider(
      create: (_) => ShopBloc(),
      child: const ShopScreen(),
    ),
    filter: (_) => BlocProvider(
      create: (_) => FilterBloc(),
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
      create: (_) => CreateBloc(),
      child: const CreateScreen(),
    ),
    newPost: (_) => BlocProvider(
      create: (_) => NewPostBloc(),
      child: const NewPostMediaScreen(),
    ),
    notifications: (_) => BlocProvider(
      create: (_) => NotificationBloc(),
      child: const NotificationScreen(),
    ),
    menu: (_) => BlocProvider(
      create: (_) => MenuBloc(),
      child: const MenuScreen(),
    ),
    settings: (_) => BlocProvider(
      create: (_) => SettingsBloc(),
      child: const SettingsScreen(),
    ),
    listProduct: (_) => BlocProvider(
      create: (_) => ListProductBloc(),
      child: const ListProductScreen(),
    ),
    saved: (_) => BlocProvider(
      create: (_) => SavedBloc(),
      child: const SavedScreen(),
    ),
    orders: (_) => BlocProvider(
      create: (_) => OrdersBloc(),
      child: const OrdersScreen(),
    ),
    selling: (_) => BlocProvider(
      create: (_) => SellingBloc(),
      child: const SellingScreen(),
    ),
    bidsMenu: (_) => BlocProvider(
      create: (_) => BidsMenuBloc(),
      child: const BidsMenuScreen(),
    ),
    inviteFriends: (_) => BlocProvider(
      create: (_) => InviteFriendsBloc(),
      child: const InviteFriendsScreen(),
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