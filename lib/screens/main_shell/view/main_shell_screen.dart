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

  /// Number of pixels of vertical scroll that counts as "scrolling down"
  /// (or up). Keeps tiny jitters from toggling the bar.
  static const _scrollThreshold = 4.0;

  late final PageController _pages;

  /// Whether the bottom navigation bar is currently revealed.
  bool _navVisible = true;

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
    // Reveal the bar whenever the user picks a tab.
    if (!_navVisible) {
      setState(() => _navVisible = true);
    }
  }

  void _onPageChanged(int page) {
    context.read<MainShellCubit>().switchTab(_tabs[page]);
  }

  /// Watches scroll events bubbling up from any *vertical* scrollable
  /// inside the current tab. Horizontal notifications (from the PageView
  /// itself) are ignored.
  bool _onScroll(ScrollNotification n) {
    // PageView is horizontal — ignore it so swiping between tabs
    // doesn't hide the bar.
    if (n.metrics.axis != Axis.vertical) return false;
    if (n is! ScrollUpdateNotification) return false;

    final delta = n.scrollDelta ?? 0;
    final m = n.metrics;

    // Always reveal when we're at the very top of the list.
    if (m.pixels <= m.minScrollExtent + 4) {
      if (!_navVisible) setState(() => _navVisible = true);
      return false;
    }

    // Scrolling down → hide. Scrolling up → show.
    if (delta > _scrollThreshold && _navVisible) {
      setState(() => _navVisible = false);
    } else if (delta < -_scrollThreshold && !_navVisible) {
      setState(() => _navVisible = true);
    }
    return false;
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
          body: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: PageView(
              controller: _pages,
              onPageChanged: _onPageChanged,
              children: const [
                _KeptTab(child: HomeScreen()),
                _KeptTab(child: ShopScreen()),
                _KeptTab(child: MessagesScreen()),
                _KeptTab(child: ProfileScreen()),
              ],
            ),
          ),
          bottomNavigationBar: KolekBottomNav(
            selectedIndex: state.selectedIndex,
            onSelected: _onNavSelected,
            visible: _navVisible,
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