import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kolek/theme/kolek_colors.dart';

import '../../../routes/app_routes.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../data/settings_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// Row id → route name. Extend as target screens are wired.
  static const _routes = <String, String>{
    'edit-profile': AppRoutes.editProfile,
    'account-info': AppRoutes.accountInformation,
    // 'password': AppRoutes.passwordSecurity,
    // 'push': AppRoutes.pushNotification,
    // 'privacy': AppRoutes.privacyVisibility,
    // 'blocked': AppRoutes.blockedAccounts,
    // 'payment': AppRoutes.paymentMethods,
    // 'shipping': AppRoutes.shippingAddresses,
    // 'payouts': AppRoutes.payouts,
    'appearance': AppRoutes.appearance,
    'help': AppRoutes.helpSupport,
    // 'report': AppRoutes.reportProblem,
    // 'terms': AppRoutes.terms,
    'about': AppRoutes.about,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<SettingsBloc, SettingsState>(
          listenWhen: (prev, next) =>
          prev.loggingOut != next.loggingOut ||
              prev.deletingAccount != next.deletingAccount,
          listener: (context, state) {
            if (state.loggingOut) {
              // TODO: navigate to login once the route exists.
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   AppRoutes.signIn, (_) => false,
              // );
            }
            if (state.deletingAccount) {
              // TODO: open confirmation bottom sheet / route.
            }
          },
          child: Column(
            children: [
              const _SettingsHeader(),
              Expanded(
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.only(bottom: 12),
                      children: [
                        for (var s = 0; s < state.sections.length; s++) ...[
                          if (state.sections[s].label.isNotEmpty)
                            _SectionLabel(label: state.sections[s].label),
                          for (final item in state.sections[s].items)
                            _SettingsRow(
                              item: item,
                              onTap: () => _onRowTapped(context, item),
                              logoutColor: KolekColors.blue600,
                              destructiveColor: KolekColors.red600,
                            ),
                        ],
                        const SizedBox(height: 24),
                        const _VersionFooter(),
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

  void _onRowTapped(BuildContext context, SettingsItem item) {
    context.read<SettingsBloc>().add(SettingsItemTapped(item.id));

    if (item.isLogout) {
      context.read<SettingsBloc>().add(const SettingsLogoutRequested());
      return;
    }
    if (item.isDestructive) {
      context
          .read<SettingsBloc>()
          .add(const SettingsDeleteAccountRequested());
      return;
    }

    final route = _routes[item.id];
    if (route != null) {
      Navigator.of(context).pushNamed(route);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Header — back arrow + "Settings"
// ─────────────────────────────────────────────────────────────────────────

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 18, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'GeneralSans-Medium',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.0,
              color: AppearancePage.foreground(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Section label — "ACCOUNT", "PRIVACY", etc.
// ─────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 6),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'IBMPlexMono-Regular',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
          height: 1.0,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Row — SVG (or Material) icon + title + optional subtitle + chevron
// ─────────────────────────────────────────────────────────────────────────

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.item,
    required this.onTap,
    required this.logoutColor,
    required this.destructiveColor,
  });

  final SettingsItem item;
  final VoidCallback onTap;
  final Color logoutColor;
  final Color destructiveColor;

  @override
  Widget build(BuildContext context) {
    final Color titleColor;
    final Color iconColor;
    if (item.isLogout) {
      titleColor = logoutColor;
      iconColor = logoutColor;
    } else if (item.isDestructive) {
      titleColor = destructiveColor;
      iconColor = destructiveColor;
    } else {
      titleColor = AppearancePage.foreground(context);
      iconColor = AppearancePage.icon(context);
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: _buildIcon(iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: titleColor,
                    ),
                  ),
                  if (item.subtitle != null &&
                      item.subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle!,
                      style: TextStyle(
                        fontFamily: 'IBMPlexMono-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: item.isLogout || item.isDestructive
                  ? iconColor
                  : AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color tint) {
    // SVG takes priority when present, then Material fallback.
    if (item.iconAsset != null) {
      return SvgPicture.asset(
        item.iconAsset!,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
      );
    }
    return Icon(item.iconData, size: 22, color: tint);
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Version footer
// ─────────────────────────────────────────────────────────────────────────

class _VersionFooter extends StatelessWidget {
  const _VersionFooter();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        SettingsData.versionFooter,
        style: TextStyle(
          fontFamily: 'IBMPlexMono-Regular',
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}