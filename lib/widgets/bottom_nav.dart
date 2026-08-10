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

class KolekBottomNav extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: KolekColors.neutral200)),
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              return Expanded(
                child: _buildNavItem(index, items[index]),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, NavItem item) {
    final isSelected = selectedIndex == index;

    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: InkWell(
        key: ValueKey('bottom-nav-$index'),
        onTap: () => onSelected(index),
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
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
              width: double.infinity,
              child: _UnderlineIndicator(
                key: ValueKey('underline-$index'),
                visible: isSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Per-tab bar: selected rises from bottom; deselected drops downward.
class _UnderlineIndicator extends StatelessWidget {
  const _UnderlineIndicator({required this.visible, super.key});

  final bool visible;

  static const _slotHeight = 12.0;
  static const _barHeight = 3.0;
  static const _duration = Duration(milliseconds: 320);

  @override
  Widget build(BuildContext context) {
    // Travel the full slot (not the 3px bar), so the motion is clearly vertical.
    final hiddenOffset = _slotHeight;

    return ClipRect(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: hiddenOffset,
          end: visible ? 0 : hiddenOffset,
        ),
        duration: _duration,
        curve: visible ? Curves.easeOutCubic : Curves.easeInCubic,
        builder: (context, dy, child) {
          return Transform.translate(
            offset: Offset(0, dy),
            child: child,
          );
        },
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 22,
            height: _barHeight,
            decoration: BoxDecoration(
              color: KolekBottomNav.indicatorColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
