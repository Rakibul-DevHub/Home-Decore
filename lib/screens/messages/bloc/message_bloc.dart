// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../data/messages_data.dart';
// import 'message_event.dart';
// import 'messages_state.dart';
//
// class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
//   MessagesBloc() : super(MessagesState(threads: MessagesData.threads)) {
//     on<MessagesQueryChanged>(_onQueryChanged);
//     on<MessagesQueryCleared>(_onQueryCleared);
//   }
//
//   void _onQueryChanged(
//       MessagesQueryChanged event,
//       Emitter<MessagesState> emit,
//       ) {
//     emit(state.copyWith(query: event.query));
//   }
//
//   void _onQueryCleared(
//       MessagesQueryCleared event,
//       Emitter<MessagesState> emit,
//       ) {
//     emit(state.copyWith(query: ''));
//   }
// }











import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/messages_data.dart';
import 'message_event.dart';
import 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc() : super(MessagesState(threads: MessagesData.threads)) {
    on<MessagesQueryChanged>(_onQueryChanged);
    on<MessagesQueryCleared>(_onQueryCleared);
    on<MessagesFilterChanged>(_onFilterChanged);
  }

  void _onQueryChanged(
      MessagesQueryChanged event,
      Emitter<MessagesState> emit,
      ) {
    emit(state.copyWith(query: event.query));
  }

  void _onQueryCleared(
      MessagesQueryCleared event,
      Emitter<MessagesState> emit,
      ) {
    emit(state.copyWith(query: ''));
  }

  void _onFilterChanged(
      MessagesFilterChanged event,
      Emitter<MessagesState> emit,
      ) {
    emit(state.copyWith(filter: event.filter));
  }
}