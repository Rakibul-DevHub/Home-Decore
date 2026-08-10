import 'package:flutter/material.dart';

import '../../../../routes/app_route.dart';
import '../../../../theme/kolek_colors.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../data/create_account_data.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      routeName: AppRoute.createAccount,
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
            const AuthHeading(
              title: CreateAccountData.title,
              subtitle: CreateAccountData.subtitle,
            ),
            const SizedBox(height: 24),
            const _ProfilePicker(),
            const SizedBox(height: 16),
            const KolekField(
              label: CreateAccountData.fullNameLabel,
              hint: CreateAccountData.fullName,
            ),
            const SizedBox(height: 16),
            const KolekField(
              label: CreateAccountData.emailLabel,
              hint: CreateAccountData.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            const KolekField(
              label: CreateAccountData.phoneLabel,
              hint: CreateAccountData.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            const KolekField(
              label: CreateAccountData.locationLabel,
              hint: CreateAccountData.location,
            ),
            const SizedBox(height: 16),
            KolekButton(
              label: CreateAccountData.createAccount,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoute.setPassword),
            ),
            const SizedBox(height: 16),
            AuthLinkRow(
              text: CreateAccountData.accountPrompt,
              link: CreateAccountData.signIn,
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ProfilePicker extends StatelessWidget {
  const _ProfilePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      height: 94,
      child: Stack(
        children: [
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: KolekColors.neutral300),
              color: KolekColors.neutral50,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: KolekColors.neutral700,
              size: 32,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: KolekColors.blue600,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 16,
                color: KolekColors.neutral50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
