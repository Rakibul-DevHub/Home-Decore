import 'package:flutter_bloc/flutter_bloc.dart';

import '../appearance_page.dart';
import 'appearance_event.dart';
import 'appearance_state.dart';

class AppearanceBloc extends Bloc<AppearanceEvent, AppearanceState> {
  AppearanceBloc() : super(AppearanceState(mode: AppearancePage.themeMode)) {
    on<AppearanceModeChanged>(_onModeChanged);
  }

  void _onModeChanged(
      AppearanceModeChanged event,
      Emitter<AppearanceState> emit,
      ) {
    if (event.mode == state.mode) return;

    // The notifier is the app-wide source of truth — writing to it also
    // updates `MaterialApp.themeMode` via the ValueListenableBuilder in
    // main.dart, which repaints the whole tree.
    AppearancePage.setThemeMode(event.mode);

    // Mirror the change in the bloc's state so the radio row rebuilds.
    emit(AppearanceState(mode: event.mode));
  }
}