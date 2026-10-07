/// Lifecycle state of a purchased order.
enum OrderStatus { preparingToShip, shipped, delivered, canceled }

/// Tabs at the top of the Orders screen.
enum OrdersTab { all, inProgress, completed }

class OrderItem {
  const OrderItem({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.artist,
    required this.price,
    required this.status,
    required this.purchasedLabel,
  });

  final String id;
  final String thumbnail;
  final String title;
  final String artist;
  final int price;
  final OrderStatus status;

  /// Human-readable purchase date, e.g. "Purchased Aug 18, 2024".
  final String purchasedLabel;
}

abstract final class OrdersData {
  static const title = 'Orders & Purchases';

  static const tabs = <({String label, OrdersTab value})>[
    (label: 'All', value: OrdersTab.all),
    (label: 'In Progress', value: OrdersTab.inProgress),
    (label: 'Completed', value: OrdersTab.completed),
  ];

  static const trackOrderLabel = 'Track Order';

  /// Human-readable label for each status.
  static String statusLabel(OrderStatus s) => switch (s) {
    OrderStatus.preparingToShip => 'Preparing to Ship',
    OrderStatus.shipped => 'Shipped',
    OrderStatus.delivered => 'Delivered',
    OrderStatus.canceled => 'Canceled',
  };

  /// Which top-level tab a status belongs under.
  static bool matchesTab(OrderStatus status, OrdersTab tab) {
    switch (tab) {
      case OrdersTab.all:
        return true;
      case OrdersTab.inProgress:
        return status == OrderStatus.preparingToShip ||
            status == OrderStatus.shipped;
      case OrdersTab.completed:
        return status == OrderStatus.delivered ||
            status == OrderStatus.canceled;
    }
  }

  static const orders = <OrderItem>[
    OrderItem(
      id: 'o1',
      thumbnail: 'assets/images/img1.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      price: 650,
      status: OrderStatus.preparingToShip,
      purchasedLabel: 'Purchased Aug 18, 2024',
    ),
    OrderItem(
      id: 'o2',
      thumbnail: 'assets/images/img2.png',
      title: 'Blue Study',
      artist: 'Jordan Lee',
      price: 425,
      status: OrderStatus.shipped,
      purchasedLabel: 'Purchased Aug 10, 2024',
    ),
    OrderItem(
      id: 'o3',
      thumbnail: 'assets/images/img3.png',
      title: 'Sunday Morning',
      artist: 'Maya Chen',
      price: 650,
      status: OrderStatus.delivered,
      purchasedLabel: 'Purchased Aug 18, 2024',
    ),
    OrderItem(
      id: 'o4',
      thumbnail: 'assets/images/img4.png',
      title: 'Quiet Forms',
      artist: 'Naomi Sato',
      price: 315,
      status: OrderStatus.canceled,
      purchasedLabel: 'Purchased Aug 18, 2024',
    ),
  ];
}