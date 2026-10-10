import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/deactivate_account_data.dart';
import 'deactivate_account_event.dart';
import 'deactivate_account_state.dart';

class DeactivateAccountBloc
    extends Bloc<DeactivateAccountEvent, DeactivateAccountState> {
  DeactivateAccountBloc() : super(const DeactivateAccountState()) {
    on<DeactivateAccountPasswordChanged>(_onPasswordChanged);
    on<DeactivateAccountPasswordVisibilityToggled>(_onVisibilityToggled);
    on<DeactivateAccountSubmitted>(_onDeactivateSubmitted);
    on<DeactivateAccountDeleteConfirmed>(_onDeleteConfirmed);
  }

  void _onPasswordChanged(
    DeactivateAccountPasswordChanged event,
    Emitter<DeactivateAccountState> emit,
  ) {
    emit(state.copyWith(password: event.value, clearPasswordError: true));
  }

  void _onVisibilityToggled(
    DeactivateAccountPasswordVisibilityToggled event,
    Emitter<DeactivateAccountState> emit,
  ) {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> _onDeactivateSubmitted(
    DeactivateAccountSubmitted event,
    Emitter<DeactivateAccountState> emit,
  ) async {
    emit(state.copyWith(submitting: true));
    await Future<void>.delayed(const Duration(milliseconds: 280));
    emit(state.copyWith(submitting: false, deactivateSucceeded: true));
  }

  Future<void> _onDeleteConfirmed(
    DeactivateAccountDeleteConfirmed event,
    Emitter<DeactivateAccountState> emit,
  ) async {
    final password = state.password.trim();
    if (password.isEmpty) {
      emit(state.copyWith(passwordError: 'Enter your password to continue.'));
      return;
    }
    if (password != DeactivateAccountData.demoPassword) {
      emit(
        state.copyWith(passwordError: 'The password you entered is incorrect.'),
      );
      return;
    }
    emit(state.copyWith(submitting: true, clearPasswordError: true));
    await Future<void>.delayed(const Duration(milliseconds: 280));
    emit(state.copyWith(submitting: false, deleteSucceeded: true));
  }
}
