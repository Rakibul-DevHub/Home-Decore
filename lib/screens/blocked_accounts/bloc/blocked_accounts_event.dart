import 'package:equatable/equatable.dart';

sealed class BlockedAccountsEvent extends Equatable {
  const BlockedAccountsEvent();

  @override
  List<Object?> get props => [];
}

/// User typed in the search field.
final class BlockedSearchChanged extends BlockedAccountsEvent {
  const BlockedSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// User tapped "Unblock" on a row.
final class BlockedUserUnblocked extends BlockedAccountsEvent {
  const BlockedUserUnblocked(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}