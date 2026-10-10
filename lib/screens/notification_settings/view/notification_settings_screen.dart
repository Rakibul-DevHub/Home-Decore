import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/notification_settings_bloc.dart';
import '../bloc/notification_settings_event.dart';
import '../bloc/notification_settings_state.dart';
import '../data/notification_settings_data.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _NotificationSettingsAppBar(),
            Expanded(
              child: BlocBuilder<NotificationSettingsBloc,
                  NotificationSettingsState>(
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
                    children: [
                      // ── Subtitle ───────────────────────────────
                      Text(
                        NotificationSettingsData.subtitle,
                        style: KolekText.sans(
                          size: 13,
                          weight: FontWeight.w400,
                          height: 1.5,
                          color: AppearancePage.muted(context),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Sections ───────────────────────────────
                      for (var s = 0;
                      s < state.sections.length;
                      s++) ...[
                        _SectionLabel(label: state.sections[s].label),
                        const SizedBox(height: 4),
                        for (final toggle in state.sections[s].toggles)
                          _ToggleRow(
                            toggle: toggle,
                            value: state.valueOf(toggle.id),
                            onChanged: (v) => context
                                .read<NotificationSettingsBloc>()
                                .add(
                              NotificationToggleChanged(toggle.id, v),
                            ),
                          ),
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
    );
  }
}

// --------
// App bar — back arrow + "Notification"
// --------

class _NotificationSettingsAppBar extends StatelessWidget {
  const _NotificationSettingsAppBar();

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
            NotificationSettingsData.appBarTitle,
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

// --------
// Section label — uppercase mono
// --------

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

// --------
// Toggle row — title + subtitle on the left, switch on the right
// --------

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.toggle,
    required this.value,
    required this.onChanged,
  });

  final NotificationToggle toggle;
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
                  if (toggle.subtitle.isNotEmpty) ...[
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

// --------
// Custom switch — matches the design's rounded style without a visible
// outline, using the app's blue accent when ON.
// --------

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