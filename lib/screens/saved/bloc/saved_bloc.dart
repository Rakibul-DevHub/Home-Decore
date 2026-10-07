import 'package:flutter_bloc/flutter_bloc.dart';

import 'saved_event.dart';
import 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc() : super(const SavedState()) {
    on<SavedTabChanged>(_onTabChanged);
    on<SavedItemRemoved>(_onItemRemoved);
  }

  void _onTabChanged(SavedTabChanged event, Emitter<SavedState> emit) {
    if (event.tab == state.tab) return;
    emit(state.copyWith(tab: event.tab));
  }

  void _onItemRemoved(
      SavedItemRemoved event,
      Emitter<SavedState> emit,
      ) {
    // Copy into a fresh set so Equatable's props comparison sees the
    // change. Mutating in place would keep the same reference.
    final next = Set<String>.from(state.savedIds)..remove(event.productId);
    emit(state.copyWith(savedIds: next));
  }
}