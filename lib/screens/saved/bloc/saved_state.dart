import 'package:equatable/equatable.dart';

import '../../shop/data/shop_data.dart';
import '../data/saved_data.dart';

final class SavedState extends Equatable {
  const SavedState({
    this.savedIds = SavedData.initialSavedIds,
    this.tab = SavedTab.all,
  });

  /// IDs of every product the user has bookmarked. Order matches
  /// [ShopData.products] so the grid is stable across rebuilds.
  final Set<String> savedIds;

  final SavedTab tab;

  /// Products from the shop catalog that are currently saved, in catalog
  /// order. The tab filter is applied in the UI — see [visibleProducts].
  List<ShopProduct> get savedProducts => ShopData.products
      .where((p) => savedIds.contains(p.id))
      .toList(growable: false);

  /// The subset of [savedProducts] shown for the current [tab].
  ///
  /// - `all` / `artwork` → every saved product
  /// - `posts` → empty (no post model yet)
  List<ShopProduct> get visibleProducts =>
      tab == SavedTab.posts ? const <ShopProduct>[] : savedProducts;

  bool get isEmpty =>
      tab == SavedTab.posts
          ? true
          : savedProducts.isEmpty;

  SavedState copyWith({
    Set<String>? savedIds,
    SavedTab? tab,
  }) {
    return SavedState(
      savedIds: savedIds ?? this.savedIds,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [savedIds, tab];
}