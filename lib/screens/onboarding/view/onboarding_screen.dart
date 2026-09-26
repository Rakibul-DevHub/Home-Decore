import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../data/onboarding_data.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _openSignIn(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.background,
      body: SafeArea(
        child: BlocConsumer<OnboardingBloc, OnboardingState>(
          listenWhen: (previous, current) =>
              !previous.finished && current.finished,
          listener: (context, state) => _openSignIn(context),
          builder: (context, state) {
            final page = state.pageIndex;
            final isForward = state.isForward;
            return LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                      width: 440,
                      height: 884,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragEnd: (details) {
                          final velocity = details.primaryVelocity ?? 0;
                          if (velocity < -150) {
                            context
                                .read<OnboardingBloc>()
                                .add(const OnboardingNextPressed());
                          } else if (velocity > 150) {
                            context
                                .read<OnboardingBloc>()
                                .add(const OnboardingPreviousPressed());
                          }
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Page content (text + image) with vertical fade/slide.
                            Positioned.fill(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 420),
                                switchInCurve: Curves.easeOutCubic,
                                switchOutCurve: Curves.easeInCubic,
                                layoutBuilder: (currentChild, previousChildren) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ...previousChildren,
                                      if (currentChild != null) currentChild,
                                    ],
                                  );
                                },
                                transitionBuilder: (child, animation) {
                                  // Next: exit/enter through the bottom (slide down).
                                  // Previous: exit/enter through the top (slide up).
                                  final beginOffset = Offset(
                                    0,
                                    isForward ? 0.18 : -0.18,
                                  );
                                  final offset = Tween<Offset>(
                                    begin: beginOffset,
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
                                  child: _OnboardingPageContent(index: page),
                                ),
                              ),
                            ),
                            _Header(
                              showSkip: page < OnboardingData.pages.length - 1,
                              onSkip: () => _openSignIn(context),
                            ),
                            _Footer(
                              index: page,
                              onSignIn: () => _openSignIn(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return switch (index) {
      0 => const _Page1Content(),
      1 => const _Page2Content(),
      2 => const _Page3Content(),
      3 => const _Page4Content(),
      _ => const _Page5Content(),
    };
  }
}

/// Page 1 — edit this page's texts/styles only.
class _Page1Content extends StatelessWidget {
  const _Page1Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 20,
          top: 88,
          child: Text(
            '01',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 125,
          width: 400,
          child: Text(
            'Discover\nwhat\nmoves\nyou.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 52/40,
              letterSpacing: 2/40,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 361,
          width: 400,
          child: Text(
            'REAL PEOPLE.\nREAL FINDS.\nFREOM ALL OVER.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
        _ImageBox(
          top: 492,
          left: 94.5,
          width: 251,
          height: 284,
          path: OnboardingData.pages[0].image,
        ),
      ],
    );
  }
}

/// Page 2 — edit this page's texts/styles only.
class _Page2Content extends StatelessWidget {
  const _Page2Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 20,
          top: 88,
          child: Text(
            '02',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        _ImageBox(
          top: 138,
          left: 80.5,
          width: 279,
          height: 375,
          path: OnboardingData.pages[1].image,
        ),
        const _PageDivider(top: 519),
        const Positioned(
          left: 20,
          top: 536,
          width: 400,
          child: Text(
            'Buy\ndirectly\nfrom\ncreators.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.2,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 744,
          width: 400,
          child: Text(
            'NO MIDDLEMEN.\nJUST REAL CONNECTIONS.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

/// Page 3 — edit this page's texts/styles only.
class _Page3Content extends StatelessWidget {
  const _Page3Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 20,
          top: 88,
          child: Text(
            '03',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 128,
          width: 400,
          child: Text(
            'Sell\nanything\nInstantly.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.25,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const _PageDivider(top: 298),
        const Positioned(
          left: 20,
          top: 326,
          width: 400,
          child: Text(
            'LIST IN SECONDS.\nREACH THOUSAND OF\nCOLLECTORS.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
        _ImageBox(
          top: 429,
          left: 0,
          width: 440,
          height: 363,
          path: OnboardingData.pages[2].image,
        ),
      ],
    );
  }
}

/// Page 4 — edit this page's texts/styles only.
class _Page4Content extends StatelessWidget {
  const _Page4Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          left: 20,
          top: 88,
          child: Text(
            '04',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        _ImageBox(
          top: 138,
          left: 103.5,
          width: 233,
          height: 360,
          path: OnboardingData.pages[3].image,
        ),
        const _PageDivider(top: 519),
        const Positioned(
          left: 20,
          top: 536,
          width: 400,
          child: Text(
            'Connect.\nChat.\nMake it\nYours',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.2,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 744,
          width: 400,
          child: Text(
            'MESSAGE. NEGOTIATE.\nBUILD COMMUNITY.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

/// Page 5 — edit this page's texts/styles only.
class _Page5Content extends StatelessWidget {
  const _Page5Content();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 80,
          width: 440,
          height: 697,
          child: Image.asset(
            OnboardingData.pages[4].image,
            width: 440,
            height: 697,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
        const Positioned(
          left: 20,
          top: 88,
          child: Text(
            '05',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 330,
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: 'IBMPlexMono-Medium',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                height: 1.32,
                letterSpacing: 2/40,
                color: KolekColors.neutral900,
              ),
              children: [
                TextSpan(text: 'This is\n'),
                TextSpan(
                  text: 'kolek.',
                  style: TextStyle(color: KolekColors.blue600),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          left: 20,
          top: 450,
          width: 400,
          child: Text(
            'A CURATED WORLD OF\nCREATORS AND COLLECTORS.\nWELCOME IN.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 24/16,
            ),
          ),
        ),
      ],
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: KolekColors.neutral700),
                  ),
                ),
                child: const Text(
                  OnboardingData.skip,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KolekColors.neutral500,
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

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.path,
  });

  final double top;
  final double left;
  final double width;
  final double height;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _PageDivider extends StatelessWidget {
  const _PageDivider({required this.top});

  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: top,
      child: const Divider(
        height: 1,
        thickness: 1,
        color: KolekColors.neutral200,
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
                OnboardingData.arrowAsset,
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
