import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../cubit/forgot_password_cubit.dart';
import '../data/forgot_password_data.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.forgotPassword,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Column(
          children: [
            const AuthHeading(
              title: ForgotPasswordData.title,
              subtitle: ForgotPasswordData.subtitle,
            ),
            const SizedBox(height: 32),
            const KolekField(
              label: ForgotPasswordData.emailLabel,
              hint: ForgotPasswordData.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            KolekButton(
              label: ForgotPasswordData.confirm,
              onPressed: () {
                context.read<ForgotPasswordCubit>().submit();
                Navigator.of(context).pushNamed(AppRoute.otpVerification);
              },
            ),
            const SizedBox(height: 20),
            UnderlinedLink(
              label: ForgotPasswordData.backToSignIn,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
