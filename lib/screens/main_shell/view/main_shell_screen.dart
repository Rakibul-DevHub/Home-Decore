import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/bottom_nav.dart';
import '../../../widgets/kolek_widgets.dart';
import '../../home/view/home_screen.dart';
import '../../search/view/search_screen.dart';
import '../cubit/main_shell_cubit.dart';
import '../data/main_shell_data.dart';

class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

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
              const SearchScreen(),
              _PlaceholderScreen(title: MainShellData.tabLabels[2]),
              _PlaceholderScreen(title: MainShellData.tabLabels[3]),
              _PlaceholderScreen(title: MainShellData.tabLabels[4]),
            ],
          ),
          bottomNavigationBar: KolekBottomNav(
            selectedIndex: selectedIndex,
            onSelected: context.read<MainShellCubit>().switchTab,
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
