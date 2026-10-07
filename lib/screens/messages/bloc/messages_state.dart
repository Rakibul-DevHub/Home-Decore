// import 'package:equatable/equatable.dart';
//
// import '../data/messages_data.dart';
//
// final class MessagesState extends Equatable {
//   const MessagesState({
//     this.threads = const [],
//     this.folderTitle = MessagesData.folderTitle,
//     this.query = '',
//   });
//
//   final List<MessageThread> threads;
//   final String folderTitle;
//   final String query;
//
//   List<MessageThread> get visibleThreads {
//     final q = query.trim().toLowerCase();
//     if (q.isEmpty) return threads;
//     return threads
//         .where(
//           (t) =>
//       t.name.toLowerCase().contains(q) ||
//           t.preview.toLowerCase().contains(q),
//     )
//         .toList(growable: false);
//   }
//
//   MessagesState copyWith({
//     List<MessageThread>? threads,
//     String? folderTitle,
//     String? query,
//   }) {
//     return MessagesState(
//       threads: threads ?? this.threads,
//       folderTitle: folderTitle ?? this.folderTitle,
//       query: query ?? this.query,
//     );
//   }
//
//   @override
//   List<Object?> get props => [threads, folderTitle, query];
// }











import 'package:equatable/equatable.dart';

import '../data/messages_data.dart';

/// Filter applied to the thread list.
enum MessagesFilter { all, unread }

final class MessagesState extends Equatable {
  const MessagesState({
    this.threads = const [],
    this.query = '',
    this.filter = MessagesFilter.all,
  });

  final List<MessageThread> threads;
  final String query;
  final MessagesFilter filter;

  List<MessageThread> get visibleThreads {
    var list = threads;

    if (filter == MessagesFilter.unread) {
      list = list.where((t) => t.unreadCount > 0).toList(growable: false);
    }

    final q = query.trim().toLowerCase();
    if (q.isEmpty) return list;

    return list
        .where(
          (t) =>
      t.name.toLowerCase().contains(q) ||
          t.preview.toLowerCase().contains(q),
    )
        .toList(growable: false);
  }

  MessagesState copyWith({
    List<MessageThread>? threads,
    String? query,
    MessagesFilter? filter,
  }) {
    return MessagesState(
      threads: threads ?? this.threads,
      query: query ?? this.query,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [threads, query, filter];
}