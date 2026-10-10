import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_routes.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/deactivate_account_bloc.dart';
import '../bloc/deactivate_account_event.dart';
import '../bloc/deactivate_account_state.dart';
import '../data/deactivate_account_data.dart';
import 'account_flow_widgets.dart';

class DeactivateAccountConfirmScreen extends StatelessWidget {
  const DeactivateAccountConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeactivateAccountBloc, DeactivateAccountState>(
      listenWhen: (prev, next) =>
          !prev.deactivateSucceeded && next.deactivateSucceeded,
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.accountResult,
          (route) => route.settings.name == AppRoutes.settings,
          arguments: AccountResultKind.deactivated,
        );
      },
      child: Scaffold(
        backgroundColor: AppearancePage.background(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AccountFlowAppBar(
                title: DeactivateAccountData.deactivateAppBarTitle,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DeactivateAccountData.deactivateConfirmTitle,
                        style: KolekText.sans(
                          size: 22,
                          weight: FontWeight.w600,
                          height: 1.25,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DeactivateAccountData.deactivateConfirmBody,
                        style: KolekText.sans(
                          size: 14,
                          weight: FontWeight.w400,
                          height: 1.5,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        DeactivateAccountData.deactivateConfirmNote,
                        style: KolekText.sans(
                          size: 13,
                          weight: FontWeight.w400,
                          height: 1.5,
                          color: AppearancePage.muted(context),
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<
                        DeactivateAccountBloc,
                        DeactivateAccountState
                      >(
                        builder: (context, state) {
                          return AccountOutlinedButton(
                            label:
                                DeactivateAccountData.deactivateConfirmAction,
                            color: KolekColors.red600,
                            busy: state.submitting,
                            onPressed: state.submitting
                                ? null
                                : () => context
                                      .read<DeactivateAccountBloc>()
                                      .add(const DeactivateAccountSubmitted()),
                          );
                        },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
