import 'package:flutter/material.dart';

/// Scales the existing screen layouts to the device size without changing
/// their design. Screens keep laying out at [designWidth]; [LayoutBuilder]
/// then fits that canvas to the real width.
class KolekFitLayout extends StatelessWidget {
  const KolekFitLayout({super.key, required this.child});

  /// Reference width the current UI was built against.
  static const double designWidth = 390;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = _finite(
          constraints.maxWidth,
          fallback: media.size.width,
        );
        final maxHeight = _finite(
          constraints.maxHeight,
          fallback: media.size.height,
        );
        if (maxWidth <= 0 || maxHeight <= 0) {
          return child;
        }

        final scale = maxWidth / designWidth;
        final designHeight = maxHeight / scale;

        return FittedBox(
          fit: BoxFit.fill,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: designWidth,
            height: designHeight,
            child: MediaQuery(
              data: media.copyWith(
                size: Size(designWidth, designHeight),
                padding: media.padding / scale,
                viewPadding: media.viewPadding / scale,
                viewInsets: media.viewInsets / scale,
                systemGestureInsets: media.systemGestureInsets / scale,
                textScaler: media.textScaler.clamp(
                  minScaleFactor: 0.85,
                  maxScaleFactor: 1.25,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  static double _finite(double value, {required double fallback}) {
    if (value.isFinite && value > 0) {
      return value;
    }
    return fallback;
  }
}
