import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../cubit/set_password_cubit.dart';
import '../data/set_password_data.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  void _openSignIn(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoute.signIn, (_) => false);
  }

  void _finishRegistration(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoute.mainShell, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.setPassword,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Column(
          children: [
            const AuthHeading(
              title: SetPasswordData.title,
              subtitle: SetPasswordData.subtitle,
            ),
            const SizedBox(height: 28),
            BlocBuilder<SetPasswordCubit, SetPasswordState>(
              builder: (context, state) {
                final cubit = context.read<SetPasswordCubit>();
                return Column(
                  children: [
                    KolekField(
                      label: SetPasswordData.passwordLabel,
                      hint: SetPasswordData.password,
                      obscureText: !state.passwordVisible,
                      onVisibilityPressed: cubit.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 16),
                    KolekField(
                      label: SetPasswordData.confirmPasswordLabel,
                      hint: SetPasswordData.password,
                      obscureText: !state.confirmPasswordVisible,
                      onVisibilityPressed:
                          cubit.toggleConfirmPasswordVisibility,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            KolekButton(
              label: SetPasswordData.confirm,
              onPressed: () => _finishRegistration(context),
            ),
            const SizedBox(height: 20),
            UnderlinedLink(
              label: SetPasswordData.backToSignIn,
              onPressed: () => _openSignIn(context),
            ),
          ],
        ),
      ),
    );
  }
}
