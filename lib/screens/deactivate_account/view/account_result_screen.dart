import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../data/deactivate_account_data.dart';
import 'account_flow_widgets.dart';

class AccountResultScreen extends StatelessWidget {
  const AccountResultScreen({super.key, required this.kind});

  final AccountResultKind kind;

  @override
  Widget build(BuildContext context) {
    final copy = switch (kind) {
      AccountResultKind.deletionRequested => (
        appBar: DeactivateAccountData.deleteAppBarTitle,
        title: DeactivateAccountData.deletionRequestedTitle,
        body: DeactivateAccountData.deletionRequestedBody,
        footer: DeactivateAccountData.deletionRequestedFooter,
        extra: DeactivateAccountData.deletionRequestedNote,
      ),
      AccountResultKind.deactivated => (
        appBar: DeactivateAccountData.deactivateAppBarTitle,
        title: DeactivateAccountData.deactivatedTitle,
        body: DeactivateAccountData.deactivatedBody,
        footer: DeactivateAccountData.deactivatedFooter,
        extra: null,
      ),
      AccountResultKind.reactivated => (
        appBar: DeactivateAccountData.deactivateAppBarTitle,
        title: DeactivateAccountData.reactivatedTitle,
        body: DeactivateAccountData.reactivatedBody,
        footer: DeactivateAccountData.reactivatedFooter,
        extra: null,
      ),
    };

    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AccountFlowAppBar(title: copy.appBar),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 48, 32, 20),
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: KolekColors.blue600,
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 36,
                        color: KolekColors.blue600,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      copy.title,
                      textAlign: TextAlign.center,
                      style: KolekText.sans(
                        size: 22,
                        weight: FontWeight.w600,
                        height: 1.25,
                        color: AppearancePage.foreground(context),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      copy.body,
                      textAlign: TextAlign.center,
                      style: KolekText.sans(
                        size: 14,
                        weight: FontWeight.w400,
                        height: 1.5,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                    if (copy.extra != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        copy.extra!,
                        textAlign: TextAlign.center,
                        style: KolekText.sans(
                          size: 13,
                          weight: FontWeight.w400,
                          height: 1.5,
                          color: AppearancePage.muted(context),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      copy.footer,
                      textAlign: TextAlign.center,
                      style: KolekText.sans(
                        size: 13,
                        weight: FontWeight.w400,
                        height: 1.5,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                    const Spacer(flex: 2),
                    AccountFilledButton(
                      label: DeactivateAccountData.done,
                      color: KolekColors.blue600,
                      onPressed: () {
                        if (kind == AccountResultKind.deactivated ||
                            kind == AccountResultKind.deletionRequested) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.signIn,
                            (_) => false,
                          );
                          return;
                        }
                        Navigator.of(context).popUntil(
                          (route) =>
                              route.settings.name == AppRoutes.settings ||
                              route.settings.name == AppRoutes.mainShell,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
