import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../bloc/set_password_bloc.dart';
import '../bloc/set_password_event.dart';
import '../bloc/set_password_state.dart';
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
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            const AuthHeading(
              title: SetPasswordData.title,
              subtitle: SetPasswordData.subtitle,
            ),
            const SizedBox(height: 28),
            BlocBuilder<SetPasswordBloc, SetPasswordState>(
              builder: (context, state) {
                final bloc = context.read<SetPasswordBloc>();
                return Column(
                  children: [
                    KolekField(
                      label: SetPasswordData.passwordLabel,
                      hint: SetPasswordData.password,
                      obscureText: !state.passwordVisible,
                      onVisibilityPressed: () => bloc.add(
                        const SetPasswordVisibilityToggled(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    KolekField(
                      label: SetPasswordData.confirmPasswordLabel,
                      hint: SetPasswordData.password,
                      obscureText: !state.confirmPasswordVisible,
                      onVisibilityPressed: () => bloc.add(
                        const SetConfirmPasswordVisibilityToggled(),
                      ),
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
