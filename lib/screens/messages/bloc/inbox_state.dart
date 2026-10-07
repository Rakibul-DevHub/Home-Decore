import 'package:equatable/equatable.dart';

import '../../messages/data/messages_data.dart';

final class InboxState extends Equatable {
  const InboxState({
    required this.thread,
    required this.messages,
    this.draft = '',
  });

  final MessageThread thread;
  final List<ChatMessage> messages;
  final String draft;

  InboxState copyWith({
    MessageThread? thread,
    List<ChatMessage>? messages,
    String? draft,
  }) {
    return InboxState(
      thread: thread ?? this.thread,
      messages: messages ?? this.messages,
      draft: draft ?? this.draft,
    );
  }

  @override
  List<Object?> get props => [thread.id, messages, draft];
}