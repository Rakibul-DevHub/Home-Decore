import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocked_accounts_event.dart';
import 'blocked_accounts_state.dart';

class BlockedAccountsBloc
    extends Bloc<BlockedAccountsEvent, BlockedAccountsState> {
  BlockedAccountsBloc() : super(const BlockedAccountsState()) {
    on<BlockedSearchChanged>(_onSearchChanged);
    on<BlockedUserUnblocked>(_onUserUnblocked);
  }

  void _onSearchChanged(
      BlockedSearchChanged event,
      Emitter<BlockedAccountsState> emit,
      ) {
    emit(state.copyWith(query: event.query));
  }

  void _onUserUnblocked(
      BlockedUserUnblocked event,
      Emitter<BlockedAccountsState> emit,
      ) {
    final next =
    state.users.where((u) => u.id != event.id).toList(growable: false);
    emit(state.copyWith(users: next));
    // TODO: call the API to unblock [event.id].
  }
}