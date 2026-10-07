part of 'pricing_screen.dart';

class _PaymentSection extends StatelessWidget {
  const _PaymentSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppearancePage.line(context)),
      ),
      child: const Row(
        children: [
          Expanded(
            child: _PaymentItem(
              iconAsset: PricingData.debitCardIconAsset,
              label: PricingData.debitCardLabel,
            ),
          ),
          Expanded(
            child: _PaymentItem(
              iconAsset: PricingData.creditCardIconAsset,
              label: PricingData.creditCardLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  const _PaymentItem({
    required this.iconAsset,
    required this.label,
  });

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconAsset,
          width: 46,
          height: 37,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w500,
            height: 1.2,
            color: AppearancePage.foreground(context),
          ),
        ),
      ],
    );
  }
}

/// Blue info card with lock icon and "securely processed" copy.
class _SecurityNote extends StatelessWidget {
  const _SecurityNote();

  @override
  Widget build(BuildContext context) {
    final accent = KolekColors.blue600;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline, size: 22, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: PricingData.securePrefix,
                    style: KolekText.mono(
                      size: 13,
                      weight: FontWeight.w400,
                      height: 1.55,
                      color: accent,
                    ),
                  ),
                  TextSpan(
                    text: PricingData.secureBrand,
                    style: KolekText.mono(
                      size: 13,
                      weight: FontWeight.w600,
                      height: 1.55,
                      color: accent,
                    ),
                  ),
                  TextSpan(
                    text: PricingData.secureSuffix,
                    style: KolekText.mono(
                      size: 13,
                      weight: FontWeight.w400,
                      height: 1.55,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}