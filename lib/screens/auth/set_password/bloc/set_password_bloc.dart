import 'package:flutter_bloc/flutter_bloc.dart';

import 'set_password_event.dart';
import 'set_password_state.dart';

class SetPasswordBloc extends Bloc<SetPasswordEvent, SetPasswordState> {
  SetPasswordBloc() : super(const SetPasswordState()) {
    on<SetPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<SetConfirmPasswordVisibilityToggled>(
      _onConfirmPasswordVisibilityToggled,
    );
  }

  void _onPasswordVisibilityToggled(
    SetPasswordVisibilityToggled event,
    Emitter<SetPasswordState> emit,
  ) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void _onConfirmPasswordVisibilityToggled(
    SetConfirmPasswordVisibilityToggled event,
    Emitter<SetPasswordState> emit,
  ) {
    emit(
      state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
    );
  }
}
