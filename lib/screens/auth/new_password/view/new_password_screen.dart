import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../bloc/new_password_bloc.dart';
import '../bloc/new_password_event.dart';
import '../bloc/new_password_state.dart';
import '../data/new_password_data.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.newPassword,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Column(
          children: [
            const AuthHeading(
              title: NewPasswordData.title,
              subtitle: NewPasswordData.subtitle,
            ),
            const SizedBox(height: 28),
            BlocBuilder<NewPasswordBloc, NewPasswordState>(
              builder: (context, state) {
                final bloc = context.read<NewPasswordBloc>();
                return Column(
                  children: [
                    KolekField(
                      label: NewPasswordData.passwordLabel,
                      hint: NewPasswordData.password,
                      obscureText: !state.passwordVisible,
                      onVisibilityPressed: () => bloc.add(
                        const NewPasswordVisibilityToggled(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    KolekField(
                      label: NewPasswordData.confirmPasswordLabel,
                      hint: NewPasswordData.password,
                      obscureText: !state.confirmPasswordVisible,
                      onVisibilityPressed: () => bloc.add(
                        const NewConfirmPasswordVisibilityToggled(),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            KolekButton(
              label: NewPasswordData.confirm,
              onPressed: () => Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoute.signIn, (_) => false),
            ),
          ],
        ),
      ),
    );
  }
}
