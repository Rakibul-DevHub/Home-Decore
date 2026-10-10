// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../screens/appearance/appearance_page.dart';
//
// class NavItem {
//   const NavItem({
//     required this.label,
//     required this.iconOutline,
//     required this.iconFilled,
//   });
//
//   final String label;
//   final String iconOutline;
//   final String iconFilled;
// }
//
// class KolekBottomNav extends StatefulWidget {
//   const KolekBottomNav({
//     required this.selectedIndex,
//     required this.onSelected,
//     this.visible = true,
//     super.key,
//   });
//
//   final int selectedIndex;
//   final ValueChanged<int> onSelected;
//
//   /// Whether the bar is currently revealed. The shell toggles this based
//   /// on scroll direction: false while scrolling down, true while scrolling up.
//   final bool visible;
//
//   static const indicatorColor = Color(0xFF2B7FFF);
//
//   static const items = [
//     NavItem(
//       label: 'Home',
//       iconOutline: 'assets/icons/home.svg',
//       iconFilled: 'assets/icons/home_active.svg',
//     ),
//     NavItem(
//       label: 'Search',
//       iconOutline: 'assets/icons/search.svg',
//       iconFilled: 'assets/icons/search_active.svg',
//     ),
//     NavItem(
//       label: 'Add',
//       iconOutline: 'assets/icons/add.svg',
//       iconFilled: 'assets/icons/add_active.svg',
//     ),
//     NavItem(
//       label: 'Messages',
//       iconOutline: 'assets/icons/message.svg',
//       iconFilled: 'assets/icons/message_active.svg',
//     ),
//     NavItem(
//       label: 'Profile',
//       iconOutline: 'assets/icons/profile.svg',
//       iconFilled: 'assets/icons/profile_active.svg',
//     ),
//   ];
//
//   @override
//   State<KolekBottomNav> createState() => _KolekBottomNavState();
// }
//
// class _KolekBottomNavState extends State<KolekBottomNav>
//     with SingleTickerProviderStateMixin {
//   static const _slotHeight = 12.0;
//   static const _barHeight = 3.0;
//   static const _duration = Duration(milliseconds: 320);
//   static const _hideDuration = Duration(milliseconds: 220);
//
//   late final AnimationController _controller;
//   late final Animation<double> _progress;
//
//   /// Tab that is becoming selected.
//   late int _currentIndex;
//
//   /// Tab that is giving up the underline.
//   late int _previousIndex;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex;
//     _previousIndex = widget.selectedIndex;
//     _controller = AnimationController(vsync: this, duration: _duration);
//     _progress = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOutCubic,
//     );
//     _controller.value = 1;
//   }
//
//   @override
//   void didUpdateWidget(covariant KolekBottomNav oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedIndex == widget.selectedIndex) return;
//
//     _previousIndex = oldWidget.selectedIndex;
//     _currentIndex = widget.selectedIndex;
//     _controller.forward(from: 0);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   double _dyFor(int index, double t) {
//     if (index == _currentIndex) return (1 - t) * _slotHeight;
//     if (index == _previousIndex && _previousIndex != _currentIndex) {
//       return t * _slotHeight;
//     }
//     return _slotHeight;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final background = AppearancePage.background(context);
//     final line = AppearancePage.line(context);
//     final icon = AppearancePage.icon(context);
//
//     // `AnimatedAlign` with `heightFactor` smoothly collapses the bar's
//     // vertical space to zero when hidden — so the body expands into the
//     // freed space, instead of the bar sliding over it.
//     return ClipRect(
//       child: AnimatedAlign(
//         alignment: Alignment.bottomCenter,
//         heightFactor: widget.visible ? 1.0 : 0.0,
//         duration: _hideDuration,
//         curve: Curves.easeOutCubic,
//         child: Material(
//           color: background,
//           child: SafeArea(
//             top: false,
//             child: Container(
//               height: 64,
//               decoration: BoxDecoration(
//                 border: Border(top: BorderSide(color: line)),
//               ),
//               child: AnimatedBuilder(
//                 animation: _progress,
//                 builder: (context, _) {
//                   final t = _progress.value;
//                   return Row(
//                     children: List.generate(
//                       KolekBottomNav.items.length,
//                           (index) {
//                         return Expanded(
//                           child: _buildNavItem(
//                             index,
//                             KolekBottomNav.items[index],
//                             _dyFor(index, t),
//                             icon,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(
//       int index,
//       NavItem item,
//       double underlineDy,
//       Color iconColor,
//       ) {
//     final isSelected = widget.selectedIndex == index;
//     return Semantics(
//       button: true,
//       selected: isSelected,
//       label: item.label,
//       child: InkWell(
//         key: ValueKey('bottom-nav-$index'),
//         onTap: () => widget.onSelected(index),
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         child: Column(
//           children: [
//             Expanded(
//               child: Center(
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 160),
//                   transitionBuilder: (child, animation) {
//                     return FadeTransition(opacity: animation, child: child);
//                   },
//                   child: SvgPicture.asset(
//                     isSelected ? item.iconFilled : item.iconOutline,
//                     key: ValueKey('${item.label}-$isSelected'),
//                     width: 22,
//                     height: 22,
//                     colorFilter: isSelected
//                         ? null
//                         : ColorFilter.mode(iconColor, BlendMode.srcIn),
//                   ),
//                 ),
//               ),
//             ),
//
//             /// ----- selected bottom index underline -----
//             SizedBox(
//               height: _slotHeight,
//               width: double.infinity,
//               child: ClipRect(
//                 child: Transform.translate(
//                   offset: Offset(0, underlineDy),
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Container(
//                       width: 0, // ----- control underline width -----
//                       height: _barHeight,
//                       decoration: BoxDecoration(
//                         color: KolekBottomNav.indicatorColor,
//                         borderRadius: BorderRadius.circular(2),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/appearance/appearance_page.dart';

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
    this.visible = true,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// Whether the bar is currently revealed. The shell toggles this based
  /// on scroll direction: false while scrolling down, true while scrolling up.
  final bool visible;

  static const indicatorColor = Color(0xFF2B7FFF);

  static const items = [
    NavItem(
      label: 'Home',
      iconOutline: 'assets/icons/home.svg',
      iconFilled: 'assets/icons/home_active.svg',
    ),
    NavItem(
      label: 'Search',
      iconOutline: 'assets/icons/shop.svg',
      iconFilled: 'assets/icons/shop_active.svg',
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
  static const _hideDuration = Duration(milliseconds: 220);

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
    _controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant KolekBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) return;

    _previousIndex = oldWidget.selectedIndex;
    _currentIndex = widget.selectedIndex;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _dyFor(int index, double t) {
    if (index == _currentIndex) return (1 - t) * _slotHeight;
    if (index == _previousIndex && _previousIndex != _currentIndex) {
      return t * _slotHeight;
    }
    return _slotHeight;
  }

  @override
  Widget build(BuildContext context) {
    final background = AppearancePage.background(context);
    final line = AppearancePage.line(context);
    final icon = AppearancePage.icon(context);

    // `AnimatedAlign` with `heightFactor` smoothly collapses the bar's
    // vertical space to zero when hidden — so the body expands into the
    // freed space, instead of the bar sliding over it.
    return ClipRect(
      child: AnimatedAlign(
        alignment: Alignment.bottomCenter,
        heightFactor: widget.visible ? 1.0 : 0.0,
        duration: _hideDuration,
        curve: Curves.easeOutCubic,
        child: Material(
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
                    children: List.generate(
                      KolekBottomNav.items.length,
                          (index) {
                        return Expanded(
                          child: _buildNavItem(
                            index,
                            KolekBottomNav.items[index],
                            _dyFor(index, t),
                            icon,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
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
      child: GestureDetector(
        key: ValueKey('bottom-nav-$index'),
        // `opaque` makes the whole cell area tappable, not just the
        // visible children — same reach as the previous InkWell.
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onSelected(index),
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

            /// ----- selected bottom index underline -----
            SizedBox(
              height: _slotHeight,
              width: double.infinity,
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(0, underlineDy),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 0, // ----- control underline width -----
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