part of 'onboarding_screen.dart';

class _PageNumber extends StatelessWidget {
  const _PageNumber({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final label = (index + 1).toString().padLeft(2, '0');
    return Positioned(
      left: 20,
      top: 88,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'IBMPlexMono-Regular',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: KolekScheme.text(context, KolekColors.neutral700),
          letterSpacing: -0.4,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onSkip,
    this.showSkip = true,
  });

  final VoidCallback onSkip;
  final bool showSkip;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const KolekLogo(),
          if (showSkip)
            InkWell(
              onTap: onSkip,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: KolekScheme.text(context, KolekColors.neutral700),
                    ),
                  ),
                ),
                child: Text(
                  OnboardingData.skip,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KolekScheme.text(context, KolekColors.neutral500),
                    height: 20 / 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.index, required this.onSignIn});

  final int index;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    if (index == OnboardingData.pages.length - 1) {
      return Positioned(
        left: 20,
        right: 20,
        bottom: 16,
        child: Column(
          children: [
            _Dots(index: index),
            const SizedBox(height: 16),
            KolekButton(
              label: OnboardingData.getStarted,
              onPressed: onSignIn,
              labelStyle: const TextStyle(
                fontFamily: OnboardingData.getStartedFontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Positioned(
      left: 20,
      right: 20,
      bottom: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Dots(index: index),
          Semantics(
            button: true,
            label: 'Next onboarding page',
            child: InkWell(
              onTap: () {
                context
                    .read<OnboardingBloc>()
                    .add(const OnboardingNextPressed());
              },
              customBorder: const CircleBorder(),
              child: SvgPicture.asset(
                KolekScheme.isDark(context)
                    ? OnboardingData.arrowAssetDark
                    : OnboardingData.arrowAsset,
                width: 56,
                height: 56,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(OnboardingData.pages.length, (dot) {
        return Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(
            right: dot == OnboardingData.pages.length - 1 ? 0 : 10,
          ),
          decoration: BoxDecoration(
            color: dot == index ? KolekColors.blue600 : KolekColors.neutral300,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
