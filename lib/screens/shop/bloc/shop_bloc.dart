// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../data/shop_data.dart';
//
// // ───────────────────────────── Events ─────────────────────────────
//
// sealed class ShopEvent extends Equatable {
//   const ShopEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// /// User picked a sort option from the dropdown.
// class ShopSortSelected extends ShopEvent {
//   const ShopSortSelected(this.index);
//
//   final int index;
//
//   @override
//   List<Object> get props => [index];
// }
//
// /// User returned from the filter screen — mark filter as applied.
// class ShopFilterApplied extends ShopEvent {
//   const ShopFilterApplied();
// }
//
// /// User tapped the "+" on a product card.
// class ShopCartItemAdded extends ShopEvent {
//   const ShopCartItemAdded();
// }
//
// /// User tapped the bookmark icon on a product card.
// class ShopProductSaveToggled extends ShopEvent {
//   const ShopProductSaveToggled(this.id);
//
//   final String id;
//
//   @override
//   List<Object> get props => [id];
// }
//
// // ───────────────────────────── State ──────────────────────────────
//
// class ShopState extends Equatable {
//   const ShopState({
//     this.sortIndex = 0,
//     this.filterActive = false,
//     this.cartCount = 2,
//     this.savedProductIds = const <String>{},
//   });
//
//   final int sortIndex;
//   final bool filterActive;
//   final int cartCount;
//
//   /// Product IDs the user has bookmarked. Immutable — a new set is created
//   /// on every toggle so [props] comparison catches the change.
//   final Set<String> savedProductIds;
//
//   String get sortLabel => ShopData.sortOptions[sortIndex];
//
//   bool isSaved(String productId) => savedProductIds.contains(productId);
//
//   ShopState copyWith({
//     int? sortIndex,
//     bool? filterActive,
//     int? cartCount,
//     Set<String>? savedProductIds,
//   }) =>
//       ShopState(
//         sortIndex: sortIndex ?? this.sortIndex,
//         filterActive: filterActive ?? this.filterActive,
//         cartCount: cartCount ?? this.cartCount,
//         savedProductIds: savedProductIds ?? this.savedProductIds,
//       );
//
//   @override
//   List<Object> get props => [
//     sortIndex,
//     filterActive,
//     cartCount,
//     savedProductIds,
//   ];
// }
//
// // ───────────────────────────── Bloc ──────────────────────────────
//
// class ShopBloc extends Bloc<ShopEvent, ShopState> {
//   ShopBloc() : super(const ShopState()) {
//     on<ShopSortSelected>(_onSortSelected);
//     on<ShopFilterApplied>(_onFilterApplied);
//     on<ShopCartItemAdded>(_onCartItemAdded);
//     on<ShopProductSaveToggled>(_onProductSaveToggled);
//   }
//
//   void _onSortSelected(ShopSortSelected event, Emitter<ShopState> emit) {
//     emit(state.copyWith(sortIndex: event.index));
//   }
//
//   void _onFilterApplied(ShopFilterApplied event, Emitter<ShopState> emit) {
//     emit(state.copyWith(filterActive: true));
//   }
//
//   void _onCartItemAdded(ShopCartItemAdded event, Emitter<ShopState> emit) {
//     emit(state.copyWith(cartCount: state.cartCount + 1));
//   }
//
//   void _onProductSaveToggled(
//       ShopProductSaveToggled event,
//       Emitter<ShopState> emit,
//       ) {
//     final next = Set<String>.from(state.savedProductIds);
//     if (!next.remove(event.id)) next.add(event.id);
//     emit(state.copyWith(savedProductIds: next));
//   }
// }






import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/shop_data.dart';

// ───────────────────────────── Events ─────────────────────────────

sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopSortSelected extends ShopEvent {
  const ShopSortSelected(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

class ShopFilterApplied extends ShopEvent {
  const ShopFilterApplied(this.filter);

  final ShopFilter filter;

  @override
  List<Object> get props => [filter];
}

class ShopFilterCleared extends ShopEvent {
  const ShopFilterCleared();
}

class ShopCartItemAdded extends ShopEvent {
  const ShopCartItemAdded();
}

class ShopProductSaveToggled extends ShopEvent {
  const ShopProductSaveToggled(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

// ───────────────────────────── State ──────────────────────────────

class ShopState extends Equatable {
  const ShopState({
    this.sortIndex = 0,
    this.cartCount = 2,
    this.appliedFilter = ShopFilter.initial,
    this.savedProductIds = const <String>{},
  });

  final int sortIndex;
  final int cartCount;
  final ShopFilter appliedFilter;
  final Set<String> savedProductIds;

  String get sortLabel => ShopData.sortOptions[sortIndex];

  bool get filterActive => !appliedFilter.isDefault;

  /// The products currently visible in the grid, after filter + sort.
  List<ShopProduct> get visibleProducts =>
      ShopData.visible(appliedFilter, sortIndex);

  bool isSaved(String productId) => savedProductIds.contains(productId);

  ShopState copyWith({
    int? sortIndex,
    int? cartCount,
    ShopFilter? appliedFilter,
    Set<String>? savedProductIds,
  }) =>
      ShopState(
        sortIndex: sortIndex ?? this.sortIndex,
        cartCount: cartCount ?? this.cartCount,
        appliedFilter: appliedFilter ?? this.appliedFilter,
        savedProductIds: savedProductIds ?? this.savedProductIds,
      );

  @override
  List<Object> get props =>
      [sortIndex, cartCount, appliedFilter, savedProductIds];
}

// ───────────────────────────── Bloc ──────────────────────────────

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(const ShopState()) {
    on<ShopSortSelected>(_onSortSelected);
    on<ShopFilterApplied>(_onFilterApplied);
    on<ShopFilterCleared>(_onFilterCleared);
    on<ShopCartItemAdded>(_onCartItemAdded);
    on<ShopProductSaveToggled>(_onProductSaveToggled);
  }

  void _onSortSelected(ShopSortSelected event, Emitter<ShopState> emit) {
    emit(state.copyWith(sortIndex: event.index));
  }

  void _onFilterApplied(ShopFilterApplied event, Emitter<ShopState> emit) {
    emit(state.copyWith(appliedFilter: event.filter));
  }

  void _onFilterCleared(ShopFilterCleared event, Emitter<ShopState> emit) {
    emit(state.copyWith(appliedFilter: ShopFilter.initial));
  }

  void _onCartItemAdded(ShopCartItemAdded event, Emitter<ShopState> emit) {
    emit(state.copyWith(cartCount: state.cartCount + 1));
  }

  void _onProductSaveToggled(
      ShopProductSaveToggled event,
      Emitter<ShopState> emit,
      ) {
    final next = Set<String>.from(state.savedProductIds);
    if (!next.remove(event.id)) next.add(event.id);
    emit(state.copyWith(savedProductIds: next));
  }
}