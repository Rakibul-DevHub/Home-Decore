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

class DeleteAccountPasswordScreen extends StatelessWidget {
  const DeleteAccountPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeactivateAccountBloc, DeactivateAccountState>(
      listenWhen: (prev, next) => !prev.deleteSucceeded && next.deleteSucceeded,
      listener: (context, state) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.accountResult,
          (route) => route.settings.name == AppRoutes.settings,
          arguments: AccountResultKind.deletionRequested,
        );
      },
      child: Scaffold(
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
                      DeactivateAccountData.passwordTitle,
                      style: KolekText.sans(
                        size: 22,
                        weight: FontWeight.w600,
                        height: 1.25,
                        color: AppearancePage.foreground(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DeactivateAccountData.passwordSubtitle,
                      style: KolekText.sans(
                        size: 13,
                        weight: FontWeight.w400,
                        height: 1.5,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      DeactivateAccountData.passwordLabel,
                      style: KolekText.sans(
                        size: 13,
                        weight: FontWeight.w500,
                        height: 1.3,
                        color: AppearancePage.foreground(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const _PasswordField(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: BlocBuilder<DeactivateAccountBloc, DeactivateAccountState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        AccountFilledButton(
                          label: DeactivateAccountData.permanentlyDelete,
                          busy: state.submitting,
                          onPressed: state.submitting
                              ? null
                              : () => context.read<DeactivateAccountBloc>().add(
                                  const DeactivateAccountDeleteConfirmed(),
                                ),
                        ),
                        const SizedBox(height: 12),
                        AccountOutlinedButton(
                          label: DeactivateAccountData.cancel,
                          color: AppearancePage.foreground(context),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeactivateAccountBloc, DeactivateAccountState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              obscureText: !state.passwordVisible,
              onChanged: (value) => context.read<DeactivateAccountBloc>().add(
                DeactivateAccountPasswordChanged(value),
              ),
              cursorColor: AppearancePage.foreground(context),
              style: KolekText.sans(
                size: 16,
                weight: FontWeight.w400,
                color: AppearancePage.foreground(context),
              ),
              decoration: InputDecoration(
                hintText: DeactivateAccountData.passwordHint,
                hintStyle: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w400,
                  color: AppearancePage.muted(context),
                ),
                suffixIcon: IconButton(
                  onPressed: () => context.read<DeactivateAccountBloc>().add(
                    const DeactivateAccountPasswordVisibilityToggled(),
                  ),
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 22,
                    color: AppearancePage.icon(context),
                  ),
                ),
                filled: true,
                fillColor: AppearancePage.background(context),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppearancePage.line(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: AppearancePage.foreground(context),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: KolekColors.red600),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: KolekColors.red600),
                ),
              ),
            ),
            if (state.passwordError != null) ...[
              const SizedBox(height: 8),
              Text(
                state.passwordError!,
                style: KolekText.sans(
                  size: 12,
                  weight: FontWeight.w400,
                  color: KolekColors.red600,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
