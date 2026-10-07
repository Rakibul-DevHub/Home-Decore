import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsItemTapped>(_onItemTapped);
    on<SettingsLogoutRequested>(_onLogoutRequested);
    on<SettingsDeleteAccountRequested>(_onDeleteAccountRequested);
  }

  void _onItemTapped(SettingsItemTapped event, Emitter<SettingsState> emit) {
    emit(state.copyWith(lastTappedId: event.id));
    // Row-level navigation is handled by the screen — the bloc only
    // records which row the user interacted with.
  }

  void _onLogoutRequested(
      SettingsLogoutRequested event,
      Emitter<SettingsState> emit,
      ) {
    emit(state.copyWith(loggingOut: true));
    // TODO: hook real sign-out here. The UI listens for `loggingOut == true`
    // and navigates to the login route when it exists.
  }

  void _onDeleteAccountRequested(
      SettingsDeleteAccountRequested event,
      Emitter<SettingsState> emit,
      ) {
    emit(state.copyWith(deletingAccount: true));
    // TODO: open the deactivation confirmation flow.
  }
}