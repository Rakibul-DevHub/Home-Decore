import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(const WelcomeState()) {
    on<WelcomePasswordVisibilityToggled>(_onPasswordVisibilityToggled);
  }

  void _onPasswordVisibilityToggled(
    WelcomePasswordVisibilityToggled event,
    Emitter<WelcomeState> emit,
  ) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
}
