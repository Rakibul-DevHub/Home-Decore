part of 'onboarding_screen.dart';

/// Smart-animates a layer the way Figma does: matched "Test" / "Image"
/// frames interpolate from the previous page Y to the next page Y,
/// while content cross-fades. Outgoing keeps traveling — it does not
/// slide back.
class _OnboardingLayerSwitcher extends StatefulWidget {
  const _OnboardingLayerSwitcher({
    required this.page,
    required this.tops,
    required this.builder,
  });

  final int page;
  final List<double> tops;
  final Widget Function(int index) builder;

  @override
  State<_OnboardingLayerSwitcher> createState() =>
      _OnboardingLayerSwitcherState();
}

class _OnboardingLayerSwitcherState extends State<_OnboardingLayerSwitcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;

  late int _fromPage;
  late int _toPage;

  @override
  void initState() {
    super.initState();
    _fromPage = widget.page;
    _toPage = widget.page;
    _controller = AnimationController(
      vsync: this,
      duration: OnboardingData.transitionDuration,
    );
    _t = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant _OnboardingLayerSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page == widget.page) return;

    _fromPage = oldWidget.page;
    _toPage = widget.page;

    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      _controller.value = 1;
      return;
    }
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _top(int page) => widget.tops[page.clamp(0, widget.tops.length - 1)];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _t,
      builder: (context, _) {
        final incoming = _t.value;
        final outgoing = 1 - incoming;
        final fromTop = _top(_fromPage);
        final toTop = _top(_toPage);
        final delta = toTop - fromTop;

        return Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          children: [
            if (outgoing > 0 && _fromPage != _toPage)
              IgnorePointer(
                child: Opacity(
                  opacity: outgoing,
                  child: Transform.translate(
                    offset: Offset(0, delta * incoming),
                    child: widget.builder(_fromPage),
                  ),
                ),
              ),
            Opacity(
              opacity: _fromPage == _toPage ? 1 : incoming,
              child: Transform.translate(
                offset: Offset(0, -delta * outgoing),
                child: widget.builder(_toPage),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OnboardingTextLayer extends StatelessWidget {
  const _OnboardingTextLayer({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _Page1Text(),
      1 => const _Page2Text(),
      2 => const _Page3Text(),
      3 => const _Page4Text(),
      _ => const _Page5Text(),
    };
  }
}

class _OnboardingImageLayer extends StatelessWidget {
  const _OnboardingImageLayer({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _Page1Image(),
      1 => const _Page2Image(),
      2 => const _Page3Image(),
      3 => const _Page4Image(),
      _ => const _Page5Image(),
    };
  }
}
