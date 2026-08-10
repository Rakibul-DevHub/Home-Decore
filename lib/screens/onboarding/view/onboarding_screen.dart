import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/onboarding_cubit.dart';
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
        child: BlocBuilder<OnboardingCubit, int>(
          builder: (context, page) {
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
                            if (context.read<OnboardingCubit>().nextPage()) {
                              _openSignIn(context);
                            }
                          } else if (velocity > 150) {
                            context.read<OnboardingCubit>().previousPage();
                          }
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          child: _OnboardingPage(
                            key: ValueKey(page),
                            index: page,
                            onSignIn: () => _openSignIn(context),
                          ),
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

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.index,
    required this.onSignIn,
    super.key,
  });

  final int index;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final item = OnboardingData.pages[index];
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (index == 4)
          Positioned(
            left: 0,
            top: 80,
            width: 440,
            height: 697,
            child: Image.asset(
              item.image,
              width: 440,
              height: 697,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
          ),
        _Header(onSkip: onSignIn),
        Positioned(
          left: 20,
          top: 88,
          child: Text(
            '0${index + 1}',
            style: KolekText.mono(
              size: 20,
              weight: FontWeight.w500,
              color: KolekColors.neutral700,
              letterSpacing: -0.4,
            ),
          ),
        ),
        if (index == 0) ...[
          _Title(top: 125, text: item.title),
          _Description(top: 361, text: item.description),
          _ImageBox(
            top: 492,
            left: 94.5,
            width: 251,
            height: 284,
            path: item.image,
          ),
        ] else if (index == 1) ...[
          _ImageBox(
            top: 138,
            left: 80.5,
            width: 279,
            height: 375,
            path: item.image,
          ),
          const _PageDivider(top: 519),
          _Title(top: 536, text: item.title, lineHeight: 1.2),
          _Description(top: 744, text: item.description),
        ] else if (index == 2) ...[
          _Title(top: 128, text: item.title, lineHeight: 1.25),
          const _PageDivider(top: 298),
          _Description(top: 326, text: item.description),
          _ImageBox(
            top: 429,
            left: 0,
            width: 440,
            height: 363,
            path: item.image,
          ),
        ] else if (index == 3) ...[
          _ImageBox(
            top: 138,
            left: 103.5,
            width: 233,
            height: 360,
            path: item.image,
          ),
          const _PageDivider(top: 519),
          _Title(top: 536, text: item.title, lineHeight: 1.2),
          _Description(top: 744, text: item.description),
        ] else ...[
          Positioned(
            left: 20,
            top: 330,
            child: RichText(
              text: TextSpan(
                style: KolekText.mono(
                  size: 40,
                  weight: FontWeight.w500,
                  height: 1.32,
                  letterSpacing: 2,
                ),
                children: const [
                  TextSpan(text: 'This is\n'),
                  TextSpan(
                    text: 'kolek.',
                    style: TextStyle(color: KolekColors.blue600),
                  ),
                ],
              ),
            ),
          ),
          _Description(top: 450, text: item.description),
        ],
        _Footer(index: index, onSignIn: onSignIn),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onSkip});

  final VoidCallback onSkip;

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
          InkWell(
            onTap: onSkip,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: KolekColors.neutral700),
                ),
              ),
              child: Text(
                OnboardingData.skip,
                style: KolekText.mono(
                  size: 14,
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

class _Title extends StatelessWidget {
  const _Title({required this.top, required this.text, this.lineHeight = 1.3});

  final double top;
  final String text;
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: top,
      width: 400,
      child: Text(
        text,
        style: KolekText.mono(
          size: 40,
          weight: FontWeight.w500,
          color: KolekColors.neutral900,
          height: lineHeight,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.top, required this.text});

  final double top;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: top,
      width: 400,
      child: Text(
        text,
        style: KolekText.mono(
          size: 16,
          color: KolekColors.neutral700,
          height: 1.6,
        ),
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
            KolekButton(label: OnboardingData.getStarted, onPressed: onSignIn),
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
                if (context.read<OnboardingCubit>().nextPage()) {
                  onSignIn();
                }
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
