import 'package:equatable/equatable.dart';

import '../data/bids_menu_data.dart';

final class BidsMenuState extends Equatable {
  const BidsMenuState({
    this.auctions = BidsMenuData.auctions,
    this.myBids = BidsMenuData.myBids,
    this.tab = BidsMenuTab.myAuctions,
  });

  final List<BidListing> auctions;
  final List<BidListing> myBids;
  final BidsMenuTab tab;

  /// Listings shown under the current tab, in source order.
  List<BidListing> get visibleListings => switch (tab) {
    BidsMenuTab.myAuctions => auctions,
    BidsMenuTab.myBids => myBids,
  };

  /// Section header shown above the list on the current tab.
  String get sectionHeader => switch (tab) {
    BidsMenuTab.myAuctions => BidsMenuData.myAuctionsSectionHeader,
    BidsMenuTab.myBids => BidsMenuData.myBidsSectionHeader,
  };

  bool get isEmpty => visibleListings.isEmpty;

  BidsMenuState copyWith({
    List<BidListing>? auctions,
    List<BidListing>? myBids,
    BidsMenuTab? tab,
  }) {
    return BidsMenuState(
      auctions: auctions ?? this.auctions,
      myBids: myBids ?? this.myBids,
      tab: tab ?? this.tab,
    );
  }

  @override
  List<Object?> get props => [auctions, myBids, tab];
}