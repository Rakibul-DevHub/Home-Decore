import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/kolek_colors.dart';

class NavItem {
  const NavItem({
    required this.label,
    required this.iconOutline,
    required this.iconFilled,
  });

  final String label;
  final String iconOutline;
  final String iconFilled;
}

class KolekBottomNav extends StatefulWidget {
  const KolekBottomNav({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const indicatorColor = Color(0xFF2B7FFF);

  static const items = [
    NavItem(
      label: 'Home',
      iconOutline: 'assets/icons/home.svg',
      iconFilled: 'assets/icons/home_active.svg',
    ),
    NavItem(
      label: 'Search',
      iconOutline: 'assets/icons/search.svg',
      iconFilled: 'assets/icons/search_active.svg',
    ),
    NavItem(
      label: 'Add',
      iconOutline: 'assets/icons/add.svg',
      iconFilled: 'assets/icons/add_active.svg',
    ),
    NavItem(
      label: 'Messages',
      iconOutline: 'assets/icons/message.svg',
      iconFilled: 'assets/icons/message_active.svg',
    ),
    NavItem(
      label: 'Profile',
      iconOutline: 'assets/icons/profile.svg',
      iconFilled: 'assets/icons/profile_active.svg',
    ),
  ];

  @override
  State<KolekBottomNav> createState() => _KolekBottomNavState();
}

class _KolekBottomNavState extends State<KolekBottomNav>
    with SingleTickerProviderStateMixin {
  static const _slotHeight = 12.0;
  static const _barHeight = 3.0;
  static const _duration = Duration(milliseconds: 320);

  late final AnimationController _controller;
  late final Animation<double> _progress;

  /// Tab that is becoming selected.
  late int _currentIndex;

  /// Tab that is giving up the underline.
  late int _previousIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
    _previousIndex = widget.selectedIndex;
    _controller = AnimationController(vsync: this, duration: _duration);
    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    // Settled: underline already under the current tab.
    _controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant KolekBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) return;

    _previousIndex = oldWidget.selectedIndex;
    _currentIndex = widget.selectedIndex;
    // One shared timeline: previous goes down while current comes up.
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Shared progress `t` (0 → 1):
  /// - previous: dy = t * slot   (visible → hidden downward)
  /// - current:  dy = (1-t)*slot (hidden → visible upward)
  /// - others:   fully hidden
  double _dyFor(int index, double t) {
    if (index == _currentIndex) return (1 - t) * _slotHeight;
    if (index == _previousIndex && _previousIndex != _currentIndex) {
      return t * _slotHeight;
    }
    return _slotHeight;
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final background = dark ? const Color(0xFF0A0A0A) : Colors.white;
    final line = dark ? const Color(0xFF2A2A2A) : KolekColors.neutral200;
    final icon = dark ? const Color(0xFFE8E8E8) : const Color(0xFF171717);

    return Material(
      color: background,
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: line)),
          ),
          child: AnimatedBuilder(
            animation: _progress,
            builder: (context, _) {
              final t = _progress.value;
              return Row(
                children: List.generate(KolekBottomNav.items.length, (index) {
                  return Expanded(
                    child: _buildNavItem(
                      index,
                      KolekBottomNav.items[index],
                      _dyFor(index, t),
                      icon,
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    NavItem item,
    double underlineDy,
    Color iconColor,
  ) {
    final isSelected = widget.selectedIndex == index;
    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        key: ValueKey('bottom-nav-$index'),
        onTap: () => widget.onSelected(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: SvgPicture.asset(
                    isSelected ? item.iconFilled : item.iconOutline,
                    key: ValueKey('${item.label}-$isSelected'),
                    width: 22,
                    height: 22,
                    colorFilter: isSelected
                        ? null
                        : ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            ///
            /// ----- selected bottom index underline ------
            ///
            SizedBox(
              height: _slotHeight,
              width: double.infinity,
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(0, underlineDy),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 0, // ----- controll underline width -----
                      height: _barHeight,
                      decoration: BoxDecoration(
                        color: KolekBottomNav.indicatorColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
