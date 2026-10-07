import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/bids_menu_bloc.dart';
import '../bloc/bids_menu_event.dart';
import '../bloc/bids_menu_state.dart';
import '../data/bids_menu_data.dart';

class BidsMenuScreen extends StatelessWidget {
  const BidsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _BidsMenuAppBar(),
            const _BidsMenuTabs(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: BlocBuilder<BidsMenuBloc, BidsMenuState>(
                builder: (context, state) {
                  if (state.isEmpty) return const _EmptyState();
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                    children: [
                      // ── Section header ──────────────────────────
                      Text(
                        state.sectionHeader,
                        style: KolekText.sans(
                          size: 15,
                          weight: FontWeight.w600,
                          height: 1.2,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 14),
                      // ── Cards ───────────────────────────────────
                      for (var i = 0;
                      i < state.visibleListings.length;
                      i++) ...[
                        _BidCard(listing: state.visibleListings[i]),
                        if (i < state.visibleListings.length - 1)
                          const SizedBox(height: 14),
                      ],
                    ],
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

// -------------------------
// App bar — back arrow + "Bids" (left-aligned)
// -------------------------

class _BidsMenuAppBar extends StatelessWidget {
  const _BidsMenuAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Text(
            BidsMenuData.title,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------
// Tabs — My Auctions / My Bids
// -------------------------

class _BidsMenuTabs extends StatelessWidget {
  const _BidsMenuTabs();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BidsMenuBloc, BidsMenuState, BidsMenuTab>(
      selector: (s) => s.tab,
      builder: (context, current) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
        child: Row(
          children: [
            for (var i = 0; i < BidsMenuData.tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 22),
              _TabItem(
                label: BidsMenuData.tabs[i].label,
                selected: current == BidsMenuData.tabs[i].value,
                onTap: () => context.read<BidsMenuBloc>().add(
                  BidsMenuTabChanged(BidsMenuData.tabs[i].value),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    label,
                    style: KolekText.sans(
                      size: 14,
                      weight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                      height: 1.0,
                      color: selected
                          ? AppearancePage.foreground(context)
                          : AppearancePage.muted(context),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 2,
                  color: selected
                      ? AppearancePage.foreground(context)
                      : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------
// Bid card
// -------------------------

class _BidCard extends StatelessWidget {
  const _BidCard({required this.listing});

  final BidListing listing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<BidsMenuBloc>().add(BidsMenuListingOpened(listing.id));
        Navigator.of(context).pushNamed(AppRoute.productDetails);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppearancePage.line(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ───────────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                listing.thumbnail,
                width: 76,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // ── Details ─────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    listing.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.2,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _kv(
                    context,
                    'Listed at:',
                    '\$${listing.listedAtPrice}',
                  ),
                  const SizedBox(height: 2),
                  _kv(
                    context,
                    listing.isWinningBid
                        ? 'Winning bid:'
                        : 'Highest bid:',
                    '\$${listing.bidPrice}',
                  ),
                  const SizedBox(height: 8),
                  _StatusPill(status: listing.status),
                  const SizedBox(height: 6),
                  Text(
                    listing.footerLabel,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.2,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// "Label:  value" row — label muted, value bold foreground.
  Widget _kv(BuildContext context, String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w400,
              height: 1.3,
              color: AppearancePage.muted(context),
            ),
          ),
          TextSpan(
            text: value,
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w600,
              height: 1.3,
              color: AppearancePage.foreground(context),
            ),
          ),
        ],
      ),
    );
  }
}

/// Colored dot + status label. Blue for active/waiting, green for done.
class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final BidStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BidStatus.active || BidStatus.waitingForPayment =>
      KolekColors.blue600,
      BidStatus.completed => KolekColors.green600,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          BidsMenuData.statusLabel(status),
          style: KolekText.sans(
            size: 12,
            weight: FontWeight.w500,
            height: 1.0,
            color: color,
          ),
        ),
      ],
    );
  }
}

// -------------------------
// Empty state
// -------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/offer_bid.svg',
            width: 42,
            height: 42,
            colorFilter: AppearancePage.iconFilter(context),
          ),
          const SizedBox(height: 12),
          Text(
            BidsMenuData.emptyMessage,
            style: KolekText.sans(
              size: 15,
              weight: FontWeight.w500,
              color: AppearancePage.muted(context),
            ),
          ),
        ],
      ),
    );
  }
}