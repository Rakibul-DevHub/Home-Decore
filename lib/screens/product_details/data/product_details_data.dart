class ProductDetails {
  const ProductDetails({
    required this.images,
    required this.title,
    required this.price,
    required this.description,
    required this.seller,
  });

  final List<String> images;
  final String title;
  final int price;
  final String description;
  final String seller;
}

abstract final class ProductDetailsData {
  static const product = ProductDetails(
    images: [
      'assets/images/nordic_vase.png',
      'assets/images/vase_series.png',
      'assets/images/vase_series_1.png',
      'assets/images/nordic_vase.png',
      'assets/images/vase_series.png',
      'assets/images/vase_series_1.png',
      'assets/images/nordic_vase.png',
      'assets/images/vase_series.png',
    ],
    title: 'HANDMADE\nNORDIC ABSTRACT\nCERAMIC VASE',
    price: 149,
    description:
        'A one-of-a-kind ceramic vase with a fluid form inspired by '
        "nature's quiet movement. Each piece is individually shaped "
        'and finished by hand.',
    seller: 'Nordic Atelier',
  );
}
