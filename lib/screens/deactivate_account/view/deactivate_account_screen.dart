import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_routes.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/deactivate_account_bloc.dart';
import '../data/deactivate_account_data.dart';
import 'account_flow_widgets.dart';
import 'deactivate_account_confirm_screen.dart';
import 'delete_account_confirm_screen.dart';

class DeactivateAccountScreen extends StatelessWidget {
  const DeactivateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AccountFlowAppBar(
              title: DeactivateAccountData.hubAppBarTitle,
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                children: [
                  Text(
                    DeactivateAccountData.hubTitle,
                    style: KolekText.sans(
                      size: 22,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DeactivateAccountData.hubBody,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.5,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  _ChoiceRow(
                    title: DeactivateAccountData.deactivateTitle,
                    body: DeactivateAccountData.deactivateBody,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        settings: const RouteSettings(
                          name: AppRoutes.deactivateAccountConfirm,
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<DeactivateAccountBloc>(),
                          child: const DeactivateAccountConfirmScreen(),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  _ChoiceRow(
                    title: DeactivateAccountData.deleteTitle,
                    body: DeactivateAccountData.deleteBody,
                    titleColor: KolekColors.red600,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        settings: const RouteSettings(
                          name: AppRoutes.deleteAccountConfirm,
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<DeactivateAccountBloc>(),
                          child: const DeleteAccountConfirmScreen(),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    DeactivateAccountData.helpPrompt,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w500,
                      height: 1.4,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    DeactivateAccountData.supportEmail,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w500,
                      height: 1.4,
                      color: KolekColors.blue600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.title,
    required this.body,
    required this.onTap,
    this.titleColor,
  });

  final String title;
  final String body;
  final VoidCallback onTap;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: KolekText.sans(
                size: 16,
                weight: FontWeight.w600,
                height: 1.3,
                color: titleColor ?? AppearancePage.foreground(context),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: KolekText.sans(
                size: 13,
                weight: FontWeight.w400,
                height: 1.45,
                color: AppearancePage.muted(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
