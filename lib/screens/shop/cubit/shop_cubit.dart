// // import 'package:equatable/equatable.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import '../data/shop_data.dart';
// //
// // class ShopState extends Equatable {
// //   const ShopState({
// //     this.sortIndex = 0,
// //     this.filterActive = false,
// //     this.cartCount = 2,
// //   });
// //
// //   final int sortIndex;
// //   final bool filterActive;
// //   final int cartCount;
// //
// //   String get sortLabel => ShopData.sortOptions[sortIndex];
// //
// //   ShopState copyWith({int? sortIndex, bool? filterActive, int? cartCount}) =>
// //       ShopState(
// //         sortIndex: sortIndex ?? this.sortIndex,
// //         filterActive: filterActive ?? this.filterActive,
// //         cartCount: cartCount ?? this.cartCount,
// //       );
// //
// //   @override
// //   List<Object> get props => [sortIndex, filterActive, cartCount];
// // }
// //
// // class ShopCubit extends Cubit<ShopState> {
// //   ShopCubit() : super(const ShopState());
// //
// //   void cycleSort() {
// //     emit(
// //       state.copyWith(
// //         sortIndex: (state.sortIndex + 1) % ShopData.sortOptions.length,
// //       ),
// //     );
// //   }
// //
// //   void markFilterApplied() => emit(state.copyWith(filterActive: true));
// //
// //   void addToCart() => emit(state.copyWith(cartCount: state.cartCount + 1));
// // }
//
//
//
//
//
//
//
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
// /// Cycle to the next sort option (Newest → Price: Low → Price: High → Newest).
// class ShopSortCycled extends ShopEvent {
//   const ShopSortCycled();
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
// // ───────────────────────────── State ──────────────────────────────
//
// class ShopState extends Equatable {
//   const ShopState({
//     this.sortIndex = 0,
//     this.filterActive = false,
//     this.cartCount = 2,
//   });
//
//   final int sortIndex;
//   final bool filterActive;
//   final int cartCount;
//
//   String get sortLabel => ShopData.sortOptions[sortIndex];
//
//   ShopState copyWith({int? sortIndex, bool? filterActive, int? cartCount}) =>
//       ShopState(
//         sortIndex: sortIndex ?? this.sortIndex,
//         filterActive: filterActive ?? this.filterActive,
//         cartCount: cartCount ?? this.cartCount,
//       );
//
//   @override
//   List<Object> get props => [sortIndex, filterActive, cartCount];
// }
//
// // ───────────────────────────── Bloc ──────────────────────────────
//
// class ShopBloc extends Bloc<ShopEvent, ShopState> {
//   ShopBloc() : super(const ShopState()) {
//     on<ShopSortCycled>(_onSortCycled);
//     on<ShopFilterApplied>(_onFilterApplied);
//     on<ShopCartItemAdded>(_onCartItemAdded);
//   }
//
//   void _onSortCycled(ShopSortCycled event, Emitter<ShopState> emit) {
//     emit(
//       state.copyWith(
//         sortIndex: (state.sortIndex + 1) % ShopData.sortOptions.length,
//       ),
//     );
//   }
//
//   void _onFilterApplied(ShopFilterApplied event, Emitter<ShopState> emit) {
//     emit(state.copyWith(filterActive: true));
//   }
//
//   void _onCartItemAdded(ShopCartItemAdded event, Emitter<ShopState> emit) {
//     emit(state.copyWith(cartCount: state.cartCount + 1));
//   }
// }