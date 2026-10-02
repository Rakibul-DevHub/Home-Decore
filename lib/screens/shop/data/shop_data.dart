// class ShopProduct {
//   const ShopProduct({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.price,
//   });
//
//   final String id;
//   final String image;
//   final String name;
//   final int price;
// }
//
// abstract final class ShopData {
//   static const title = 'Shop';
//   static const subtitle =
//       'Discover original art and rare\nobjects from independent artists\nand collections.';
//   static const sortOptions = ['Newest', 'Price: Low', 'Price: High'];
//   static const products = [
//     ShopProduct(
//       id: 'nordic',
//       image: 'assets/images/nordic_vase.png',
//       name: 'Handmade Nordic Abstract\nCeramic Vase',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'stoneware',
//       image: 'assets/images/stoneware_vases.png',
//       name: 'Handmade Raw Stoneware\nPottery Vases',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'wall-art',
//       image: 'assets/images/wall_art.png',
//       name: 'Original Textured\nWall Art',
//       price: 149,
//     ),
//     ShopProduct(
//       id: 'table',
//       image: 'assets/images/table_and_vase.png',
//       name: 'Sculptural Table\nCollection',
//       price: 149,
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








enum ShopProductKind { buyNow, auction }

class ShopProduct {
  const ShopProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.kind = ShopProductKind.buyNow,
    this.auctionRemaining,
  });

  final String id;
  final String image;
  final String name;
  final int price;
  final ShopProductKind kind;

  /// Time remaining until the auction ends. Null for non-auction products.
  /// Const-friendly: the countdown widget converts it into a live ticking
  /// duration when the card first mounts.
  final Duration? auctionRemaining;

  bool get isAuction => kind == ShopProductKind.auction;
}

abstract final class ShopData {
  static const title = 'Shop';
  static const subtitle =
      'Discover original art and rare\nobjects from independent artists\nand collections.';
  static const sortOptions = ['Newest', 'Price: Low', 'Price: High'];
  static const products = [
    ShopProduct(
      id: 'nordic',
      image: 'assets/images/nordic_vase.png',
      name: 'Handmade Nordic Abstract\nCeramic Vase',
      price: 149,
    ),
    ShopProduct(
      id: 'stoneware',
      image: 'assets/images/stoneware_vases.png',
      name: 'Handmade Raw Stoneware\nPottery Vases',
      price: 149,
      kind: ShopProductKind.auction,
      auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
    ),
    ShopProduct(
      id: 'wall-art',
      image: 'assets/images/wall_art.png',
      name: 'Original Textured\nWall Art',
      price: 149,
    ),
    ShopProduct(
      id: 'table',
      image: 'assets/images/table_and_vase.png',
      name: 'Sculptural Table\nCollection',
      price: 149,
      kind: ShopProductKind.auction,
      auctionRemaining: Duration(days: 2, hours: 7, minutes: 1),
    ),
    ShopProduct(
      id: 'series',
      image: 'assets/images/vase_series.png',
      name: 'Vase Series',
      price: 149,
    ),
    ShopProduct(
      id: 'minimal',
      image: 'assets/images/vase_series_1.png',
      name: 'Minimal Stoneware Vase',
      price: 149,
    ),
  ];
}