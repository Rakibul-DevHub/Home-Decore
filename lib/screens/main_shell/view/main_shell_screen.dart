import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../widgets/bottom_nav.dart';
import '../../home/view/home_screen.dart';
import '../../messages/view/messages_screen.dart';
import '../../profile/view/profile_screen.dart';
import '../../shop/view/shop_screen.dart';
import '../cubit/main_shell_cubit.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  static const _tabs = [0, 1, 3, 4];

  late final PageController _pages;

  @override
  void initState() {
    super.initState();
    final index = context.read<MainShellCubit>().state.selectedIndex;
    _pages = PageController(initialPage: _pageOf(index));
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  int _pageOf(int navIndex) {
    final page = _tabs.indexOf(navIndex);
    return page < 0 ? 0 : page;
  }

  void _onNavSelected(int index) {
    if (index == 2) {
      Navigator.of(context).pushNamed(AppRoute.create);
      return;
    }
    context.read<MainShellCubit>().switchTab(index);
  }

  void _onPageChanged(int page) {
    context.read<MainShellCubit>().switchTab(_tabs[page]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainShellCubit, MainShellState>(
      listenWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex,
      listener: (context, state) {
        final page = _pageOf(state.selectedIndex);
        if (!_pages.hasClients || _pages.page?.round() == page) return;
        _pages.animateToPage(
          page,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppearancePage.background(context),
          body: PageView(
            controller: _pages,
            onPageChanged: _onPageChanged,
            children: const [
              _KeptTab(child: HomeScreen()),
              _KeptTab(child: ShopScreen()),
              _KeptTab(child: MessagesScreen()),
              _KeptTab(child: ProfileScreen()),
            ],
          ),
          bottomNavigationBar: KolekBottomNav(
            selectedIndex: state.selectedIndex,
            onSelected: _onNavSelected,
          ),
        );
      },
    );
  }
}

class _KeptTab extends StatefulWidget {
  const _KeptTab({required this.child});

  final Widget child;

  @override
  State<_KeptTab> createState() => _KeptTabState();
}

class _KeptTabState extends State<_KeptTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
