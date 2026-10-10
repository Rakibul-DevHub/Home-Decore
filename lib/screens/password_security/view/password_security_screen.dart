import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/password_security_bloc.dart';
import '../bloc/password_security_event.dart';
import '../data/password_security_data.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PasswordSecurityAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
                children: [
                  // ── Subtitle ────────────────────────────────────
                  Text(
                    PasswordSecurityData.subtitle,
                    style: KolekText.sans(
                      size: 13,
                      weight: FontWeight.w400,
                      height: 1.5,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Password ────────────────────────────────────
                  _ActionRow(
                    title: PasswordSecurityData.passwordTitle,
                    subtitle: PasswordSecurityData.passwordSubtitle,
                    actionLabel: PasswordSecurityData.passwordActionLabel,
                    onTap: () => context
                        .read<PasswordSecurityBloc>()
                        .add(const PasswordSecurityActionPressed(
                      SecurityAction.changePassword,
                    )),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),

                  // // ── Two-Factor Authentication ───────────────────
                  // _ActionRow(
                  //   title: PasswordSecurityData.twoFactorTitle,
                  //   subtitle: PasswordSecurityData.twoFactorSubtitle,
                  //   actionLabel: PasswordSecurityData.twoFactorActionLabel,
                  //   onTap: () => context
                  //       .read<PasswordSecurityBloc>()
                  //       .add(const PasswordSecurityActionPressed(
                  //     SecurityAction.setupTwoFactor,
                  //   )),
                  // ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  const SizedBox(height: 12),

                  // ── Full-width blue actions ─────────────────────
                  _LinkRow(
                    label: PasswordSecurityData.loginActivityLabel,
                    onTap: () => context
                        .read<PasswordSecurityBloc>()
                        .add(const PasswordSecurityActionPressed(
                      SecurityAction.viewLoginActivity,
                    )),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  _LinkRow(
                    label: PasswordSecurityData.logoutOtherDevicesLabel,
                    onTap: () => context
                        .read<PasswordSecurityBloc>()
                        .add(const PasswordSecurityActionPressed(
                      SecurityAction.logoutOtherDevices,
                    )),
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  const SizedBox(height: 24),

                  // ── Footnote ────────────────────────────────────
                  const _Footnote(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + title
// ─────────────────────────────────────────────────────────────────────────

class _PasswordSecurityAppBar extends StatelessWidget {
  const _PasswordSecurityAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Text(
            PasswordSecurityData.appBarTitle,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Action row — title + subtitle on the left, blue action link on the right
// ─────────────────────────────────────────────────────────────────────────

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KolekText.sans(
                      size: 16,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.35,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              actionLabel,
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w500,
                height: 1.0,
                color: KolekColors.blue600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Full-width blue link row
// ─────────────────────────────────────────────────────────────────────────

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Text(
          label,
          style: KolekText.sans(
            size: 15,
            weight: FontWeight.w500,
            height: 1.2,
            color: KolekColors.blue600,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Footnote — info icon + muted copy
// ─────────────────────────────────────────────────────────────────────────

class _Footnote extends StatelessWidget {
  const _Footnote();

  @override
  Widget build(BuildContext context) {
    final muted = AppearancePage.muted(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.info_outline,
          size: 16,
          color: muted,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            PasswordSecurityData.footnote,
            style: KolekText.sans(
              size: 12,
              weight: FontWeight.w400,
              height: 1.5,
              color: muted,
            ),
          ),
        ),
      ],
    );
  }
}