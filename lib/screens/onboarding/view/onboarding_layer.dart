part of 'onboarding_screen.dart';

class _OnboardingLayerSwitcher extends StatelessWidget {
  const _OnboardingLayerSwitcher({
    required this.page,
    required this.isForward,
    required this.moveDownOnForward,
    required this.child,
  });

  final int page;
  final bool isForward;

  /// Text moves down on next. Image moves up on next.
  final bool moveDownOnForward;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final distance = (isForward == moveDownOnForward) ? 0.22 : -0.22;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            ?currentChild,
          ],
        );
      },
      transitionBuilder: (child, animation) {
        final offset = Tween<Offset>(
          begin: Offset(0, distance),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offset,
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(page),
        child: child,
      ),
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
