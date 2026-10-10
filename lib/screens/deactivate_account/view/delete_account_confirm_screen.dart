import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_routes.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/deactivate_account_bloc.dart';
import '../data/deactivate_account_data.dart';
import 'account_flow_widgets.dart';
import 'delete_account_password_screen.dart';

class DeleteAccountConfirmScreen extends StatelessWidget {
  const DeleteAccountConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AccountFlowAppBar(
              title: DeactivateAccountData.deleteAppBarTitle,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                children: [
                  Text(
                    DeactivateAccountData.deleteConfirmTitle,
                    style: KolekText.sans(
                      size: 22,
                      weight: FontWeight.w600,
                      height: 1.25,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DeactivateAccountData.deleteConfirmLead,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.5,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    DeactivateAccountData.thisWillRemove,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w600,
                      height: 1.3,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const AccountBulletList(
                    items: DeactivateAccountData.removalItems,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    DeactivateAccountData.beforeYouCanDelete,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w600,
                      height: 1.3,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DeactivateAccountData.beforeYouCanDeleteLead,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.5,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const AccountBulletList(
                    items: DeactivateAccountData.pendingItems,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    DeactivateAccountData.pendingNote,
                    style: KolekText.sans(
                      size: 13,
                      weight: FontWeight.w400,
                      height: 1.5,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                children: [
                  AccountFilledButton(
                    label: DeactivateAccountData.continueToDelete,
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        settings: const RouteSettings(
                          name: AppRoutes.deleteAccountPassword,
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<DeactivateAccountBloc>(),
                          child: const DeleteAccountPasswordScreen(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AccountOutlinedButton(
                    label: DeactivateAccountData.cancel,
                    color: AppearancePage.foreground(context),
                    onPressed: () => Navigator.of(context).pop(),
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
