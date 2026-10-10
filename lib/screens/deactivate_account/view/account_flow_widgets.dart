import 'package:flutter/material.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';

class AccountFlowAppBar extends StatelessWidget {
  const AccountFlowAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: KolekText.sans(
                size: 20,
                weight: FontWeight.w600,
                height: 1.0,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountOutlinedButton extends StatelessWidget {
  const AccountOutlinedButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.busy = false,
  });

  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: KolekText.sans(size: 16, weight: FontWeight.w500),
        ),
        child: busy
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              )
            : Text(label),
      ),
    );
  }
}

class AccountFilledButton extends StatelessWidget {
  const AccountFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = KolekColors.red600,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          disabledBackgroundColor: color.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: KolekText.sans(size: 16, weight: FontWeight.w500),
        ),
        child: busy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(label),
      ),
    );
  }
}

class AccountBulletList extends StatelessWidget {
  const AccountBulletList({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final color = AppearancePage.foreground(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 10),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.45,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
