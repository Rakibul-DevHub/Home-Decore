import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_information_event.dart';
import 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  AccountInformationBloc() : super(AccountInformationState.initial) {
    on<AccountFullNameChanged>(_onFullNameChanged);
    on<AccountEmailChanged>(_onEmailChanged);
    on<AccountPhoneChanged>(_onPhoneChanged);
    on<AccountPasswordChanged>(_onPasswordChanged);
    on<AccountPasswordChangeRequested>(_onPasswordChangeRequested);
    on<AccountSaveRequested>(_onSave);
    on<AccountSaveCompleted>(_onSaveCompleted);
  }

  void _onFullNameChanged(
      AccountFullNameChanged event,
      Emitter<AccountInformationState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(fullName: event.value)));
  }

  void _onEmailChanged(
      AccountEmailChanged event,
      Emitter<AccountInformationState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(email: event.value)));
  }

  void _onPhoneChanged(
      AccountPhoneChanged event,
      Emitter<AccountInformationState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(phone: event.value)));
  }

  void _onPasswordChanged(
      AccountPasswordChanged event,
      Emitter<AccountInformationState> emit,
      ) {
    emit(state.copyWith(draft: state.draft.copyWith(password: event.value)));
  }

  void _onPasswordChangeRequested(
      AccountPasswordChangeRequested event,
      Emitter<AccountInformationState> emit,
      ) {
    // TODO: navigate to the password-change flow.
  }

  Future<void> _onSave(
      AccountSaveRequested event,
      Emitter<AccountInformationState> emit,
      ) async {
    if (!state.canSave) return;
    emit(state.copyWith(saving: true));

    // Simulated network round-trip. Replace with a real API call.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (isClosed) return;

    add(const AccountSaveCompleted());
  }

  void _onSaveCompleted(
      AccountSaveCompleted event,
      Emitter<AccountInformationState> emit,
      ) {
    emit(
      state.copyWith(
        original: state.draft,
        saving: false,
      ),
    );
  }
}