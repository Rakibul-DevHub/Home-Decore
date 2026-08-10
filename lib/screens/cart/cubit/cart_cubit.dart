import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/cart_data.dart';

class CartState extends Equatable {
  const CartState({required this.items});

  final List<CartLine> items;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  int get subtotal =>
      items.fold(0, (sum, item) => sum + item.price * item.quantity);
  int get total => subtotal + CartData.shipping;

  @override
  List<Object> get props => [items];
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(items: CartData.initialItems));

  void setQuantity(String id, int quantity) {
    if (quantity < 1) return;
    emit(
      CartState(
        items: state.items
            .map(
              (item) =>
                  item.id == id ? item.copyWith(quantity: quantity) : item,
            )
            .toList(growable: false),
      ),
    );
  }

  void increment(String id) {
    final item = state.items.firstWhere((line) => line.id == id);
    setQuantity(id, item.quantity + 1);
  }

  void decrement(String id) {
    final item = state.items.firstWhere((line) => line.id == id);
    setQuantity(id, item.quantity - 1);
  }
}
