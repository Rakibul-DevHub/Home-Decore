import 'package:equatable/equatable.dart';

sealed class InboxEvent extends Equatable {
  const InboxEvent();

  @override
  List<Object?> get props => [];
}

/// User typed (or pasted) into the composer field.
final class InboxDraftChanged extends InboxEvent {
  const InboxDraftChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped the send button (or pressed enter).
final class InboxMessageSent extends InboxEvent {
  const InboxMessageSent();
}