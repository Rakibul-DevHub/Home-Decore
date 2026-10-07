import 'package:equatable/equatable.dart';

import '../data/orders_data.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

/// User picked a tab (All / In Progress / Completed).
final class OrdersTabChanged extends OrdersEvent {
  const OrdersTabChanged(this.tab);

  final OrdersTab tab;

  @override
  List<Object?> get props => [tab];
}

/// User tapped "Track Order" on a shipped order.
final class OrdersTrackRequested extends OrdersEvent {
  const OrdersTrackRequested(this.orderId);

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

/// User tapped an order card to view its details.
final class OrdersItemOpened extends OrdersEvent {
  const OrdersItemOpened(this.orderId);

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}