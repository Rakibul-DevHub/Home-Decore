import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../cubit/new_password_cubit.dart';
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
            BlocBuilder<NewPasswordCubit, NewPasswordState>(
              builder: (context, state) {
                final cubit = context.read<NewPasswordCubit>();
                return Column(
                  children: [
                    KolekField(
                      label: NewPasswordData.passwordLabel,
                      hint: NewPasswordData.password,
                      obscureText: !state.passwordVisible,
                      onVisibilityPressed: cubit.togglePasswordVisibility,
                    ),
                    const SizedBox(height: 16),
                    KolekField(
                      label: NewPasswordData.confirmPasswordLabel,
                      hint: NewPasswordData.password,
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
