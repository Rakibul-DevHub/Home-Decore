import 'package:equatable/equatable.dart';

import '../data/saved_data.dart';

sealed class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => [];
}

/// User picked a filter tab (All / Artwork / Posts).
final class SavedTabChanged extends SavedEvent {
  const SavedTabChanged(this.tab);

  final SavedTab tab;

  @override
  List<Object?> get props => [tab];
}

/// User tapped the bookmark icon on a card to unsave it.
final class SavedItemRemoved extends SavedEvent {
  const SavedItemRemoved(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}