import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_route.dart';
import '../../../../theme/kolek_colors.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../cubit/otp_verification_cubit.dart';
import '../data/otp_verification_data.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.otpVerification,
      child: Padding(
        padding: const EdgeInsets.only(top: 96),
        child: Column(
          children: [
            const AuthHeading(
              title: OtpVerificationData.title,
              subtitle: OtpVerificationData.subtitle,
            ),
            const SizedBox(height: 28),
            const _OtpFields(),
            const SizedBox(height: 24),
            KolekButton(
              label: OtpVerificationData.confirm,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoute.newPassword),
            ),
            const SizedBox(height: 20),
            AuthLinkRow(
              text: OtpVerificationData.resendPrompt,
              link: OtpVerificationData.resend,
              onPressed: context.read<OtpVerificationCubit>().resend,
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpFields extends StatelessWidget {
  const _OtpFields();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpVerificationCubit, String>(
      builder: (context, code) {
        return Row(
          children: List.generate(OtpVerificationData.digits, (index) {
            return Expanded(
              child: Container(
                height: 56,
                margin: EdgeInsets.only(
                  right: index == OtpVerificationData.digits - 1 ? 0 : 8,
                ),
                decoration: BoxDecoration(
                  color: KolekColors.neutral50,
                  border: Border.all(color: KolekColors.neutral300),
                ),
                alignment: Alignment.center,
                child: Text(
                  index < code.length ? code[index] : '',
                  style: KolekText.mono(size: 20),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
