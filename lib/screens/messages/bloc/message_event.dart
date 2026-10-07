// import 'package:equatable/equatable.dart';
//
// sealed class MessagesEvent extends Equatable {
//   const MessagesEvent();
//
//   @override
//   List<Object?> get props => [];
// }
//
// /// User typed in the search field.
// final class MessagesQueryChanged extends MessagesEvent {
//   const MessagesQueryChanged(this.query);
//
//   final String query;
//
//   @override
//   List<Object?> get props => [query];
// }
//
// /// Search was cleared — restores the full thread list.
// final class MessagesQueryCleared extends MessagesEvent {
//   const MessagesQueryCleared();
// }











import 'package:equatable/equatable.dart';

import 'messages_state.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object?> get props => [];
}

/// User typed in the search field.
final class MessagesQueryChanged extends MessagesEvent {
  const MessagesQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// Search was cleared — restores the full thread list.
final class MessagesQueryCleared extends MessagesEvent {
  const MessagesQueryCleared();
}

/// User tapped a filter tab (All / Unread).
final class MessagesFilterChanged extends MessagesEvent {
  const MessagesFilterChanged(this.filter);

  final MessagesFilter filter;

  @override
  List<Object?> get props => [filter];
}