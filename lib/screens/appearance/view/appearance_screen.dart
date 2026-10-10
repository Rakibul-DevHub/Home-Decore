import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../appearance_page.dart';
import '../bloc/appearance_bloc.dart';
import '../bloc/appearance_event.dart';
import '../bloc/appearance_state.dart';
import '../data/appearance_data.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _AppearanceAppBar(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: BlocBuilder<AppearanceBloc, AppearanceState>(
                builder: (context, state) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      for (var i = 0;
                      i < AppearanceData.options.length;
                      i++) ...[
                        _ThemeOptionRow(
                          label: AppearanceData.options[i].label,
                          selected:
                          state.mode == AppearanceData.options[i].mode,
                          onTap: () => context.read<AppearanceBloc>().add(
                            AppearanceModeChanged(
                              AppearanceData.options[i].mode,
                            ),
                          ),
                        ),
                        if (i < AppearanceData.options.length - 1)
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 18,
                            endIndent: 18,
                            color: AppearancePage.line(context),
                          ),
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

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + "Appearance"
// ─────────────────────────────────────────────────────────────────────────

class _AppearanceAppBar extends StatelessWidget {
  const _AppearanceAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
            AppearanceData.title,
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
// Theme option row — label + radio indicator
// ─────────────────────────────────────────────────────────────────────────

class _ThemeOptionRow extends StatelessWidget {
  const _ThemeOptionRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: KolekText.sans(
                  size: 15,
                  weight: FontWeight.w500,
                  height: 1.2,
                  color: AppearancePage.foreground(context),
                ),
              ),
            ),
            _RadioIndicator(selected: selected),
          ],
        ),
      ),
    );
  }
}

/// Circular radio indicator. Unselected: outlined circle. Selected:
/// filled blue circle with a white check.
class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final accent = KolekColors.blue600;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? accent : Colors.transparent,
        border: Border.all(
          color: selected ? accent : AppearancePage.line(context),
          width: 2,
        ),
      ),
      child: selected
          ? const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      )
          : null,
    );
  }
}