import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/privacy_bloc.dart';
import '../bloc/privacy_event.dart';
import '../bloc/privacy_state.dart';
import '../data/privacy_data.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  /// Which route each navigation row pushes to. Leave entries out to
  /// keep them as no-ops until the target screen exists.
  static const _routes = <PrivacyRowId, String>{
    PrivacyRowId.blockedAccounts: AppRoutes.blockedAccounts,
    // PrivacyRowId.showActivityStatus: AppRoutes.activityStatus,
    // PrivacyRowId.comments: AppRoutes.commentsPrivacy,
    // PrivacyRowId.messages: AppRoutes.messagesPrivacy,
    // PrivacyRowId.privacyPolicy: AppRoutes.privacyPolicy,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<PrivacyBloc, PrivacyState>(
          listenWhen: (_, _) => false,   // no state-driven navigation yet
          listener: (_, _) {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _PrivacyAppBar(),
              Expanded(
                child: BlocBuilder<PrivacyBloc, PrivacyState>(
                  builder: (context, state) {
                    return ListView(
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
                      children: [
                        Text(
                          PrivacyData.subtitle,
                          style: KolekText.sans(
                            size: 13,
                            weight: FontWeight.w400,
                            height: 1.5,
                            color: AppearancePage.muted(context),
                          ),
                        ),
                        const SizedBox(height: 20),
                        for (var s = 0;
                        s < state.sections.length;
                        s++) ...[
                          _SectionLabel(label: state.sections[s].label),
                          const SizedBox(height: 4),
                          for (final row in state.sections[s].rows)
                            _buildRow(context, state, row),
                          if (s < state.sections.length - 1)
                            const SizedBox(height: 16),
                        ],
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

  Widget _buildRow(
      BuildContext context,
      PrivacyState state,
      Object row,
      ) {
    if (row is PrivacyToggle) {
      return _ToggleRow(
        toggle: row,
        value: state.valueOf(row.id),
        onChanged: (v) => context
            .read<PrivacyBloc>()
            .add(PrivacyToggleChanged(row.id, v)),
      );
    }
    final nav = row as PrivacyNavRow;
    return _NavRow(
      row: nav,
      onTap: () {
        context.read<PrivacyBloc>().add(PrivacyNavRowTapped(nav.id));
        final route = _routes[nav.id];
        if (route != null) Navigator.of(context).pushNamed(route);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar
// ─────────────────────────────────────────────────────────────────────────

class _PrivacyAppBar extends StatelessWidget {
  const _PrivacyAppBar();

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
            PrivacyData.appBarTitle,
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
// Section label
// ─────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        label,
        style: KolekText.mono(
          size: 11,
          weight: FontWeight.w500,
          height: 1.0,
          letterSpacing: 1.2,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Toggle row
// ─────────────────────────────────────────────────────────────────────────

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.toggle,
    required this.value,
    required this.onChanged,
  });

  final PrivacyToggle toggle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    toggle.title,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w500,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    toggle.subtitle,
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
            const SizedBox(width: 12),
            _KolekSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Nav row — title + subtitle + chevron
// ─────────────────────────────────────────────────────────────────────────

class _NavRow extends StatelessWidget {
  const _NavRow({required this.row, required this.onTap});

  final PrivacyNavRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row.title,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w500,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  if (row.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 3),
                    Text(
                      row.subtitle,
                      style: KolekText.sans(
                        size: 12,
                        weight: FontWeight.w400,
                        height: 1.35,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Custom switch
// ─────────────────────────────────────────────────────────────────────────

class _KolekSwitch extends StatelessWidget {
  const _KolekSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 50,
      child: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeTrackColor: KolekColors.blue600,
        activeThumbColor: Colors.white,
        inactiveTrackColor: AppearancePage.line(context),
        inactiveThumbColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}