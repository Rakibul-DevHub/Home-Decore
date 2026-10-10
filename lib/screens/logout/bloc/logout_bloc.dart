import 'package:flutter_bloc/flutter_bloc.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(const LogoutState()) {
    on<LogoutConfirmed>(_onConfirmed);
  }

  Future<void> _onConfirmed(
      LogoutConfirmed event,
      Emitter<LogoutState> emit,
      ) async {
    emit(state.copyWith(loggingOut: true));

    // TODO: clear the auth token, revoke the session, clear local user
    // cache. The BlocListener in the screen handles navigation once this
    // completes.
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}