import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/saved_bloc.dart';
import '../bloc/saved_event.dart';
import '../bloc/saved_state.dart';
import '../data/saved_data.dart';
import '../../shop/data/shop_data.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SavedAppBar(),
            const _SavedTabs(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: BlocBuilder<SavedBloc, SavedState>(
                builder: (context, state) {
                  if (state.isEmpty) {
                    return _EmptyState(tab: state.tab);
                  }
                  final products = state.visibleProducts;
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
                    itemCount: products.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 18,
                      childAspectRatio: .67,
                    ),
                    itemBuilder: (context, index) {
                      return _ProductCard(product: products[index]);
                    },
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

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow left, "Saved" centered
// ─────────────────────────────────────────────────────────────────────────

class _SavedAppBar extends StatelessWidget {
  const _SavedAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints:
              const BoxConstraints(minWidth: 40, minHeight: 40),
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                size: 24,
                color: AppearancePage.foreground(context),
              ),
            ),
          ),
          Text(
            SavedData.title,
            style: KolekText.sans(
              size: 18,
              weight: FontWeight.w600,
              height: 1.0,
              color: AppearancePage.foreground(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Tabs — All / Artwork / Posts, underline on selected
// ─────────────────────────────────────────────────────────────────────────

class _SavedTabs extends StatelessWidget {
  const _SavedTabs();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SavedBloc, SavedState, SavedTab>(
      selector: (s) => s.tab,
      builder: (context, current) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Row(
          children: [
            for (var i = 0; i < SavedData.tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 22),
              _TabItem(
                label: SavedData.tabs[i].label,
                selected: current == SavedData.tabs[i].value,
                onTap: () => context.read<SavedBloc>().add(
                  SavedTabChanged(SavedData.tabs[i].value),
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

// ─────────────────────────────────────────────────────────────────────────
// Product card — identical layout to the Shop screen's grid tile
// ─────────────────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ShopProduct product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('saved-${product.id}'),
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoute.productDetails),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  product.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _SaveButton(productId: product.id),
                ),
                if (product.isAuction && product.auctionRemaining != null)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: _AuctionTimerBadge(
                      remaining: product.auctionRemaining!,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: KolekText.sans(
              size: 16,
              weight: FontWeight.w500,
              height: 1.25,
              color: AppearancePage.foreground(context),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '\$${product.price}',
                style: KolekText.sans(
                  size: 14,
                  weight: FontWeight.w700,
                  color: AppearancePage.foreground(context),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 22,
                height: 22,
                child: product.isAuction
                    ? SvgPicture.asset(
                  'assets/icons/auction.svg',
                  width: 20,
                  height: 20,
                  colorFilter: AppearancePage.iconFilter(context),
                )
                    : Icon(
                  Icons.add_circle_outline,
                  size: 22,
                  color: AppearancePage.icon(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Bookmark toggle — reads its own saved flag from the bloc so only this
/// button rebuilds when tapped. On the Saved screen every item starts
/// saved, so this shows the active icon and tapping removes it from the
/// list.
class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SavedBloc, SavedState, bool>(
      selector: (state) => state.savedIds.contains(productId),
      builder: (context, saved) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context
                .read<SavedBloc>()
                .add(SavedItemRemoved(productId)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                saved
                    ? 'assets/icons/save_active.svg'
                    : 'assets/icons/save_post.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Auction countdown — identical to Shop screen
// ─────────────────────────────────────────────────────────────────────────

class _AuctionTimerBadge extends StatefulWidget {
  const _AuctionTimerBadge({required this.remaining});

  final Duration remaining;

  @override
  State<_AuctionTimerBadge> createState() => _AuctionTimerBadgeState();
}

class _AuctionTimerBadgeState extends State<_AuctionTimerBadge> {
  static const _tick = Duration(seconds: 1);

  late Duration _remaining;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _remaining = widget.remaining;
    _ticker = Timer.periodic(_tick, (_) {
      if (!mounted) return;
      setState(() {
        final next = _remaining - _tick;
        _remaining = next.isNegative ? Duration.zero : next;
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    return '${_two(days)}d : ${_two(hours)}h : ${_two(minutes)}m';
  }

  String _two(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: KolekColors.neutral200,
        border: Border.all(
          color: KolekColors.blue600.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule,
            size: 13,
            color: KolekColors.blue600,
          ),
          const SizedBox(width: 4),
          Text(
            _format(_remaining),
            style: const TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: KolekColors.blue600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tab});

  final SavedTab tab;

  @override
  Widget build(BuildContext context) {
    final message = tab == SavedTab.posts
        ? SavedData.emptyPostsMessage
        : SavedData.emptyArtworkMessage;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 42,
              color: AppearancePage.muted(context),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 15,
                weight: FontWeight.w500,
                color: AppearancePage.muted(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}