import 'package:flutter_bloc/flutter_bloc.dart';

typedef NewPasswordState = ({
  bool passwordVisible,
  bool confirmPasswordVisible,
});

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit()
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
