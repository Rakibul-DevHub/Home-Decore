part of 'list_product_screen.dart';

/// Primary CTA. Disabled until the form's required fields are valid.
// class _NextButton extends StatelessWidget {
//   const _NextButton({required this.enabled});
//
//   final bool enabled;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: FilledButton(
//         onPressed: enabled
//             ? () => context
//             .read<ListProductBloc>()
//             .add(const ListProductSubmitted())
//             : null,
//         style: FilledButton.styleFrom(
//           backgroundColor: KolekColors.blue600,
//           disabledBackgroundColor:
//           KolekColors.blue600.withValues(alpha: 0.35),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0),
//           ),
//           // Style the label via textStyle so it applies consistently
//           // across enabled and disabled states.
//           textStyle: KolekText.sans(
//             size: 16,
//             weight: FontWeight.w500,
//             height: 20 / 16,
//             letterSpacing: 0,
//           ),
//         ),
//         child: const Text(ListProductData.nextLabel),
//       ),
//     );
//   }
// }



class _NextButton extends StatelessWidget {
  const _NextButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: enabled ? () => _openPricing(context) : null,
        style: FilledButton.styleFrom(
          backgroundColor: KolekColors.blue600,
          disabledBackgroundColor:
          KolekColors.blue600.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          textStyle: KolekText.sans(
            size: 16,
            weight: FontWeight.w500,
            height: 20 / 16,
            letterSpacing: 0,
          ),
        ),
        child: const Text(ListProductData.nextLabel),
      ),
    );
  }

  void _openPricing(BuildContext context) {
    final bloc = context.read<ListProductBloc>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: bloc,
          child: const PricingScreen(),
        ),
      ),
    );
  }
}
/// Secondary action below the CTA — a text-only row with a fade-out
/// divider underneath.
class _SaveDraftLink extends StatelessWidget {
  const _SaveDraftLink();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => context
              .read<ListProductBloc>()
              .add(const ListProductDraftSaved()),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Text(
                ListProductData.draftLabel,
                textAlign: TextAlign.center,
                style: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w500,
                  height: 20 / 16,
                  letterSpacing: 0,
                  color: AppearancePage.muted(context),
                ),
              ),
            ),
          ),
        ),
        const KolekFadeDivider(height: 2),
      ],
    );
  }
}