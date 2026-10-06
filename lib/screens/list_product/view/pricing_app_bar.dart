part of 'pricing_screen.dart';

/// Custom app bar: black circular back button, centered title, blue
/// "Next" text on the right.
class _PricingAppBar extends StatelessWidget {
  const _PricingAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final bg = AppearancePage.background(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: fg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: bg,
              ),
            ),
          ),
          const Spacer(),
          Text(
            PricingData.appBarTitle,
            style: KolekText.sans(
              size: 18,
              weight: FontWeight.w600,
              height: 1.0,
              letterSpacing: 0,
              color: fg,
            ),
          ),
          const Spacer(),
          BlocSelector<ListProductBloc, ListProductState, bool>(
            selector: (s) => s.canSubmitPricing,
            builder: (context, enabled) => TextButton(
              onPressed: enabled
                  ? () {
                // TODO: navigate to the review/summary screen.
                Navigator.of(context).pop();
              }
                  : null,
              child: Text(
                PricingData.nextLabel,
                style: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w500,
                  height: 20 / 16,
                  letterSpacing: 0,
                  color: enabled
                      ? KolekColors.blue600
                      : AppearancePage.muted(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}