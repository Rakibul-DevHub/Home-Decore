import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/privacy_data.dart';
import 'privacy_event.dart';
import 'privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc() : super(PrivacyState.initial) {
    on<PrivacyToggleChanged>(_onToggleChanged);
    on<PrivacyNavRowTapped>(_onNavRowTapped);
  }

  void _onToggleChanged(
      PrivacyToggleChanged event,
      Emitter<PrivacyState> emit,
      ) {
    // Fresh map so Equatable's props comparison sees the change.
    final next = Map<PrivacyToggleId, bool>.from(state.values);
    next[event.id] = event.value;
    emit(state.copyWith(values: next));
  }

  void _onNavRowTapped(
      PrivacyNavRowTapped event,
      Emitter<PrivacyState> emit,
      ) {
    // Navigation handled by the screen via a BlocListener.
  }
}