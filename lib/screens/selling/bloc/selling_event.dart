import 'package:equatable/equatable.dart';

import '../data/selling_data.dart';

sealed class SellingEvent extends Equatable {
  const SellingEvent();

  @override
  List<Object?> get props => [];
}

/// User picked a tab (Active / Sold / Drafts).
final class SellingTabChanged extends SellingEvent {
  const SellingTabChanged(this.tab);

  final SellingTab tab;

  @override
  List<Object?> get props => [tab];
}

/// User tapped a card. The screen handles navigation; the bloc just
/// records the intent so it could be tracked / persisted.
final class SellingListingOpened extends SellingEvent {
  const SellingListingOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// User picked an action from the ⋯ menu on a card.
final class SellingMenuActionSelected extends SellingEvent {
  const SellingMenuActionSelected(this.id, this.action);

  final String id;
  final SellingMenuAction action;

  @override
  List<Object?> get props => [id, action];
}