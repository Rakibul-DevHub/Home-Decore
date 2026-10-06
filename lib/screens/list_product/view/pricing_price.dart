part of 'pricing_screen.dart';

/// Segmented price field: currency picker | text input | static ".00".
class _PriceField extends StatelessWidget {
  const _PriceField({
    required this.controller,
    required this.currency,
    required this.onCurrencyChanged,
    required this.onPriceChanged,
  });

  final TextEditingController controller;
  final String currency;
  final ValueChanged<String> onCurrencyChanged;
  final ValueChanged<String> onPriceChanged;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: line),
      ),
      child: Row(
        children: [
          // ── Currency picker ─────────────────────────────────────
          PopupMenuButton<String>(
            tooltip: '',
            padding: EdgeInsets.zero,
            position: PopupMenuPosition.under,
            color: AppearancePage.menu(context),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: line),
            ),
            onSelected: onCurrencyChanged,
            itemBuilder: (context) => [
              for (final c in PricingData.currencyOptions)
                PopupMenuItem<String>(
                  value: c,
                  height: 44,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      c,
                      style: KolekText.sans(size: 14, color: fg),
                    ),
                  ),
                ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text(
                    currency,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w500,
                      height: 1.0,
                      color: fg,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: muted,
                  ),
                ],
              ),
            ),
          ),
          // Divider between currency and amount
          Container(width: 1, height: 28, color: line),
          // ── Amount input ────────────────────────────────────────
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onPriceChanged,
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
              style: KolekText.mono(
                size: 14,
                weight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0,
                color: fg,
              ),
              cursorColor: KolekColors.blue600,
              decoration: InputDecoration(
                isDense: true,
                hintText: PricingData.priceHint,
                hintStyle: KolekText.mono(
                  size: 14,
                  weight: FontWeight.w400,
                  height: 1.0,
                  color: muted,
                ),
                border: InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          // ── Static .00 suffix ───────────────────────────────────
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: line.withValues(alpha: 0.4),
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(9),
              ),
            ),
            child: Text(
              PricingData.priceSuffix,
              style: KolekText.mono(
                size: 14,
                weight: FontWeight.w500,
                height: 1.0,
                color: muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}