part of 'pricing_screen.dart';

class _ShippingSection extends StatelessWidget {
  const _ShippingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppearancePage.line(context)),
      ),
      child: Column(
        children: [
          _ShippingRow(
            title: PricingData.shipsFromTitle,
            value: PricingData.shipsFromValue,
            onTap: () {
              // TODO: open a location picker.
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: AppearancePage.line(context),
          ),
          _ShippingRow(
            title: PricingData.shippingOptionsTitle,
            value: PricingData.shippingOptionsValue,
            onTap: () {
              // TODO: open shipping-options picker.
            },
          ),
        ],
      ),
    );
  }
}

class _ShippingRow extends StatelessWidget {
  const _ShippingRow({
    required this.title,
    required this.value,
    required this.onTap,
  });

  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              title,
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w500,
                height: 1.0,
                color: fg,
              ),
            ),
            const Spacer(),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: KolekText.sans(
                  size: 14,
                  weight: FontWeight.w400,
                  height: 1.0,
                  color: fg,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}