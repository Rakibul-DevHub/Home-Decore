part of 'pricing_screen.dart';

/// Selectable card with title, subtitle, a right-aligned icon badge,
/// and a blue checkmark when selected.
class _ListingTypeCard extends StatelessWidget {
  const _ListingTypeCard({
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String iconAsset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? KolekColors.blue600 : line,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: KolekText.mono(
                      size: 15,
                      weight: FontWeight.w600,
                      height: 1.2,
                      letterSpacing: 0,
                      color: fg,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: KolekText.mono(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: 0,
                      color: muted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (selected)
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: KolekColors.blue600,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.white,
                    ),
                  )
                else
                  const SizedBox(height: 20),
                const SizedBox(height: 16),
                SvgPicture.asset(
                  iconAsset,
                  width: 36,
                  height: 36,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}