part of 'pricing_screen.dart';

class _PaymentSection extends StatelessWidget {
  const _PaymentSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ListProductBloc, ListProductState, PaymentMethod?>(
      selector: (s) => s.paymentMethod,
      builder: (context, selected) => Row(
        children: [
          Expanded(
            child: _PaymentTile(
              icon: Icons.account_balance_wallet_outlined,
              label: PricingData.debitCardLabel,
              selected: selected == PaymentMethod.debit,
              onTap: () => context.read<ListProductBloc>().add(
                const ListProductPaymentMethodChanged(
                  PaymentMethod.debit,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _PaymentTile(
              icon: Icons.credit_card,
              label: PricingData.creditCardLabel,
              selected: selected == PaymentMethod.credit,
              onTap: () => context.read<ListProductBloc>().add(
                const ListProductPaymentMethodChanged(
                  PaymentMethod.credit,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final line = AppearancePage.line(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? KolekColors.blue600 : line,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 26,
              color: selected ? KolekColors.blue600 : fg,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: KolekText.sans(
                size: 13,
                weight: FontWeight.w500,
                height: 1.0,
                color: fg,
              ),
            ),
          ],
        ),
      ),
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