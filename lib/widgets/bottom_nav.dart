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
                  duration: const Duration(milliseconds: 180),
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
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeOutCubic,
                  offset: isSelected ? Offset.zero : const Offset(0, 1.4),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: isSelected ? 1 : 0,
                    child: Container(
                      width: 22,
                      height: 3,
                      decoration: BoxDecoration(
                        color: indicatorColor,
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
