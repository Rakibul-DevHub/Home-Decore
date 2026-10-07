// enum ShopProductKind { buyNow, auction }
//
// class ShopProduct {
//   const ShopProduct({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//     this.kind = ShopProductKind.buyNow,
//     this.auctionRemaining,
//   });
//
//   final String id;
//   final String image;
//   final String name;
//   final int price;
//   final ShopProductKind kind;
//
//   /// Time remaining until the auction ends. Null for non-auction products.
//   final Duration? auctionRemaining;
//
//   bool get isAuction => kind == ShopProductKind.auction;
// }
//
// abstract final class ShopData {
//   static const title = 'Shop';
//   static const subtitle =
//       'Discover original art and rare\nobjects from independent artists\nand collections.';
//
//   /// Sort options shown in the dropdown under the "Sort:" trigger.
//   static const sortOptions = [
//     'All',
//     'Newest',
//     'Low to Height',
//     'Height to Low',
//   ];
//
//   static const products = [
//     ShopProduct(
//       id: 'nordic',
//       image: 'assets/images/nordic_vase.png',
//       name: 'Handmade Nordic Abstract Ceramic Vase',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'stoneware',
//       image: 'assets/images/stoneware_vases.png',
//       name: 'Handmade Raw Stoneware Pottery Vases',
//       price: 149,
//       kind: ShopProductKind.auction,
//       auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
//     ),
//     ShopProduct(
//       id: 'wall-art',
//       image: 'assets/images/wall_art.png',
//       name: 'Original Textured Wall Art',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'table',
//       image: 'assets/images/table_and_vase.png',
//       name: 'Sculptural Table Collection',
//       price: 149,
//       kind: ShopProductKind.auction,
//       auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
//     ),
//     ShopProduct(
//       id: 'series',
//       image: 'assets/images/vase_series.png',
//       name: 'Vase Series',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'minimal',
//       image: 'assets/images/vase_series_1.png',
//       name: 'Minimal Stoneware Vase',
//       price: 149,
//     ),
//   ];
// }









/// Matches the "Listing Type" toggle on the filter screen.
enum ShopListingType { all, purchase, auction }

/// Snapshot of the filter state that gets applied to the shop grid.
///
/// Immutable — the filter screen builds one of these on "View Result" and
/// dispatches it to [ShopBloc] via `ShopFilterApplied`.
class ShopFilter {
  const ShopFilter({
    this.lowerPrice = 0,
    this.upperPrice = 5000,
    this.listingType = ShopListingType.all,
    this.category = 'All',
  });

  final double lowerPrice;
  final double upperPrice;
  final ShopListingType listingType;
  final String category;

  static const initial = ShopFilter();

  bool get isDefault =>
      lowerPrice == 0 &&
          upperPrice == 5000 &&
          listingType == ShopListingType.all &&
          category == 'All';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ShopFilter &&
              other.lowerPrice == lowerPrice &&
              other.upperPrice == upperPrice &&
              other.listingType == listingType &&
              other.category == category;

  @override
  int get hashCode =>
      Object.hash(lowerPrice, upperPrice, listingType, category);
}

enum ShopProductKind { buyNow, auction }

class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    this.kind = ShopProductKind.buyNow,
    this.auctionRemaining,
  });

  final String id;
  final String image;
  final String name;
  final int price;

  /// Matches one of the labels on the filter screen (e.g. 'Printing',
  /// 'Photography'). 'All' is a filter-only option and never appears here.
  final String category;

  final ShopProductKind kind;
  final Duration? auctionRemaining;

  bool get isAuction => kind == ShopProductKind.auction;
}

abstract final class ShopData {
  static const title = 'Shop';
  static const subtitle =
      'Discover original art and rare\nobjects from independent artists\nand collections.';

  static const sortOptions = [
    'All',
    'Newest',
    'Low to Height',
    'Height to Low',
  ];

  static const products = [
    ShopProduct(
      id: 'nordic',
      image: 'assets/images/nordic_vase.png',
      name: 'Handmade Nordic Abstract Ceramic Vase',
      price: 149,
      category: 'Sculpture',
    ),
    ShopProduct(
      id: 'stoneware',
      image: 'assets/images/stoneware_vases.png',
      name: 'Handmade Raw Stoneware Pottery Vases',
      price: 149,
      category: 'Printing',
      kind: ShopProductKind.auction,
      auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
    ),
    ShopProduct(
      id: 'wall-art',
      image: 'assets/images/wall_art.png',
      name: 'Original Textured Wall Art',
      price: 149,
      category: 'Drawing',
    ),
    ShopProduct(
      id: 'table',
      image: 'assets/images/table_and_vase.png',
      name: 'Sculptural Table Collection',
      price: 149,
      category: 'Mixed Media',
      kind: ShopProductKind.auction,
      auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
    ),
    ShopProduct(
      id: 'series',
      image: 'assets/images/vase_series.png',
      name: 'Vase Series',
      price: 149,
      category: 'Photography',
    ),
    ShopProduct(
      id: 'minimal',
      image: 'assets/images/vase_series_1.png',
      name: 'Minimal Stoneware Vase',
      price: 149,
      category: 'Digital Art',
    ),
  ];

  /// Number of products matching [filter] — used by the filter screen's
  /// "View Result" button to show a live count before the filter is applied.
  static int countMatching(ShopFilter filter) =>
      products.where((p) => matches(p, filter)).length;

  /// Whether [product] passes [filter]. Shared between the filter screen's
  /// count and the shop grid's visible list so the two stay consistent.
  static bool matches(ShopProduct product, ShopFilter filter) {
    if (product.price < filter.lowerPrice) return false;
    if (product.price > filter.upperPrice) return false;

    switch (filter.listingType) {
      case ShopListingType.purchase:
        if (product.kind != ShopProductKind.buyNow) return false;
      case ShopListingType.auction:
        if (product.kind != ShopProductKind.auction) return false;
      case ShopListingType.all:
        break;
    }

    if (filter.category != 'All' && product.category != filter.category) {
      return false;
    }

    return true;
  }

  /// Applies [filter] then sorts by [sortIndex] from [sortOptions].
  static List<ShopProduct> visible(ShopFilter filter, int sortIndex) {
    final list = products.where((p) => matches(p, filter)).toList();

    // 0: All → keep source order
    // 1: Newest → keep source order (products list is newest-first)
    // 2: Low to Height
    // 3: Height to Low
    if (sortIndex == 2) {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortIndex == 3) {
      list.sort((a, b) => b.price.compareTo(a.price));
    }

    return list;
  }
}