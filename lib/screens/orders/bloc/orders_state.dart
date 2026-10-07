import 'package:equatable/equatable.dart';

import '../data/orders_data.dart';

final class OrdersState extends Equatable {
  const OrdersState({
    this.orders = OrdersData.orders,
    this.tab = OrdersTab.all,
  });

  final List<OrderItem> orders;
  final OrdersTab tab;

  /// Orders matching the current tab, in source order.
  List<OrderItem> get visibleOrders => orders
      .where((o) => OrdersData.matchesTab(o.status, tab))
      .toList(growable: false);

  bool get isEmpty => visibleOrders.isEmpty;

  OrdersState copyWith({
    List<OrderItem>? orders,
    OrdersTab? tab,
  }) {
    return OrdersState(
      orders: orders ?? this.orders,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [orders, tab];
}