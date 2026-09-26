import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../routes/app_route.dart';
import '../../../../theme/kolek_colors.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../bloc/welcome_bloc.dart';
import '../bloc/welcome_event.dart';
import '../bloc/welcome_state.dart';
import '../data/welcome_data.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.signIn,
      showBack: false,
      scrollable: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),
                  const AuthHeading(
                    title: WelcomeData.title,
                    subtitle: WelcomeData.subtitle,
                    titleStyle: TextStyle(
                      fontFamily: 'IBMPlexMono-SemiBold',
                      fontSize: 50,
                      fontWeight: FontWeight.w600,
                      height: 55 / 50,
                      letterSpacing: -3 / 50,
                      color: KolekColors.neutral900,
                    ),
                    subtitleStyle: TextStyle(
                      fontFamily: 'IBMPlexMono-Medium',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: KolekColors.neutral600,
                    ),
                  ),
                  const Spacer(flex: 2),
                  BlocBuilder<WelcomeBloc, WelcomeState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          const KolekField(
                            label: WelcomeData.emailLabel,
                            hint: WelcomeData.email,
                            keyboardType: TextInputType.emailAddress,
                            labelStyle: TextStyle(
                              fontFamily: 'IBMPlexMono-Regular',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: KolekColors.neutral800,
                            ),
                            inputStyle: TextStyle(
                              fontFamily: 'IBMPlexMono-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: KolekColors.neutral900,
                            ),
                          ),
                          const SizedBox(height: 16),
                          KolekField(
                            label: WelcomeData.passwordLabel,
                            hint: WelcomeData.password,
                            obscureText: !state.passwordVisible,
                            onVisibilityPressed: () => context
                                .read<WelcomeBloc>()
                                .add(
                                  const WelcomePasswordVisibilityToggled(),
                                ),
                            labelStyle: const TextStyle(
                              fontFamily: 'IBMPlexMono-Regular',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: KolekColors.neutral800,
                            ),
                            inputStyle: const TextStyle(
                              fontFamily: 'IBMPlexMono-Regular',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: KolekColors.neutral900,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoute.forgotPassword),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: KolekColors.neutral500,
                      ),
                      child: const Text(
                        WelcomeData.forgotPassword,
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono-Regular',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: KolekColors.neutral500,
                          decoration: TextDecoration.underline,
                          decorationColor: KolekColors.neutral500,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  KolekButton(
                    label: WelcomeData.signIn,
                    labelStyle: const TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: KolekColors.neutral50,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                          AppRoute.mainShell,
                          (_) => false,
                        ),
                  ),
                  const SizedBox(height: 20),
                  const _OrDivider(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          label: WelcomeData.google,
                          labelStyle: const TextStyle(
                            fontFamily: 'GeneralSans-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: KolekColors.neutral900,
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/google_logo.svg',
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          label: WelcomeData.apple,
                          labelStyle: const TextStyle(
                            fontFamily: 'GeneralSans-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: KolekColors.neutral900,
                          ),
                          icon: SvgPicture.asset(
                            'assets/icons/apple_logo.svg',
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  AuthLinkRow(
                    text: WelcomeData.accountPrompt,
                    link: WelcomeData.signUp,
                    textStyle: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral400,
                    ),
                    linkStyle: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.blue600,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoute.createAccount),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: KolekColors.neutral300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            WelcomeData.divider,
            style: const TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral400,
            ),
          ),
        ),
        const Expanded(child: Divider(color: KolekColors.neutral300)),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.labelStyle,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          side: const BorderSide(color: KolekColors.neutral200),
          backgroundColor: KolekColors.neutral100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: labelStyle ??
                  const TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: KolekColors.neutral900,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
