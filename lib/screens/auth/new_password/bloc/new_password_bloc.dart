import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_password_event.dart';
import 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc() : super(const NewPasswordState()) {
    on<NewPasswordVisibilityToggled>(_onPasswordVisibilityToggled);
    on<NewConfirmPasswordVisibilityToggled>(
      _onConfirmPasswordVisibilityToggled,
    );
  }

  void _onPasswordVisibilityToggled(
    NewPasswordVisibilityToggled event,
    Emitter<NewPasswordState> emit,
  ) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void _onConfirmPasswordVisibilityToggled(
    NewConfirmPasswordVisibilityToggled event,
    Emitter<NewPasswordState> emit,
  ) {
    emit(
      state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible),
    );
  }
}
