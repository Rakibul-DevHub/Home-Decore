class CartLine {
  const CartLine({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  final String id;
  final String image;
  final String name;
  final int price;
  final int quantity;

  CartLine copyWith({int? quantity}) => CartLine(
    id: id,
    image: image,
    name: name,
    price: price,
    quantity: quantity ?? this.quantity,
  );
}

abstract final class CartData {
  static const shipping = 0;
  static const initialItems = [
    CartLine(
      id: 'nordic-1',
      image: 'assets/images/vase_series.png',
      name: 'Handmade Nordic\nAbstract Ceramic Vase',
      price: 149,
      quantity: 1,
    ),
    CartLine(
      id: 'nordic-2',
      image: 'assets/images/vase_series.png',
      name: 'Handmade Nordic\nAbstract Ceramic Vase',
      price: 149,
      quantity: 1,
    ),
  ];
}
