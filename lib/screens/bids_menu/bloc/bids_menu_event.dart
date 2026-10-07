// import 'package:equatable/equatable.dart';
//
// import '../data/bids_menu_data.dart';
//
// sealed class BidsMenuEvent extends Equatable {
//   const BidsMenuEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// /// User picked a tab (My Auctions / My Bids).
// final class BidsMenuTabChanged extends BidsMenuEvent {
//   const BidsMenuTabChanged(this.tab);
//
//   final BidsMenuTab tab;
//
//   @override
//   List<Object?> get props => [tab];
// }
//
// /// User tapped a bid card. The screen handles navigation.
// final class BidsMenuListingOpened extends BidsMenuEvent {
//   const BidsMenuListingOpened(this.id);
//
//   final String id;
//
//   @override
//   List<Object?> get props => [id];
// }










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

/// User tapped the action button on a bid card. [action] is the button
/// label — "Counter" or "Pay Now".
final class BidsMenuCardActionPressed extends BidsMenuEvent {
  const BidsMenuCardActionPressed(this.id, this.action);

  final String id;
  final String action;

  @override
  List<Object?> get props => [id, action];
}