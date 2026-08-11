import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/bottom_nav.dart';
import '../../../widgets/kolek_widgets.dart';
import '../../home/view/home_screen.dart';
import '../../messages/view/messages_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../shop/view/shop_screen.dart';
import '../cubit/main_shell_cubit.dart';
import '../data/main_shell_data.dart';

class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  void _onNavSelected(BuildContext context, int index) {
    if (index == 2) {
      Navigator.of(context).pushNamed(AppRoute.create);
      return;
    }
    context.read<MainShellCubit>().switchTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainShellCubit, MainShellState>(
      builder: (context, state) {
        final selectedIndex = state.selectedIndex;
        return Scaffold(
          backgroundColor: KolekColors.neutral50,
          body: IndexedStack(
            index: selectedIndex,
            children: [
              const HomeScreen(),
              const ShopScreen(),
              _PlaceholderScreen(title: MainShellData.tabLabels[2]),
              const MessagesScreen(),
              const ProfileScreen(),
            ],
          ),
          bottomNavigationBar: KolekBottomNav(
            selectedIndex: selectedIndex,
            onSelected: (index) => _onNavSelected(context, index),
          ),
        );
      },
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(title, style: KolekText.sans(size: 18)),
      ),
    );
  }
}
