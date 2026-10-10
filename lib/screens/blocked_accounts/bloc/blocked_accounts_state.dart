import 'package:equatable/equatable.dart';

import '../data/blocked_accounts_data.dart';

final class BlockedAccountsState extends Equatable {
  const BlockedAccountsState({
    this.users = BlockedAccountsData.users,
    this.query = '',
  });

  final List<BlockedUser> users;
  final String query;

  bool get isSearching => query.trim().isNotEmpty;

  List<BlockedUser> get visibleUsers {
    if (!isSearching) return users;
    final q = query.trim().toLowerCase();
    return users
        .where((u) => u.name.toLowerCase().contains(q))
        .toList(growable: false);
  }

  bool get isEmpty => users.isEmpty;
  bool get hasNoMatches => isSearching && visibleUsers.isEmpty;

  BlockedAccountsState copyWith({
    List<BlockedUser>? users,
    String? query,
  }) {
    return BlockedAccountsState(
      users: users ?? this.users,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [users, query];
}