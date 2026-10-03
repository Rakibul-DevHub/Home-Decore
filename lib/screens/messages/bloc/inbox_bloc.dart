import 'package:flutter_bloc/flutter_bloc.dart';

import '../../messages/data/messages_data.dart';
import 'inbox_event.dart';
import 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc({required MessageThread thread})
      : super(
    InboxState(
      thread: thread,
      messages: List<ChatMessage>.from(thread.messages),
      draft: thread.draft,
    ),
  ) {
    on<InboxDraftChanged>(_onDraftChanged);
    on<InboxMessageSent>(_onMessageSent);
  }

  void _onDraftChanged(InboxDraftChanged event, Emitter<InboxState> emit) {
    emit(state.copyWith(draft: event.value));
  }

  void _onMessageSent(InboxMessageSent event, Emitter<InboxState> emit) {
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