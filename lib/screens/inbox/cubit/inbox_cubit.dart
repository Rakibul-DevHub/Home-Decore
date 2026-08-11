import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class InboxCubit extends Cubit<InboxState> {
  InboxCubit({required MessageThread thread})
      : super(
          InboxState(
            thread: thread,
            messages: List<ChatMessage>.from(thread.messages),
            draft: thread.draft,
          ),
        );

  void setDraft(String value) => emit(state.copyWith(draft: value));

  void send() {
    final text = state.draft.trim();
    if (text.isEmpty) return;

    final message = ChatMessage(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      timeLabel: _nowLabel(),
      isMine: true,
    );

    emit(
      state.copyWith(
        messages: [...state.messages, message],
        draft: '',
      ),
    );
  }

  static String _nowLabel() {
    final now = DateTime.now();
    final hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
