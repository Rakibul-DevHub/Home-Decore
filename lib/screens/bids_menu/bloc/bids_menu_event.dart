import 'package:equatable/equatable.dart';

import '../data/bids_menu_data.dart';

sealed class BidsMenuEvent extends Equatable {
  const BidsMenuEvent();

  @override
  List<Object?> get props => [];
}

/// User picked a tab (My Auctions / My Bids).
final class BidsMenuTabChanged extends BidsMenuEvent {
  const BidsMenuTabChanged(this.tab);

  final BidsMenuTab tab;

  @override
  List<Object?> get props => [tab];
}

/// User tapped a bid card. The screen handles navigation.
final class BidsMenuListingOpened extends BidsMenuEvent {
  const BidsMenuListingOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}