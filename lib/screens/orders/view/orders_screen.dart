import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../../../widgets/notification_line_mapper.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import '../data/orders_data.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _OrdersAppBar(),
            const _OrdersTabs(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: BlocBuilder<OrdersBloc, OrdersState>(
                builder: (context, state) {
                  if (state.isEmpty) {
                    return const _EmptyState();
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                    itemCount: state.visibleOrders.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _OrderCard(order: state.visibleOrders[index]);
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

// ----------------------------------------------------------------
// App bar — back arrow left, title center, bell right
// ----------------------------------------------------------------

class _OrdersAppBar extends StatelessWidget {
  const _OrdersAppBar();

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
          Expanded(
            child: Text(
              OrdersData.title,
              style: KolekText.sans(
                size: 18,
                weight: FontWeight.w600,
                height: 1.0,
                color: fg,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () {
              // TODO: open notifications.
            },
            icon: SvgPicture.asset(
              'assets/icons/notification_active.svg',
              width: 22,
              height: 22,
              colorMapper: NotificationLineMapper(AppearancePage.icon(context)),
            ),
          ),
        ],
      ),
    );
  }
}

/// ----------------------------------------------------------------
/// Tabs — All / In Progress / Completed, underline on selected
/// ----------------------------------------------------------------

class _OrdersTabs extends StatelessWidget {
  const _OrdersTabs();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrdersBloc, OrdersState, OrdersTab>(
      selector: (s) => s.tab,
      builder: (context, current) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        child: Row(
          children: [
            for (var i = 0; i < OrdersData.tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 24),
              _TabItem(
                label: OrdersData.tabs[i].label,
                selected: current == OrdersData.tabs[i].value,
                onTap: () => context.read<OrdersBloc>().add(
                  OrdersTabChanged(OrdersData.tabs[i].value),
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

// ----------------------------------------------------------------
// Order card
// ----------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    final line = AppearancePage.line(context);

    return GestureDetector(
      onTap: () => context
          .read<OrdersBloc>()
          .add(OrdersItemOpened(order.id)),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- Thumbnail --------------------------------------------------------------------------------─
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                order.thumbnail,
                width: 88,
                height: 108,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // ---- Details ----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    order.title,
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
                    order.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.2,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${order.price}',
                    style: KolekText.sans(
                      size: 18,
                      weight: FontWeight.w600,
                      height: 1.0,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StatusRow(order: order),
                  const SizedBox(height: 4),
                  Text(
                    order.purchasedLabel,
                    style: KolekText.sans(
                      size: 11,
                      weight: FontWeight.w400,
                      height: 1.2,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  if (order.status == OrderStatus.shipped) ...[
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => context
                          .read<OrdersBloc>()
                          .add(OrdersTrackRequested(order.id)),
                      behavior: HitTestBehavior.opaque,
                      child: Text(
                        OrdersData.trackOrderLabel,
                        style: KolekText.sans(
                          size: 12,
                          weight: FontWeight.w500,
                          height: 1.0,
                          color: KolekColors.blue600,
                          decoration: TextDecoration.underline,
                          decorationColor: KolekColors.blue600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // ---- Chevron ----
            Padding(
              padding: const EdgeInsets.only(left: 6, top: 4),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: AppearancePage.icon(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Colored dot + status label. Colors depend on status.
class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.order});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(context, order.status);

    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          OrdersData.statusLabel(order.status),
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

  Color _colorFor(BuildContext context, OrderStatus status) {
    switch (status) {
      case OrderStatus.preparingToShip:
      case OrderStatus.shipped:
        return KolekColors.blue600;
      case OrderStatus.delivered:
        return KolekColors.green600;
      case OrderStatus.canceled:
        return AppearancePage.muted(context);
    }
  }
}

// ----------------------------------------------------------------
// Empty state
// ----------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 42,
              color: AppearancePage.muted(context),
            ),
            const SizedBox(height: 16),
            Text(
              'No orders here yet',
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