import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/selling_bloc.dart';
import '../bloc/selling_event.dart';
import '../bloc/selling_state.dart';
import '../data/selling_data.dart';

class SellingScreen extends StatelessWidget {
  const SellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SellingAppBar(),
            const _SellingTabs(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            // --- Scrollable list ----------------------
            Expanded(
              child: BlocBuilder<SellingBloc, SellingState>(
                builder: (context, state) {
                  final listings = state.visibleListings;

                  // Empty → return the state widget directly. Because it's a direct
                  // child of Expanded, it fills the whole available area, so the
                  // Center inside vertically + horizontally centers its content.
                  if (listings.isEmpty) {
                    return const _EmptyState();
                  }

                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      for (var i = 0; i < listings.length; i++) ...[
                        _ListingCard(listing: listings[i]),
                        if (i < listings.length - 1)
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            indent: 18,
                            endIndent: 18,
                            color: AppearancePage.line(context),
                          ),
                      ],
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
            // --- Pinned promo card -------------------
            const _PromoCard(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

// ----
// App bar — back arrow + "Selling" (left-aligned)
// ----

class _SellingAppBar extends StatelessWidget {
  const _SellingAppBar();

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
            SellingData.title,
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

// ----
// Tabs — Active / Sold / Drafts
// ----

class _SellingTabs extends StatelessWidget {
  const _SellingTabs();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SellingBloc, SellingState, SellingTab>(
      selector: (s) => s.tab,
      builder: (context, current) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 0),
        child: Row(
          children: [
            for (var i = 0; i < SellingData.tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 22),
              _TabItem(
                label: SellingData.tabs[i].label,
                selected: current == SellingData.tabs[i].value,
                onTap: () => context.read<SellingBloc>().add(
                  SellingTabChanged(SellingData.tabs[i].value),
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

// ----
// Listing card
// ----

/// Colors for the status dot + label. Defined here so each status maps
/// to a single source of truth.


class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing});

  final SellingListing listing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<SellingBloc>()
            .add(SellingListingOpened(listing.id));
        Navigator.of(context).pushNamed(AppRoute.productDetails);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 8, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Thumbnail -------------------------─
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                listing.thumbnail,
                width: 88,
                height: 112,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // --- Details ----------------------------─
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
                    listing.kindLabel,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.2,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    listing.priceLine,
                    style: KolekText.sans(
                      size: 16,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (listing.statusLabel != null)
                    _StatusPill(
                      label: listing.statusLabel!,
                      color: _statusColorFor(listing.shape),
                    )
                  else if (listing.bidsLabel != null)
                    Text(
                      listing.bidsLabel!,
                      style: KolekText.sans(
                        size: 12,
                        weight: FontWeight.w400,
                        height: 1.2,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                  if (listing.timeLeftLabel != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      listing.timeLeftLabel!,
                      style: KolekText.sans(
                        size: 12,
                        weight: FontWeight.w500,
                        height: 1.2,
                        color: KolekColors.blue600,
                      ),
                    ),
                  ],
                  if (listing.metaLabel != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      listing.metaLabel!,
                      style: KolekText.sans(
                        size: 11,
                        weight: FontWeight.w400,
                        height: 1.2,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // --- Overflow menu -------------------─
            _MenuButton(listingId: listing.id),
          ],
        ),
      ),
    );
  }

  Color _statusColorFor(SellingListingShape shape) {
    switch (shape) {
      case SellingListingShape.activeForSale:
      case SellingListingShape.soldDelivered:
        return KolekColors.green600;
      case SellingListingShape.soldReadyToShip:
        return KolekColors.orange600;
      case SellingListingShape.draft:
        return const Color(0xFF9CA3AF); // muted gray
      case SellingListingShape.activeAuction:
        return KolekColors.green600;
    }
  }
}

/// Colored dot + label — "● Active", "● Ready to Ship", etc.
class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
          label,
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

/// ⋯ menu — Edit / Share / Delete.
class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.listingId});

  final String listingId;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SellingMenuAction>(
      tooltip: '',
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      color: AppearancePage.menu(context),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppearancePage.line(context)),
      ),
      onSelected: (action) => context
          .read<SellingBloc>()
          .add(SellingMenuActionSelected(listingId, action)),
      itemBuilder: (context) => [
        _menuItem(context, 'Edit', SellingMenuAction.edit),
        _menuItem(context, 'Share', SellingMenuAction.share),
        _menuItem(
          context,
          'Delete',
          SellingMenuAction.delete,
          destructive: true,
        ),
      ],
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.more_horiz,
          size: 20,
          color: AppearancePage.icon(context),
        ),
      ),
    );
  }

  PopupMenuItem<SellingMenuAction> _menuItem(
      BuildContext context,
      String label,
      SellingMenuAction action, {
        bool destructive = false,
      }) {
    return PopupMenuItem<SellingMenuAction>(
      value: action,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        label,
        style: KolekText.sans(
          size: 14,
          weight: FontWeight.w500,
          color: destructive
              ? const Color(0xFFE5484D)
              : AppearancePage.foreground(context),
        ),
      ),
    );
  }
}

// ----
// Promo card — "Want to list something new?"
// ----

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppearancePage.line(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              SellingData.promoTitle,
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 16,
                weight: FontWeight.w600,
                height: 1.2,
                color: AppearancePage.foreground(context),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              SellingData.promoBody,
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 12,
                weight: FontWeight.w400,
                height: 1.5,
                color: AppearancePage.muted(context),
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: SizedBox(
                height: 44,
                child: FilledButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoute.listProduct),
                  style: FilledButton.styleFrom(
                    backgroundColor: KolekColors.blue600,
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ),
                  child: const Text(SellingData.promoButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----
// Empty state — shown when a tab has no listings
// ----

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sell_outlined,
            size: 42,
            color: AppearancePage.muted(context),
          ),
          const SizedBox(height: 12),
          Text(
            'Nothing here yet',
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