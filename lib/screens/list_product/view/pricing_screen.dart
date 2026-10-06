import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_fade_divider.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/list_product_bloc.dart';
import '../bloc/list_product_event.dart';
import '../bloc/list_product_state.dart';
import '../data/pricing_data.dart';

part 'pricing_app_bar.dart';
part 'pricing_listing_type.dart';
part 'pricing_price.dart';
part 'pricing_shipping.dart';
part 'pricing_payment.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  final _priceCtrl = TextEditingController();
  final _startingBidCtrl = TextEditingController();
  final _reservePriceCtrl = TextEditingController();
  final _bidIncrementCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Seed from state in case the user came back to this screen.
    final state = context.read<ListProductBloc>().state;
    _priceCtrl.text = state.price;
    _startingBidCtrl.text = state.startingBid;
    _reservePriceCtrl.text = state.reservePrice;
    _bidIncrementCtrl.text = state.bidIncrement;
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    _startingBidCtrl.dispose();
    _reservePriceCtrl.dispose();
    _bidIncrementCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          children: [
            const _PricingAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: [
                  // ── Listing Type ────────────────────────────────────
                  const _SectionLabel(PricingData.listingTypeLabel),
                  const SizedBox(height: 12),
                  BlocSelector<ListProductBloc, ListProductState,
                      ListingKind>(
                    selector: (s) => s.listingKind,
                    builder: (context, kind) => Column(
                      children: [
                        _ListingTypeCard(
                          title: PricingData.buyNowTitle,
                          subtitle: PricingData.buyNowSubtitle,
                          iconAsset: PricingData.buyNowIconAsset,
                          selected: kind == ListingKind.buyNow,
                          onTap: () => context.read<ListProductBloc>().add(
                            const ListProductListingKindChanged(
                              ListingKind.buyNow,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _ListingTypeCard(
                          title: PricingData.auctionTitle,
                          subtitle: PricingData.auctionSubtitle,
                          iconAsset: PricingData.auctionIconAsset,
                          selected: kind == ListingKind.auction,
                          onTap: () => context.read<ListProductBloc>().add(
                            const ListProductListingKindChanged(
                              ListingKind.auction,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Price or Auction Options ───────────────────────
                  BlocSelector<ListProductBloc, ListProductState, ListingKind>(
                    selector: (s) => s.listingKind,
                    builder: (context, kind) {
                      if (kind == ListingKind.buyNow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SectionLabel(PricingData.priceLabel),
                            const SizedBox(height: 12),
                            _PriceField(
                              controller: _priceCtrl,
                              onPriceChanged: (v) => context
                                  .read<ListProductBloc>()
                                  .add(ListProductPriceChanged(v)),
                            ),
                          ],
                        );
                      }

                      return _AuctionPricingSection(
                        startingBidCtrl: _startingBidCtrl,
                        reservePriceCtrl: _reservePriceCtrl,
                        bidIncrementCtrl: _bidIncrementCtrl,
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // ── Shipping ────────────────────────────────────────
                  const _SectionLabel(PricingData.shippingLabel),
                  const SizedBox(height: 12),
                  const _ShippingSection(),
                  const SizedBox(height: 24),

                  // ── Payment ─────────────────────────────────────────
                  const _SectionLabel(PricingData.paymentLabel),
                  const SizedBox(height: 12),
                  const _PaymentSection(),
                  const SizedBox(height: 20),

                  // ── Security note ───────────────────────────────────
                  const _SecurityNote(),

                  const SizedBox(height: 8),
                  const KolekFadeDivider(height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bold monospace section header — "Listing Type", "Price", etc.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KolekText.sans(
        size: 16,
        weight: FontWeight.w600,
        height: 20 / 16,
        letterSpacing: 0,
        color: AppearancePage.foreground(context),
      ),
    );
  }
}