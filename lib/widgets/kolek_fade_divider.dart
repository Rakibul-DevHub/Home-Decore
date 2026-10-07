import 'package:flutter/cupertino.dart';

import '../screens/appearance/appearance_page.dart';

/// Hairline separator that fades to transparent at both ends.
///
/// Use instead of [Divider] when a hard-edged line would feel too
/// heavy — e.g. above a footer action, between list sections, or under
/// a "Save as Draft" link.
class KolekFadeDivider extends StatelessWidget {
  const KolekFadeDivider({
    super.key,
    this.height = 0.5,
    this.fadeStart = 0.25,
    this.fadeEnd = 0.75,
    this.color,
  }) : assert(
  fadeStart >= 0 && fadeStart <= 1,
  'fadeStart must be between 0 and 1',
  ),
        assert(
        fadeEnd >= 0 && fadeEnd <= 1,
        'fadeEnd must be between 0 and 1',
        ),
        assert(
        fadeStart <= fadeEnd,
        'fadeStart must be less than or equal to fadeEnd',
        );

  /// Line thickness in logical pixels. Defaults to a hairline.
  final double height;

  /// Fraction of the width where the line reaches full opacity.
  /// 0.0 = solid from the very left edge.
  final double fadeStart;

  /// Fraction of the width where the line begins fading back out.
  /// 1.0 = solid all the way to the right edge.
  final double fadeEnd;

  /// Line color. Defaults to the current theme's line color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppearancePage.line(context);
    return SizedBox(
      height: height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              c.withValues(alpha: 0.0),
              c.withValues(alpha: 1.0),
              c.withValues(alpha: 1.0),
              c.withValues(alpha: 0.0),
            ],
            stops: [0.0, fadeStart, fadeEnd, 1.0],
          ),
        ),
      ),
    );
  }
}