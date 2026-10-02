import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../theme/kolek_scheme.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../data/onboarding_data.dart';

part 'onboarding_shell.dart';
part 'onboarding_layer.dart';
part 'onboarding_pages.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _openSignIn(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AppRoute.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final dark = KolekScheme.isDark(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: KolekScheme.overlay(context),
      child: Scaffold(
        backgroundColor: AppearancePage.background(context),
        body: SafeArea(
          child: BlocConsumer<OnboardingBloc, OnboardingState>(
            listenWhen: (previous, current) =>
                !previous.finished && current.finished,
            listener: (context, state) => _openSignIn(context),
            builder: (context, state) {
              final page = state.pageIndex;
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
                          context.read<OnboardingBloc>().add(
                            const OnboardingNextPressed(),
                          );
                        } else if (velocity > 150) {
                          context.read<OnboardingBloc>().add(
                            const OnboardingPreviousPressed(),
                          );
                        }
                      },
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned.fill(
                            child: _OnboardingLayerSwitcher(
                              page: page,
                              tops: [
                                for (final p in OnboardingData.pages)
                                  p.imageTop,
                              ],
                              builder: (index) =>
                                  _OnboardingImageLayer(index: index),
                            ),
                          ),
                          Positioned.fill(
                            child: dark
                                ? ColorFiltered(
                                    colorFilter: const ColorFilter.mode(
                                      KolekScheme.darkText,
                                      BlendMode.srcIn,
                                    ),
                                    child: _OnboardingLayerSwitcher(
                                      page: page,
                                      tops: [
                                        for (final p in OnboardingData.pages)
                                          p.textTop,
                                      ],
                                      builder: (index) =>
                                          _OnboardingTextLayer(index: index),
                                    ),
                                  )
                                : _OnboardingLayerSwitcher(
                                    page: page,
                                    tops: [
                                      for (final p in OnboardingData.pages)
                                        p.textTop,
                                    ],
                                    builder: (index) =>
                                        _OnboardingTextLayer(index: index),
                                  ),
                          ),
                          _PageNumber(index: page),
                          _Header(
                            showSkip: page < OnboardingData.pages.length - 1,
                            onSkip: () => context.read<OnboardingBloc>().add(
                              const OnboardingSkipPressed(),
                            ),
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
          ),
        ),
      ),
    );
  }
}
