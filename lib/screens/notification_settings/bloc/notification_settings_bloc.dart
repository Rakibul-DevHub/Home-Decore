import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/notification_settings_data.dart';
import 'notification_settings_event.dart';
import 'notification_settings_state.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc() : super(NotificationSettingsState.initial) {
    on<NotificationToggleChanged>(_onToggleChanged);
  }

  void _onToggleChanged(
      NotificationToggleChanged event,
      Emitter<NotificationSettingsState> emit,
      ) {
    // Copy into a new map so Equatable's props comparison sees the change.
    final next = Map<NotificationToggleId, bool>.from(state.values);
    next[event.id] = event.value;

    emit(state.copyWith(values: next));

    // TODO: persist to the backend / local storage. Debounce here if
    // you're sending a network request per flip.
  }
}