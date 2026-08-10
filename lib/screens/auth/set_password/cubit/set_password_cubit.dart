import 'package:flutter_bloc/flutter_bloc.dart';

typedef SetPasswordState = ({
  bool passwordVisible,
  bool confirmPasswordVisible,
});

class SetPasswordCubit extends Cubit<SetPasswordState> {
  SetPasswordCubit()
    : super((passwordVisible: false, confirmPasswordVisible: false));

  void togglePasswordVisibility() {
    emit((
      passwordVisible: !state.passwordVisible,
      confirmPasswordVisible: state.confirmPasswordVisible,
    ));
  }

  void toggleConfirmPasswordVisibility() {
    emit((
      passwordVisible: state.passwordVisible,
      confirmPasswordVisible: !state.confirmPasswordVisible,
    ));
  }
}
