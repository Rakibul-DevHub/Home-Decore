import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/list_product_bloc.dart';
import '../bloc/list_product_event.dart';
import '../bloc/list_product_state.dart';

class FramingScreen extends StatelessWidget {
  const FramingScreen({super.key});

  static const options = ['Framed', 'Not Framed'];

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final line = AppearancePage.line(context);

    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: fg, size: 22),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Framing',
                    style: KolekText.sans(
                      size: 18,
                      weight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ── Options List ─────────────────────────────────────
            Expanded(
              child: BlocSelector<ListProductBloc, ListProductState, String>(
                selector: (s) => s.framing,
                builder: (context, current) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: options.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 32,
                      thickness: 1,
                      color: line,
                    ),
                    itemBuilder: (context, index) {
                      final option = options[index];
                      final selected = current == option;

                      return InkWell(
                        onTap: () {
                          context
                              .read<ListProductBloc>()
                              .add(ListProductFramingChanged(option));
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                option,
                                style: KolekText.sans(
                                  size: 15,
                                  weight: FontWeight.w500,
                                  color: fg,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected
                                        ? KolekColors.blue600
                                        : AppearancePage.muted(context),
                                    width: selected ? 5.5 : 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
