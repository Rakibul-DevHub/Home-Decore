import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/password_security_data.dart';
import 'password_security_event.dart';
import 'password_security_state.dart';

class PasswordSecurityBloc
    extends Bloc<PasswordSecurityEvent, PasswordSecurityState> {
  PasswordSecurityBloc() : super(const PasswordSecurityState()) {
    on<PasswordSecurityActionPressed>(_onActionPressed);
  }

  Future<void> _onActionPressed(
      PasswordSecurityActionPressed event,
      Emitter<PasswordSecurityState> emit,
      ) async {
    switch (event.action) {
      case SecurityAction.changePassword:
      // TODO: navigate to the change-password flow.
        break;
      case SecurityAction.setupTwoFactor:
      // TODO: open the 2FA setup flow.
        break;
      case SecurityAction.viewLoginActivity:
      // TODO: navigate to login-activity screen.
        break;
      case SecurityAction.logoutOtherDevices:
      // TODO: call the API to revoke all other sessions.
        break;
    }
  }
}