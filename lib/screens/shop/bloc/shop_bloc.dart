/**
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/shop_data.dart';

// ───────────────────────────── Events ─────────────────────────────

sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

/// Cycle to the next sort option (Newest → Price: Low → Price: High → Newest).
class ShopSortCycled extends ShopEvent {
  const ShopSortCycled();
}

/// User returned from the filter screen — mark filter as applied.
class ShopFilterApplied extends ShopEvent {
  const ShopFilterApplied();
}

/// User tapped the "+" on a product card.
class ShopCartItemAdded extends ShopEvent {
  const ShopCartItemAdded();
}

/// User tapped the bookmark icon on a product card.
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
    this.filterActive = false,
    this.cartCount = 2,
    this.savedProductIds = const <String>{},
  });

  final int sortIndex;
  final bool filterActive;
  final int cartCount;

  /// Product IDs the user has bookmarked. Immutable — a new set is created
  /// on every toggle so [props] comparison catches the change.
  final Set<String> savedProductIds;

  String get sortLabel => ShopData.sortOptions[sortIndex];

  bool isSaved(String productId) => savedProductIds.contains(productId);

  ShopState copyWith({
    int? sortIndex,
    bool? filterActive,
    int? cartCount,
    Set<String>? savedProductIds,
  }) =>
      ShopState(
        sortIndex: sortIndex ?? this.sortIndex,
        filterActive: filterActive ?? this.filterActive,
        cartCount: cartCount ?? this.cartCount,
        savedProductIds: savedProductIds ?? this.savedProductIds,
      );

  @override
  List<Object> get props => [
    sortIndex,
    filterActive,
    cartCount,
    savedProductIds,
  ];
}

// ───────────────────────────── Bloc ──────────────────────────────

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(const ShopState()) {
    on<ShopSortCycled>(_onSortCycled);
    on<ShopFilterApplied>(_onFilterApplied);
    on<ShopCartItemAdded>(_onCartItemAdded);
    on<ShopProductSaveToggled>(_onProductSaveToggled);
  }

  void _onSortCycled(ShopSortCycled event, Emitter<ShopState> emit) {
    emit(
      state.copyWith(
        sortIndex: (state.sortIndex + 1) % ShopData.sortOptions.length,
      ),
    );
  }

  void _onFilterApplied(ShopFilterApplied event, Emitter<ShopState> emit) {
    emit(state.copyWith(filterActive: true));
  }

  void _onCartItemAdded(ShopCartItemAdded event, Emitter<ShopState> emit) {
    emit(state.copyWith(cartCount: state.cartCount + 1));
  }

  void _onProductSaveToggled(
      ShopProductSaveToggled event,
      Emitter<ShopState> emit,
      ) {
    // Copy into a new set so Equatable's props comparison sees the change.
    // Mutating the existing set in place would keep the same reference and
    // the UI would never rebuild.
    final next = Set<String>.from(state.savedProductIds);
    if (!next.remove(event.id)) next.add(event.id);
    emit(state.copyWith(savedProductIds: next));
  }
}*/










import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/shop_data.dart';

// ───────────────────────────── Events ─────────────────────────────

sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

/// User picked a sort option from the dropdown.
class ShopSortSelected extends ShopEvent {
  const ShopSortSelected(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}

/// User returned from the filter screen — mark filter as applied.
class ShopFilterApplied extends ShopEvent {
  const ShopFilterApplied();
}

/// User tapped the "+" on a product card.
class ShopCartItemAdded extends ShopEvent {
  const ShopCartItemAdded();
}

/// User tapped the bookmark icon on a product card.
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
    this.filterActive = false,
    this.cartCount = 2,
    this.savedProductIds = const <String>{},
  });

  final int sortIndex;
  final bool filterActive;
  final int cartCount;

  /// Product IDs the user has bookmarked. Immutable — a new set is created
  /// on every toggle so [props] comparison catches the change.
  final Set<String> savedProductIds;

  String get sortLabel => ShopData.sortOptions[sortIndex];

  bool isSaved(String productId) => savedProductIds.contains(productId);

  ShopState copyWith({
    int? sortIndex,
    bool? filterActive,
    int? cartCount,
    Set<String>? savedProductIds,
  }) =>
      ShopState(
        sortIndex: sortIndex ?? this.sortIndex,
        filterActive: filterActive ?? this.filterActive,
        cartCount: cartCount ?? this.cartCount,
        savedProductIds: savedProductIds ?? this.savedProductIds,
      );

  @override
  List<Object> get props => [
    sortIndex,
    filterActive,
    cartCount,
    savedProductIds,
  ];
}

// ───────────────────────────── Bloc ──────────────────────────────

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(const ShopState()) {
    on<ShopSortSelected>(_onSortSelected);
    on<ShopFilterApplied>(_onFilterApplied);
    on<ShopCartItemAdded>(_onCartItemAdded);
    on<ShopProductSaveToggled>(_onProductSaveToggled);
  }

  void _onSortSelected(ShopSortSelected event, Emitter<ShopState> emit) {
    emit(state.copyWith(sortIndex: event.index));
  }

  void _onFilterApplied(ShopFilterApplied event, Emitter<ShopState> emit) {
    emit(state.copyWith(filterActive: true));
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