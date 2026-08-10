import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/shop_data.dart';

class ShopState extends Equatable {
  const ShopState({
    this.sortIndex = 0,
    this.filterActive = false,
    this.cartCount = 2,
  });

  final int sortIndex;
  final bool filterActive;
  final int cartCount;

  String get sortLabel => ShopData.sortOptions[sortIndex];

  ShopState copyWith({int? sortIndex, bool? filterActive, int? cartCount}) =>
      ShopState(
        sortIndex: sortIndex ?? this.sortIndex,
        filterActive: filterActive ?? this.filterActive,
        cartCount: cartCount ?? this.cartCount,
      );

  @override
  List<Object> get props => [sortIndex, filterActive, cartCount];
}

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopState());

  void cycleSort() {
    emit(
      state.copyWith(
        sortIndex: (state.sortIndex + 1) % ShopData.sortOptions.length,
      ),
    );
  }

  void markFilterApplied() => emit(state.copyWith(filterActive: true));

  void addToCart() => emit(state.copyWith(cartCount: state.cartCount + 1));
}
