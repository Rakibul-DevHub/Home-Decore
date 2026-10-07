import 'package:equatable/equatable.dart';

import '../data/selling_data.dart';

final class SellingState extends Equatable {
  const SellingState({
    this.listings = SellingData.listings,
    this.tab = SellingTab.active,
  });

  final List<SellingListing> listings;
  final SellingTab tab;

  /// Listings matching the current tab, in source order.
  List<SellingListing> get visibleListings =>
      listings.where((l) => l.tab == tab).toList(growable: false);

  bool get isEmpty => visibleListings.isEmpty;

  SellingState copyWith({
    List<SellingListing>? listings,
    SellingTab? tab,
  }) {
    return SellingState(
      listings: listings ?? this.listings,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [listings, tab];
}