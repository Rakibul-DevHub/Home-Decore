import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/messages_data.dart';

final class MessagesState extends Equatable {
  const MessagesState({
    this.threads = const [],
    this.folderTitle = MessagesData.folderTitle,
    this.query = '',
  });

  final List<MessageThread> threads;
  final String folderTitle;
  final String query;

  List<MessageThread> get visibleThreads {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return threads;
    return threads
        .where(
          (t) =>
              t.name.toLowerCase().contains(q) ||
              t.preview.toLowerCase().contains(q),
        )
        .toList(growable: false);
  }

  MessagesState copyWith({
    List<MessageThread>? threads,
    String? folderTitle,
    String? query,
  }) {
    return MessagesState(
      threads: threads ?? this.threads,
      folderTitle: folderTitle ?? this.folderTitle,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [threads, folderTitle, query];
}

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit()
      : super(MessagesState(threads: MessagesData.threads));

  void setQuery(String query) => emit(state.copyWith(query: query));

  void clearQuery() => emit(state.copyWith(query: ''));
}
