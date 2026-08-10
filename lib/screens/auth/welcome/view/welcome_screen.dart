import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../theme/kolek_colors.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../cubit/welcome_cubit.dart';
import '../data/welcome_data.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.signIn,
      showBack: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 146),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHeading(
              title: WelcomeData.title,
              subtitle: WelcomeData.subtitle,
            ),
            const SizedBox(height: 64),
            BlocBuilder<WelcomeCubit, bool>(
              builder: (context, passwordVisible) {
                return Column(
                  children: [
                    const KolekField(
                      label: WelcomeData.emailLabel,
                      hint: WelcomeData.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    KolekField(
                      label: WelcomeData.passwordLabel,
                      hint: WelcomeData.password,
                      obscureText: !passwordVisible,
                      onVisibilityPressed: context
                          .read<WelcomeCubit>()
                          .togglePasswordVisibility,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoute.forgotPassword),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  foregroundColor: KolekColors.neutral500,
                ),
                child: Text(
                  WelcomeData.forgotPassword,
                  style: KolekText.mono(
                    size: 16,
                    color: KolekColors.neutral500,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
            const SizedBox(height: 34),
            KolekButton(
              label: WelcomeData.signIn,
              onPressed: () => Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoute.mainShell, (_) => false),
            ),
            const SizedBox(height: 24),
            const _OrDivider(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _SocialButton(
                    label: WelcomeData.google,
                    icon: const Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFF4285F4),
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SocialButton(
                    label: WelcomeData.apple,
                    icon: const Icon(
                      Icons.apple,
                      size: 23,
                      color: KolekColors.neutral900,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AuthLinkRow(
              text: WelcomeData.accountPrompt,
              link: WelcomeData.signUp,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoute.createAccount),
            ),
            const SizedBox(height: 24),
          ],
        ),
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
            style: KolekText.mono(size: 12, color: KolekColors.neutral400),
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
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;

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
            Text(label, style: KolekText.sans(size: 16)),
          ],
        ),
      ),
    );
  }
}
